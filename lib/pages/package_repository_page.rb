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
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/package_repositories"

    element :add_package_button, "div[data-test-id='pageActions'] button"
    element :package_repo_name, "input[data-test-id='form-field-input-name']"
    element :package_repo_url, "input[data-test-id='input-for-URL']"
    element :package_repo_username, "input[data-test-id='input-for-User']"
    element :package_repo_password, "input[data-test-id='input-for-Password']"
    element :package_repo_save, "button[data-test-id='button-save']"
    element :package_repo_plugin, "select[data-test-id='form-field-input-plugin']"

    load_validation { add_package_button }


    def package_repo_listed? repo_name
      find_collapsible_header(repo_name) != nil
    end

    def edit_package_repo repo_name
      selected_header = find_collapsible_header(repo_name)

      if (selected_header)
        selected_header.find("button[data-test-id='package-repo-edit']").click
      end
    end

    private

    def find_collapsible_header(name)
      page.all("div[data-test-id='collapse-header']")
          .find {|widget| widget.find("span[data-test-id='key-value-value-name']").text === name}
    end

  end
end
