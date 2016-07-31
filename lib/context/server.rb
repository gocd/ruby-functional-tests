##########################################################################
# Copyright 2016 ThoughtWorks, Inc.
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
    START_COMMAND = OS.windows? ? %w(cmd /c start-server.bat) : './server.sh'
    STOP_COMMAND = OS.windows? ? %w(cmd /c stop-server.bat) : './stop-server.sh'
    DEVELOPMENT_MODE = !ENV['GO_PIPELINE_NAME']

    def start
      return if DEVELOPMENT_MODE && server_is_running
      Bundler.with_clean_env do
        process = ChildProcess.build(START_COMMAND)
        process.detach = true
        process.environment.merge!('GO_SERVER_SYSTEM_PROPERTIES' => GoConstants::GO_SERVER_SYSTEM_PROPERTIES,
                                   'GO_SERVER_PORT' => GoConstants::SERVER_PORT,
                                   'GO_SERVER_SSL_PORT' => GoConstants::SERVER_SSL_PORT,
                                   'SERVER_MEM' => GoConstants::SERVER_MEM,
                                   'SERVER_MAX_MEM' => GoConstants::SERVER_MAX_MEM,
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
        Bundler.with_clean_env do
          process = ChildProcess.build(STOP_COMMAND)
          process.detach = true
          process.cwd = GoConstants::SERVER_DIR
          process.start
        end
      end
    end

    def server_is_running
      true if ping_server.code == 200
    rescue => e
      puts "Server is not running. Ping to server returned #{e.message}"
      false
    end

    def ping_server
      RestClient.get("#{GoConstants::GO_SERVER_BASE_URL}/admin/agent")
    end

    def wait_to_start
      Timeout.timeout(120) do
        loop do
          begin
            break if ping_server.code == 200
          rescue Errno::ECONNREFUSED
            sleep 5
          end
        end
      end
    end
  end
end
