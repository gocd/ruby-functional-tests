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
  class SecureConfiguration < Context::BasicConfiguration
    include FileUtils

    def copy_password_file(file)
      cp_r("#{GoConstants::CONFIG_PATH}/#{file}", "#{GoConstants::SERVER_DIR}/config/")
    end

    def replace_password_file_path(file)
      config_dom.xpath('//passwordFile').first['path'] = File.expand_path("#{GoConstants::CONFIG_PATH}/#{file}")
    end

    def setup(config_file, pwd_file)
      get_dom(config_file)
      replace_password_file_path(pwd_file)
      replace_pipeline_names
      copy_password_file(pwd_file)
      load_dom(config_dom)
      scenario_state.set_current_user 'admin'
    end
  end
end
