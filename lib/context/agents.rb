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
  class Agents
    include FileUtils
    START_COMMAND = OS.windows? ? %w(cmd /c start-agent.bat) : './agent.sh'
    STOP_COMMAND = OS.windows? ? %w(cmd /c stop-agent.bat) : './stop-agent.sh'

    def initialize
      @gauge_agent_dir = 'target/gauge_agents'
    end

    def start_an_agent_in(dir)
      raise "Agent already running in the directory #{dir}" if File.exist?("#{dir}/.agent-bootstrapper.running")
      rm_rf(dir)

      mkdir_p dir
      cp_r "#{GoConstants::AGENT_DIR}/.", "#{dir}/"
      Bundler.with_clean_env do
        process = ChildProcess.build(START_COMMAND)
        process.environment['GO_AGENT_SYSTEM_PROPERTIES'] = GoConstants::GO_AGENT_SYSTEM_PROPERTIES
        process.environment['GO_SERVER'] = '127.0.0.1'
        process.environment['GO_SERVER_URL'] = "https://127.0.0.1:#{GoConstants::SERVER_SSL_PORT}/go"
        process.environment['VNC'] = 'N'
        process.environment['STOP_BEFORE_STARTUP'] = 'N'
        process.environment['PRODUCTION_MODE'] = 'N'
        process.environment['GO_SERVER_PORT'] = GoConstants::SERVER_PORT
        process.environment['GO_SERVER_SSH_PORT'] = GoConstants::SERVER_SSL_PORT
        # process.environment['PID_FILE'] = 'process.pid'
        process.environment['MANUAL_SETTING'] = 'Y'
        process.environment['DAEMON'] = 'Y'
        process.cwd = dir
        process.start
      end
    end

    def create_agents(count)
      (1..count.to_i).each do |n|
        start_an_agent_in "#{@gauge_agent_dir}/agent-#{n}"
      end
    end

    def destroy_agents(count)
      (1..count.to_i).each do |n|
        Bundler.with_clean_env do
          process = ChildProcess.build(STOP_COMMAND)
          # process.environment['PID_FILE'] = 'process.pid'
          process.cwd = "#{@gauge_agent_dir}/agent-#{n}"
          process.start
        end
      end
      rm_rf(@gauge_agent_dir)
    end
  end
end
