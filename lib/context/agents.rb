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

require 'singleton'

module Context
  class Agents
    include FileUtils
    include Singleton

    START_COMMAND = OS.windows? ? %w(cmd /c start-agent.bat) : './agent.sh'
    STOP_COMMAND = OS.windows? ? %w(cmd /c stop-agent.bat) : './stop-agent.sh'

    def initialize()
      @agent_wrk_dirs = []
    end

    def start_an_agent_in(dir)
      raise "Agent already running in the directory #{dir}" if File.exist?("#{dir}/.agent-bootstrapper.running")
      rm_rf(dir)

      mkdir_p dir
      cp_r "#{GoConstants::AGENT_DIR}/.", "#{dir}/"
      Bundler.with_clean_env do
        process = ChildProcess.build(START_COMMAND)
        process.detach = true
        process.environment['GO_AGENT_SYSTEM_PROPERTIES'] = GoConstants::GO_AGENT_SYSTEM_PROPERTIES
        process.environment['GO_SERVER_URL'] = "https://127.0.0.1:#{GoConstants::SERVER_SSL_PORT}/go"
        process.environment['VNC'] = 'N'
        process.environment['STOP_BEFORE_STARTUP'] = 'N'
        process.environment['PRODUCTION_MODE'] = 'N'
        process.environment['MANUAL_SETTING'] = 'Y'
        process.environment['DAEMON'] = 'Y'
        process.cwd = dir
        process.start
      end
    end

    def create_agents(count)
      (1..count.to_i).each do |n|
        start_an_agent_in "#{GoConstants::GAUGE_AGENT_DIR}/agent-#{n}"
        @agent_wrk_dirs << "#{GoConstants::GAUGE_AGENT_DIR}/agent-#{n}"
      end
    end

    def get_working_dirs
      @agent_wrk_dirs
    end

    def destroy_agents(count)
      (1..count.to_i).each do |n|
        Bundler.with_clean_env do
          process = ChildProcess.build(STOP_COMMAND)
          process.detach = true
          process.environment['PID_FILE'] = "go-agent.pid"
          process.environment['MANUAL_SETTING'] = 'Y'
          process.environment['DAEMON'] = 'Y'
          process.cwd = "#{GoConstants::GAUGE_AGENT_DIR}/agent-#{n}"
          process.start
          begin
            process.poll_for_exit(10)
          rescue ChildProcess::TimeoutError
            process.stop
          end
        end
      end
      rm_rf(GoConstants::GAUGE_AGENT_DIR)
      @agent_wrk_dirs.clear
    end
  end
end
