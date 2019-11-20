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
  class YumRepo

    include FileUtils

    YUM_REPO_DIRECTORY_PATH = 'tools/jetty-8/webapps'
    JETTY_ROOT_DIRECTORY = 'tools/jetty-8'
    YUM_FILES_DIRECTORY = 'test-repos/yumrepo'


    def run_or_bomb(command)
      stdout, stdeerr, status = Open3.capture3(command)
      raise "Command #{command} failed with error #{stdeerr}" unless status.success?
      stdout
    end

    def create_new_repo_as(name)
        remove_repo(name)
        mkdir_p "#{YUM_REPO_DIRECTORY_PATH}/#{name}"
        cp_r "#{YUM_FILES_DIRECTORY}/revision-one/*.rpm", "#{YUM_REPO_DIRECTORY_PATH}/#{name}"
        binding.pry
        cd("#{YUM_REPO_DIRECTORY_PATH}/#{name}") do
            sh '/usr/bin/createrepo .'
        end
    end

    def start_jetty_server
        cd (JETTY_ROOT_DIRECTORY) do
            run_or_bomb "java -jar start.jar jetty.port=8081"
        end
    end

    def publish_new_artifact_to(repo)
        cp_r "#{YUM_FILES_DIRECTORY}/revision-two/*.rpm" "#{YUM_REPO_DIRECTORY_PATH}/#{repo}"
        cd("#{YUM_REPO_DIRECTORY_PATH}/#{name}") do
            sh '/usr/bin/createrepo --update .'
        end
    end

    def stop_jetty_server
        sh "kill -9 $(lsof -i :8081 -t) 2> /dev/null"
    end

    def remove_repo(repo_name)
        rm_rf("#{YUM_REPO_DIRECTORY_PATH}/#{repo_name}") if Dir.exist?("#{YUM_REPO_DIRECTORY_PATH}/#{repo_name}")
    end

    def clean_repo_query_cache_directory
    end
  end
end
