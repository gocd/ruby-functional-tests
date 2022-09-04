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
  class Agents
    include FileUtils
    include Singleton

    START_COMMAND = OS.windows? ? %w[cmd /c start-go-agent-service.bat] : 'bin/go-agent'
    STOP_COMMAND = OS.windows? ? %w[cmd /c stop-go-agent-service.bat] : 'bin/go-agent'
    attr_accessor :agent_wrk_dirs

    def initialize
      @agent_wrk_dirs = []
    end

    def start_an_agent_in(dir)
      rm_rf(dir)
      mkdir_p dir
      cp_r "#{GoConstants::AGENT_DIR}/.", "#{dir}/"
      prepare_wrapper_conf(dir.to_s, GoConstants::GO_AGENT_SYSTEM_PROPERTIES)
      Bundler.with_original_env do
        process = ChildProcess.build('./with-reset-db-if-necessary.sh', START_COMMAND, 'start', '-serverUrl', "http://127.0.0.1:#{GoConstants::SERVER_PORT}/go")
        process.detach = true
        process.environment['GO_PIPELINE_COUNTER'] = GoConstants::GO_PIPELINE_COUNTER
        process.cwd = dir
        process.start
      end
    end

    def prepare_wrapper_conf(agent_loc, properties)
      File.open("#{agent_loc}/wrapper-config/wrapper-properties.conf", 'w') do |file|
        properties.each_with_index{|item, index|
          file.puts("wrapper.java.additional.#{index.to_i + 100}=#{item}")
        }
      end
    end

    def create_agents(count)
      (1..count.to_i).each do |n|
        create_agent(n)
      end
    end

    def create_stopjob(filename)
      agent_wrk_dirs.each { |agent_dir| FileUtils.touch "#{agent_dir}/#{filename}" }
    end

    def delete_stopjob(filename)
      agent_wrk_dirs.each { |agent_dir| File.delete("#{agent_dir}/#{filename}") if File.exist?("#{agent_dir}/#{filename}") }
    end

    def delete_stopjobs
      delete_stopjob("stopjob")
      delete_stopjob("failjob")
    end

    def destroy_agents(count)
      (1..count.to_i).each do |n|
        destroy_agent(n)
      end
      rm_rf(GoConstants::GAUGE_AGENT_DIR)
      @agent_wrk_dirs.clear
    end

    private

    def run_agent_on_docker(identifier)
      manifest = DockerManifestParser.new('target/docker-agent')
      image_index = ENV['GO_JOB_RUN_INDEX'] ? ENV['GO_JOB_RUN_INDEX'].to_i - 1 : 0
      manifest.image_info_at(image_index)
      sh %(docker load < "target/docker-agent/#{manifest.file}")
      sh %(docker rm -f agent_#{identifier} || true)
      sh %(docker run -d \
        --name agent_#{identifier} \
        -v #{GoConstants::TEMP_DIR}:/materials \
        -e GO_AGENT_SYSTEM_PROPERTIES='#{GoConstants::GO_AGENT_SYSTEM_PROPERTIES.join(" ")}' \
        -e GO_SERVER_URL='http://#{GoConstants::IPADDRESS}:#{GoConstants::SERVER_PORT}/go' \
        -e AGENT_AUTO_REGISTER_KEY='functional-tests' \
        #{manifest.image}:#{manifest.tag})
        # This is done to save space on the EA container
        # Will have to remove it if we want to start multiple agents for single spec
        sh %(rm -rf target/docker-agent/#{manifest.file})
    end

    def create_agent(n)
      if GoConstants::RUN_ON_DOCKER
        run_agent_on_docker(n)
        return
      end
      agent_directory = "#{GoConstants::GAUGE_AGENT_DIR}/agent-#{n}"
      if File.exist?("#{agent_directory}/.agent-bootstrapper.running")
        destroy_agent(n)
      end
      start_an_agent_in agent_directory
      @agent_wrk_dirs << agent_directory
    end

    def destroy_agent(n)
      if GoConstants::RUN_ON_DOCKER
        sh %(docker rm -f agent_#{n} || true)
        return
      end
      Bundler.with_original_env do
        process = ChildProcess.build('./with-reset-db-if-necessary.sh', STOP_COMMAND, 'stop')
        process.detach = true
        process.environment['PID_FILE'] = 'go-agent.pid'
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
  end
end
