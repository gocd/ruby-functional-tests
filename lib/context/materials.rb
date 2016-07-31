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

require 'Open3'
module Context

  class Materials
    include FileUtils
  end

  class GitMaterials < Materials

    def initialize(*_args)
      @path = "#{GoConstants::TEMP_DIR}/gitmaterial"
    end

    def setup_material_for(pipeline)
      rm_rf(@path)
      mkdir_p(@path)
      cd(@path) do
        Open3.popen3('git init sample.git') do |_stdin, _stdout, stderr, wait_thr|
          raise "Initialization of git Material Failed. Error returned: #{stderr.read}" unless wait_thr.value.success?
        end
      end
      initial_commit
      basic_configuration.set_material_path_for_pipeline(pipeline, "#{@path}/sample.git")
    end

    def initial_commit
      cd("#{@path}/sample.git") do
        File.open('file.txt', 'w') { |file| file.write('first commit') }
        Open3.popen3(%(git add . && git commit -m "first commit")) do |_stdin, _stdout, stderr, wait_thr|
          raise "Failed to commit to git repository. Error returned: #{stderr.read}" unless wait_thr.value.success?
        end
      end
    end
  end
end
