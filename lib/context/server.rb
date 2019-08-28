##########################################################################
# Copyright 2019 ThoughtWorks, Inc.
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
    DEVELOPMENT_MODE = !ENV['GO_PIPELINE_NAME']

    def start
      if GoConstants::RUN_ON_DOCKER
        mkdir_p(GoConstants::TEMP_DIR)
        run_server_on_docker
        return
      end

      return if DEVELOPMENT_MODE && server_running?

      cp 'resources/with-java.sh', GoConstants::SERVER_DIR
      mkdir_p "#{GoConstants::SERVER_DIR}/logs"
      out = File.open("#{GoConstants::SERVER_DIR}/logs/output.log", 'w')
      out.sync = true
      chmod 0o755, "#{GoConstants::SERVER_DIR}/with-java.sh"
      prepare_wrapper_conf(GoConstants::GO_SERVER_SYSTEM_PROPERTIES)
      Bundler.with_clean_env do
        process = ChildProcess.build('./with-java.sh', START_COMMAND, 'start')
        process.detach = true
        process.io.stdout = process.io.stderr = out
        process.environment['GO_PIPELINE_COUNTER'] = GoConstants::GO_PIPELINE_COUNTER
        process.cwd = GoConstants::SERVER_DIR
        process.start
      end
    end

    def stop
      if DEVELOPMENT_MODE
        puts 'Running test in development mode so not stopping the server........'
      else
        if GoConstants::RUN_ON_DOCKER
          sh %(docker rm -f gauge_server || true)
          return
        end
        Bundler.with_clean_env do
          process = ChildProcess.build('./with-java.sh', STOP_COMMAND, 'stop')
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
      sleep 5
      ping_server.code == 200
    rescue StandardError => e
      p "server ping request failed with error #{e.message}"
      false
    end

    def ping_server
      RestClient.get("#{GoConstants::GO_SERVER_BASE_URL}/about") do |response, _request, _result|
        p "Server ping failed with response code #{response.code} and message #{response.body}" unless response.code == 200
        return response
      end
    end

    def wait_to_start
      Timeout.timeout(180) do
        loop do
          begin
            break if server_running?
          rescue Errno::ECONNREFUSED
            sleep 5
          end
        end
      end
    end

    def run_server_on_docker
      image = server_image_to_use
      sh %(docker load < "target/docker-server/#{image.file}")

      # The if-else block is added to accomodate the mount of .gitconfig. This is needed to avoid a bug with jgit where it does not by default support atomic link creation

      if ENV['USE_AFS']
        sh %(docker run -d --name gauge_server -p #{GoConstants::SERVER_PORT}:#{GoConstants::SERVER_PORT} \
          -p #{GoConstants::SERVER_SSL_PORT}:#{GoConstants::SERVER_SSL_PORT} \
          -v #{File.expand_path(GoConstants::CONFIG_PATH.to_s)}:/test-config --mount type=bind,source=#{GoConstants::SERVER_DIR},target=/godata \
          -v /root/.gitconfig:/home/go/.gitconfig \
          -v #{GoConstants::TEMP_DIR}:/materials \
          -e GOCD_SERVER_JVM_OPTS='#{GoConstants::GO_SERVER_SYSTEM_PROPERTIES.join(' ')}' \
          #{image.image}:#{image.tag})
      else
        sh %(docker run -d --name gauge_server -p #{GoConstants::SERVER_PORT}:#{GoConstants::SERVER_PORT} \
          -p #{GoConstants::SERVER_SSL_PORT}:#{GoConstants::SERVER_SSL_PORT} \
          -v #{File.expand_path(GoConstants::CONFIG_PATH.to_s)}:/test-config --mount type=bind,source=#{GoConstants::SERVER_DIR},target=/godata \
          -v #{GoConstants::TEMP_DIR}:/materials \
          -e GOCD_SERVER_JVM_OPTS='#{GoConstants::GO_SERVER_SYSTEM_PROPERTIES.join(' ')}' \
          #{image.image}:#{image.tag})
      end
      # This is done to save space on the EA container
      sh %(rm -rf target/docker-server)
    end

    def server_image_to_use
      manifest = DockerManifestParser.new('target/docker-server')
      if ENV['RUN_ON_ALL_SERVER_IMAGE']
        image_index = ENV['GO_JOB_RUN_INDEX'] ? ENV['GO_JOB_RUN_INDEX'].to_i - 1 : 0
        manifest.image_info_at(image_index)
      else
        manifest.image_info_of('centos-7')
      end
      manifest
    end
  end

  class DockerManifestParser
    attr_reader :image
    attr_reader :tag
    attr_reader :file

    def initialize(fldr)
      @fldr = fldr
    end

    def image_info_of(os)
      raise "Docker image manifest file not available at #{@fldr}" unless File.exist?("#{@fldr}/manifest.json")
      manifest = JSON.parse(File.read("#{@fldr}/manifest.json"))
      image_info = manifest.select { |image| image['imageName'].include? os }
      raise "No image for OS #{os} available" if image_info.nil?
      @image = image_info.first['imageName']
      @tag = image_info.first['tag']
      @file = image_info.first['file']
    end

    def image_info_at(position)
      raise "Docker image manifest file not available at #{@fldr}" unless File.exist?("#{@fldr}/manifest.json")
      manifest = JSON.parse(File.read("#{@fldr}/manifest.json"))
      image_info = manifest[position]
      @image = image_info['imageName']
      @tag = image_info['tag']
      @file = image_info['file']
    end
  end
end
