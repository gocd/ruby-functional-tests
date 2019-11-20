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

module Pages
  class PackageMaterialPage < AppBase

    element :package_repo_name, "#repository"
    element :add_new_package, "#addNew"
    element :package_material_name, "#material_package_definition_name"
    element :package_material_id, "#material_package_definition_configuration_0_configurationValue_value"
    element :package_material_save, "button[value='SAVE']"

    def package_repo_listed? repo_name
      page.find('a', text: repo_name)
    end

    def edit_package_repo repo_name
      page.find('a', text: repo_name).click
    end

  end
end
