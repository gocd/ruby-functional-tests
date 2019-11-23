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
  class PackageRepositoryPage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/package_repositories/new"

    element :package_repo_name, "#package_repository_name"
    element :package_repo_url, "#package_repository_configuration_0_configurationValue_value"
    element :package_repo_username, "#package_repository_configuration_1_configurationValue_value"
    element :package_repo_password, "#secure_field_2"
    element :package_repo_save, "#submit_form"
    element :package_repo_plugin, "#package_repository_pluginConfiguration_id"

    load_validation { has_package_repo_name? }


    def package_repo_listed? repo_name
      page.has_css?('a', text: repo_name)
    end

    def edit_package_repo repo_name
      page.find('a', text: repo_name).click
    end

  end
end
