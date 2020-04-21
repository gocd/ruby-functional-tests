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

    element :msg, "div[data-test-id='flash-message-success']"
    element :info, "div[data-test-id='flash-message-info']"
    element :error, "div[data-test-id='flash-message-alert']"
    element :confirm_delete, "button[data-test-id='button-delete']"
    element :press_ok, "button[data-test-id='button-ok']"
    element :add_package_repo_button, "div[data-test-id='pageActions'] button"
    element :edit_package_repo_button, "button[data-test-id='package-repo-edit']"
    element :clone_package_repo_button, "button[data-test-id='package-repo-edit']"
    element :name_field, "input[data-test-id='form-field-input-name']"
    element :package_repo_url, "input[data-test-id='input-for-Repository URL']"
    element :package_repo_username, "input[data-test-id='input-for-User']"
    element :package_repo_password, "input[data-test-id='input-for-Password']"
    element :package_spec, "input[data-test-id='input-for-Package Spec']"
    element :save_button, "button[data-test-id='button-save']"
    element :package_repo_plugin, "select[data-test-id='form-field-input-plugin']"
    element :search, "input[data-test-id='search-box']"
    element :modal_body, "div[data-test-id='modal-body']"

    load_validation {add_package_repo_button}

    def package_repo_listed? repo_name
      find_collapsible_header(repo_name) != nil
    end

    def toggle_repo_panel repo_name
      selected_header = find_collapsible_header(repo_name)
      if selected_header.find(:xpath, '..')['data-test-element-state'] == "collapsed"
        selected_header.click
      end
    end

    def edit_package_repo repo_name
      selected_header = find_collapsible_header(repo_name)

      if (selected_header)
        selected_header.find("button[data-test-id='package-repo-edit']").click
      end
    end

    def open_pkg_repo_configuration pkg_repo
      selected_header = find_collapsible_header(pkg_repo)
      selected_header.click
      selected_header
          .sibling('div')
          .find("h5[data-test-id='configuration-details-header']").click
    end

    def pkg_repo_config(pkg_repo, id)
      selected_body = find_collapsible_body(pkg_repo)
      selected_body.find("span[data-test-id='#{id}']")
    end

    def pkg_config(pkg_name, id)
      selected_body = find_package_panel(pkg_name)
      selected_body.find("span[data-test-id='#{id}']")
    end

    def button_add_package(pkg_repo)
      find_collapsible_header(pkg_repo).find("button[data-test-id='package-create']")
    end

    def find_package_panel(pkg_name)
      page.all("div[data-test-id='package-panel']")
          .find {|panel| panel.find("span[data-test-id='package-id']").text === pkg_name}
    end

    def clone_pkg_repo(pkg_repo)
      selected_header = find_collapsible_header(pkg_repo)

      if selected_header
        selected_header.find("button[data-test-id='package-repo-clone']").click
      end
    end

    def edit_pkg_repo(pkg_repo)
      selected_header = find_collapsible_header(pkg_repo)

      if selected_header
        selected_header.find("button[data-test-id='package-repo-edit']").click
      end
    end

    def delete_pkg_repo(pkg_repo)
      selected_header = find_collapsible_header(pkg_repo)

      if selected_header
        selected_header.find("button[data-test-id='package-repo-delete']").click
      end
    end

    def clone_pkg(pkg_name)
      selected_header = find_package_panel(pkg_name)

      if selected_header
        selected_header.find("button[data-test-id='package-clone']").click
      end
    end

    def edit_pkg(pkg_name)
      selected_header = find_package_panel(pkg_name)

      if selected_header
        selected_header.find("button[data-test-id='package-edit']").click
      end
    end

    def delete_pkg(pkg_name)
      selected_header = find_package_panel(pkg_name)

      if selected_header
        selected_header.find("button[data-test-id='package-delete']").click
      end
    end

    def show_usages_pkg(pkg_name)
      selected_header = find_package_panel(pkg_name)

      if selected_header
        selected_header.find("button[data-test-id='package-usages']").click
      end
    end

    def connection_ok
      page.find("button[data-test-id='button-check-connection']").click
      msg != nil
    end

    private

    def find_collapsible_header(name)
      page.all("div[data-test-id='collapse-header']")
          .find {|widget| widget.find("span[data-test-id='key-value-value-name']").text === name}
    end

    def find_collapsible_body(name)
      panel = page.all("div[data-test-id='package-repository-panel']")
                  .find {|widget| widget.find("div[data-test-id='collapse-header'] span[data-test-id='key-value-value-name']").text === name}
      panel.find("div[data-test-id='collapse-body']")
    end

  end
end
