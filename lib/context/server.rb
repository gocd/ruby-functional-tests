##########################################################################
# Copyright 2022 Thoughtworks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################################################################

module Context
  class Server
    include FileUtils

    START_COMMAND = OS.windows? ? %w[cmd /c bin/start-go-server-service.bat start] : 'bin/go-server'
    STOP_COMMAND = OS.windows? ? %w[cmd /c bin/stop-go-server-service.bat stop] : 'bin/go-server'

    def start
      if GoConstants::RUN_ON_DOCKER
        mkdir_p(GoConstants::TEMP_DIR)
        run_server_on_docker
        return
      end

      return if GoConstants::DEVELOPMENT_MODE && server_running?

      cp 'resources/with-reset-db-if-necessary.sh', GoConstants::SERVER_DIR
      cp 'resources/db/db.properties', GoConstants::SERVER_DIR
      mkdir_p "#{GoConstants::SERVER_DIR}/logs"
      log_location = "#{GoConstants::SERVER_DIR}/logs/output.log"
      out = File.open(log_location, 'w')
      out.sync = true
      chmod 0o755, "#{GoConstants::SERVER_DIR}/with-reset-db-if-necessary.sh"
      prepare_wrapper_conf(GoConstants::GO_SERVER_SYSTEM_PROPERTIES)

      STDERR.puts "Attempting to start GoCD server in: #{GoConstants::SERVER_DIR}. Logs will be in #{log_location}"
      Bundler.with_original_env do
        process = ChildProcess.build('./with-reset-db-if-necessary.sh', START_COMMAND, 'start')
        process.detach = true
        process.io.stdout = process.io.stderr = out
        process.environment['GO_PIPELINE_COUNTER'] = GoConstants::GO_PIPELINE_COUNTER
        process.cwd = GoConstants::SERVER_DIR
        process.start
      end
    end

    def restart
      log_location = "#{GoConstants::SERVER_DIR}/logs/output.log"
      out = File.open(log_location, 'a')
      out.sync = true
      properties = GoConstants::GO_SERVER_SYSTEM_PROPERTIES
      properties.push(ENV['ADDITIONAL_SERVER_SYSTEM_PROPERTIES'])
      prepare_wrapper_conf(properties)

      STDERR.puts "Attempting to re-start GoCD server in: #{GoConstants::SERVER_DIR}.}"
      Bundler.with_original_env do
        process = ChildProcess.build(START_COMMAND, 'restart')
        process.detach = true
        process.io.stdout = process.io.stderr = out
        process.environment['GO_PIPELINE_COUNTER'] = GoConstants::GO_PIPELINE_COUNTER
        process.cwd = GoConstants::SERVER_DIR
        process.start
      end
    end

    def stop
      if GoConstants::DEVELOPMENT_MODE
        puts 'Running test in development mode so not stopping the server........'
      else
        if GoConstants::RUN_ON_DOCKER
          sh %(docker rm -f gauge_server || true)
          return
        end
        Bundler.with_original_env do
          process = ChildProcess.build('./with-reset-db-if-necessary.sh', STOP_COMMAND, 'stop')
          process.detach = true
          process.cwd = GoConstants::SERVER_DIR
          process.start
          begin
            process.poll_for_exit(10)
          rescue ChildProcess::TimeoutError
            process.stop
          end
        end
      end
    end

    def prepare_wrapper_conf(properties)
      File.open("#{GoConstants::SERVER_DIR}/wrapper-config/wrapper-properties.conf", 'w') do |file|
        properties.each_with_index  do |item, index|
          file.puts("wrapper.java.additional.#{index.to_i + 100}=#{item}")
        end
        if ENV['FANINOFF'] == 'true'
          file.puts("wrapper.java.additional.#{properties.size + 101}=-Dresolve.fanin.revisions=N")
        end
      end
    end

    def server_running?
      sleep 1
      ping_server.code == 200
    rescue StandardError => e
      false
    end

    def ping_server
      begin
        RestClient::Request.execute method: :get, url:  "#{GoConstants::GO_SERVER_BASE_URL}/about", headers: basic_configuration.header, timeout: 10 do |response, _request, _result|
          p "Server ping failed with response code #{response.code} and message #{response.body}" unless response.code == 200
          return response
        end
      rescue => e
        STDERR.puts "#{Time.now} Failed while trying to ping GoCD server: #{e}"
      end
    end

    def wait_to_start
      Timeout.timeout(300) do
        loop do
          begin
            break if server_running?
          rescue Errno::ECONNREFUSED
            sleep 1
          end
        end
      end
    end

    def run_server_on_docker
      manifest = server_image_to_use
      oci_folder = "target/docker-server/oci-#{manifest.image.gsub('.', '-')}"

      sh %(regctl image import ocidir://#{oci_folder}:#{manifest.tag} "target/docker-server/#{manifest.file}")
      sh %(rm -rf target/docker-server/*.tar)
      sh %(regctl image export --name #{manifest.image}:#{manifest.tag} --platform local ocidir://#{oci_folder}:#{manifest.tag} "target/docker-server/native-#{manifest.file}")
      sh %(rm -rf #{oci_folder})
      sh %(docker load < "target/docker-server/native-#{manifest.file}")
      sh %(rm -rf target/docker-server)

      sh %(docker run -d --name gauge_server -p #{GoConstants::SERVER_PORT}:#{GoConstants::SERVER_PORT} \
        -v #{File.expand_path(GoConstants::CONFIG_PATH.to_s)}:/test-config --mount type=bind,source=#{GoConstants::SERVER_DIR},target=/godata \
        -v #{GoConstants::TEMP_DIR}:/materials \
        -e GOCD_SERVER_JVM_OPTS='#{GoConstants::GO_SERVER_SYSTEM_PROPERTIES.join(' ')}' \
        #{manifest.image}:#{manifest.tag})
    end

    def server_image_to_use
      manifest = DockerManifestParser.new('target/docker-server')
      if ENV['RUN_ON_ALL_SERVER_IMAGE']
        unless manifest.has_image_count?(ENV['GO_JOB_RUN_COUNT'].to_i)
          raise "Expected job to be configured with GO_JOB_RUN_COUNT=#{manifest.image_count} (current=#{ENV['GO_JOB_RUN_COUNT']}) as manifest implies that's how many server images we have to test on #{RUBY_PLATFORM}"
        end
        image_index = (ENV['GO_JOB_RUN_INDEX']&.to_i || 1) - 1
        manifest.image_info_at(image_index)
      else
        manifest.image_info_at(0)
      end
      manifest
    end
  end
end
