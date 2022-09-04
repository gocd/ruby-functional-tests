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
  class YumRepo

    include FileUtils

    YUM_REPO_DIRECTORY_PATH = '/tmp/packagerepo'
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
        Bundler.with_original_env do
            process = ChildProcess.build('/usr/bin/createrepo', "#{YUM_REPO_DIRECTORY_PATH}/#{name}")
            process.detach = true
            process.io.stdout = process.io.stderr = out
            process.cwd = "#{YUM_REPO_DIRECTORY_PATH}/#{name}"
            process.start
        end
    end

    def remove_repo(repo_name)
        rm_rf("#{YUM_REPO_DIRECTORY_PATH}/#{repo_name}") if Dir.exist?("#{YUM_REPO_DIRECTORY_PATH}/#{repo_name}")
    end
  end
end
