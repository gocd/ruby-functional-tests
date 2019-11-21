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

    YUM_REPO_DIRECTORY_PATH = '/tmp/packagerepo'
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
        cp_r Dir.glob("#{YUM_FILES_DIRECTORY}/revision-one/*.rpm"), "#{YUM_REPO_DIRECTORY_PATH}/#{name}"
        out = File.open("#{GoConstants::SERVER_DIR}/logs/output.log", 'w')
        #cwd = Dir["#{YUM_REPO_DIRECTORY_PATH}/#{name}"].find { |f| File.directory?(f) }
        Bundler.with_clean_env do
            process = ChildProcess.build('/usr/bin/createrepo', "#{YUM_REPO_DIRECTORY_PATH}/#{name}")
            process.detach = true
            process.io.stdout = process.io.stderr = out
            process.cwd = "#{YUM_REPO_DIRECTORY_PATH}/#{name}"
            process.start
        end
    end

    # This method is not need, use it if thinking of adding spec for http based repo
    # For basic test a file based repo is good enough
    def start_jetty_server
        out = File.open("#{GoConstants::SERVER_DIR}/logs/output.log", 'w')
        Bundler.with_clean_env do
            process = ChildProcess.build('java', '-jar', 'start.jar', 'jetty.port=8081')
            process.detach = true
            process.io.stdout = process.io.stderr = out
            process.cwd = JETTY_ROOT_DIRECTORY
            process.start
        end
    end

    def stop_jetty_server
        sh "pkill -f jetty" # Not a good way to kill the process, if using it better update this
    end

    def publish_new_artifact_to(repo)
        cp_r Dir.glob("#{YUM_FILES_DIRECTORY}/revision-two/*.rpm"), "#{YUM_REPO_DIRECTORY_PATH}/#{repo}"
        out = File.open("#{GoConstants::SERVER_DIR}/logs/output.log", 'w')
        Bundler.with_clean_env do
            process = ChildProcess.build('/usr/bin/createrepo', "--update", "#{YUM_REPO_DIRECTORY_PATH}/#{repo}/")
            process.detach = true
            process.io.stdout = process.io.stderr = out
            process.cwd = "#{YUM_REPO_DIRECTORY_PATH}/#{repo}"
            process.start
        end
    end



    def remove_repo(repo_name)
        rm_rf("#{YUM_REPO_DIRECTORY_PATH}/#{repo_name}") if Dir.exist?("#{YUM_REPO_DIRECTORY_PATH}/#{repo_name}")
    end

    def clean_repo_query_cache_directory
    end
  end
end
