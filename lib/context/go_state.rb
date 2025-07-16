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
  class GoState
    include FileUtils

    def capture_logs(path)
      cp_r "#{GoConstants::SERVER_DIR}/logs", path
    end

    def capture_agents(path)
      if GoConstants::RUN_ON_DOCKER
        find_agents = 'docker ps --all --filter name=agent --format \'{{.Names}}\''
        sh %(for container_name in $(#{find_agents}); do docker logs ${container_name} > #{path}/docker-${container_name}.log 2>&1; done)
      end

      return unless Dir.exist?(GoConstants::GAUGE_AGENT_DIR.to_s)
      Dir.foreach("#{GoConstants::GAUGE_AGENT_DIR}") do |item|
        next if %w(. ..).include? item
        mkdir_p "#{path}/#{item}"
        cp_r "#{GoConstants::GAUGE_AGENT_DIR}/#{item}/config", "#{path}/#{item}"
        cp_r "#{GoConstants::GAUGE_AGENT_DIR}/#{item}/logs", "#{path}/#{item}"
        cp_r "#{GoConstants::GAUGE_AGENT_DIR}/#{item}/pipelines", "#{path}/#{item}"
        tar_rm("#{path}/#{item}", "pipelines") # Compress the pipelines as they have many small .git files and are infrequently needed
      end
    end

    def capture_healthstate(path)
      response = RestClient.get health_message_url, { accept: 'application/vnd.go.cd+json' }.merge(basic_configuration.header)
      File.open("#{path}/health_message.json", 'w') {|file| file.write(response.body)}
    rescue StandardError => e
      File.open("#{path}/health_message.json", 'w') {|file| file.write(e.message)}
    end

    def capture_cruise_config(path)
      cp_r "#{GoConstants::SERVER_DIR}/config/cruise-config.xml", path
    end

    def capture_database(path)
      begin
        cp_r "#{GoConstants::SERVER_DIR}/db", path
        tar_rm("#{path}/db", "config.git") # Compress the config repo, as it's a git repo with many small files that is a pain to artifact
      rescue => exception
        p "Failed to capture DB as part of teardown. Ignore. Not failing the test for this"
      end

    end

    def capture_all(path)
      mkdir_p path
      capture_logs(path)
      capture_agents(path)
      capture_healthstate(path)
      capture_cruise_config(path)
      capture_database(path)
    end

    private

    def tar_rm(path, directory)
      system "tar --directory=#{path} -czf #{path}/#{directory}.tar.gz #{directory}"
      rm_rf "#{path}/#{directory}"
    end
  end
end
