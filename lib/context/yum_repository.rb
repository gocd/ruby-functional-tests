##########################################################################
# Copyright 2018 ThoughtWorks, Inc.
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
  class YumRepo

    def initialize(yum_repo_directory_path='tools/jetty-8/webapps',
                   jetty_root_directory='tools/jetty-8',
                   yum_files_directory='test-repos/yumrepo')
    end

    def run_or_bomb(command)
      stdout, stdeerr, status = Open3.capture3(command)
      raise "Command #{command} failed with error #{stdeerr}" unless status.success?
      stdout
    end

    def create_new_repo_as(name)
        remove_repo(name)
        mkdir_p "#{yum_repo_directory_path}/#{name}"
        cp_r "#{yum_files_directory}/revision-one" "#{yum_repo_directory_path}/#{name}"
        cd("#{yum_repo_directory_path}/#{name}") do
            sh '/usr/bin/crearerepo .'
        end
    end

    def start_jetty_server
        cd (jetty_root_directory) do
            run_or_bomb "java -jar start.jar jetty.port=8081"
        end
    end

    def publish_new_artifact_to(repo)
        cp_r "#{yum_files_directory}/revision-one" "#{yum_repo_directory_path}/#{repo}"
        cd("#{yum_repo_directory_path}/#{name}") do
            sh '/usr/bin/crearerepo --update .'
        end
    end

    def stop_jetty_server
        sh "kill -9 $(lsof -i :8081 -t) 2> /dev/null"
    end

    def remove_repo(repo_name)
        rm_rf("#{yum_repo_directory_path}/#{name}") if dir.exists("#{yum_repo_directory_path}/#{name}")
    end

    def clean_repo_query_cache_directory
    end
  end
end
