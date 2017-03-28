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
  class GoState
    include FileUtils

    def capture_logs(path)
      cp_r "#{GoConstants::SERVER_DIR}/go-server.out.log" , path
      cp_r "#{GoConstants::SERVER_DIR}/logs/go-server.log" , path
    end

    def capture_agents(path)
      cp_r "#{GoConstants::GAUGE_AGENT_DIR}/." , path
    end

    def capture_healthstate(path)
      begin
        response = RestClient.get health_message_url, basic_configuration.auth_header
        File.open("#{path}/health_message.json", 'w') { |file| file.write(response.body) }
      rescue => e
        File.open("#{path}/health_message.json", 'w') { |file| file.write(e.message) }
      end
    end

    def capture_cruise_config(path)
      cp_r "#{GoConstants::SERVER_DIR}/config/cruise-config.xml" , path
    end

    def capture_database(path)
      cp_r "#{GoConstants::SERVER_DIR}/db" , path
    end

    def capture_all(path)
      mkdir_p path
      capture_logs(path)
      capture_agents(path)
      capture_healthstate(path)
      capture_cruise_config(path)
      capture_database(path)
    end

  end
end
