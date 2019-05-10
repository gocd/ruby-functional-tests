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

    START_COMMAND = OS.windows? ? %w[cmd /c start-server.bat] : './server.sh'
    STOP_COMMAND = OS.windows? ? %w[cmd /c stop-server.bat] : './stop-server.sh'
    DEVELOPMENT_MODE = !ENV['GO_PIPELINE_NAME']


    def start
      if GoConstants::RUN_ON_DOCKER
        run_server_on_docker
        return
      end
      return if DEVELOPMENT_MODE && server_running?
      system_properties = if ENV['FANINOFF'] == 'true'
                            "#{GoConstants::GO_SERVER_SYSTEM_PROPERTIES} -Dresolve.fanin.revisions=N"
                          else
                            GoConstants::GO_SERVER_SYSTEM_PROPERTIES
                          end
      cp 'resources/with-java.sh', GoConstants::SERVER_DIR
      chmod 0o755, "#{GoConstants::SERVER_DIR}/with-java.sh"
      Bundler.with_clean_env do
        process = ChildProcess.build('./with-java.sh', START_COMMAND)
        process.detach = true
        process.environment.merge!('GO_SERVER_SYSTEM_PROPERTIES' => system_properties,
                                   'GO_SERVER_PORT' => GoConstants::SERVER_PORT,
                                   'GO_SERVER_SSL_PORT' => GoConstants::SERVER_SSL_PORT,
                                   'SERVER_MEM' => GoConstants::SERVER_MEM,
                                   'SERVER_MAX_MEM' => GoConstants::SERVER_MAX_MEM,
                                   'GO_PIPELINE_COUNTER' => GoConstants::GO_PIPELINE_COUNTER,
                                   'MANUAL_SETTING' => 'Y',
                                   'DAEMON' => 'Y',
                                   'PRODUCTION_MODE' => 'N')

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
          process = ChildProcess.build('./with-java.sh', STOP_COMMAND)
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

    def server_running?
      sleep 5
      ping_server.code == 200
    rescue StandardError => e
      false
    end

    def ping_server
      RestClient.get("#{GoConstants::GO_SERVER_BASE_URL}/about")
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
      manifest = DockerManifestParser.new('target/docker-server')
      manifest.image_info_of('centos-7')
      mkdir_p(GoConstants::TEMP_DIR)
      sh %(docker load < "target/docker-server/#{manifest.file}")
      sh %(docker run -d --name gauge_server -p #{GoConstants::SERVER_PORT}:#{GoConstants::SERVER_PORT} \
        -p #{GoConstants::SERVER_SSL_PORT}:#{GoConstants::SERVER_SSL_PORT} \
        -v #{File.expand_path(GoConstants::CONFIG_PATH.to_s)}:/test-config --mount #{GoConstants::SERVER_DIR}:/godata \
        -v #{GoConstants::TEMP_DIR}:/materials \
        -e GO_SERVER_SYSTEM_PROPERTIES='#{GoConstants::GO_SERVER_SYSTEM_PROPERTIES}' \
        -e GO_SERVER_PORT='#{GoConstants::SERVER_PORT}' \
        -e GO_SERVER_SSL_PORT='#{GoConstants::SERVER_SSL_PORT}' \
        -e SERVER_MEM='#{GoConstants::SERVER_MEM}' \
        -e SERVER_MAX_MEM='#{GoConstants::SERVER_MAX_MEM}' \
        #{manifest.image}:#{manifest.tag})
      # This is done to save space on the EA container
      sh %(rm -rf target/docker-server)
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
