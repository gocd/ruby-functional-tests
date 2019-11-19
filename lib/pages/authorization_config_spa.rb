##########################################################################
# Copyright 2017 ThoughtWorks, Inc.
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
  class AuthConfigSPA < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/security/auth_configs"

    element :add, "button[data-test-id='add-auth-config-button']"
    element :id, "[data-test-id='form-field-input-id']"
    element :plugin_id, 'select[data-test-id="form-field-input-plugin"]'
    element :pwd_file_path, "input[ng-model='PasswordFilePath']"
    element :ldap_url, "input[ng-model='Url']"
    element :manager_dn, "input[ng-model='ManagerDN']"
    element :password, "input[ng-model='Password']"
    element :search_bases, "textarea[ng-model='SearchBases']"
    element :login_filter, "input[ng-model='UserLoginFilter']"
    element :display_name, "input[ng-model='DisplayNameAttribute']"
    element :email, "input[ng-model='EmailAttribute']"
    element :search_filter, "input[ng-model='UserSearchFilter']"
    element :flash_message, "div[data-test-id^='flash-message']"


    element :save, "button[data-test-id='button-save']"
    element :edit, "button[data-test-id='auth-config-edit']"
    element :clone, "button[data-test-id='auth-config-clone']"
    element :confirm_delete, "button[data-test-id='button-delete']"
    element :check_connection, "button[data-test-id='button-check-connection']"

    def click_add
      add.click
    end

    def click_confirm_delete
      confirm_delete.click
    end

    def plugin=(plugin)
      plugin_id.select plugin
    end

    def save_config
      save.click
    end

    def do_check_connection
      check_connection.click
    end

    def has_auth_config(id)
      return find_collapsable_header(id) != nil
    end

    def delete_auth_config(id)
      selected_header = find_collapsable_header(id)
      if (selected_header)
        selected_header.find("button[data-test-id='auth-config-delete']").click
      end
    end

    def edit_auth_config(id)
      selected_header = find_collapsable_header(id)

      if (selected_header)
        selected_header.find("button[data-test-id='auth-config-edit']").click
      end
    end

    def clone_auth_config(id)
      selected_header = find_collapsable_header(id)

      if (selected_header)
        selected_header.find("button[data-test-id='auth-config-clone']").click
      end
    end

    private

    def find_collapsable_header(id)
      selected_header = page.all("div[data-test-id='collapse-header']")
                            .find {|widget| widget.find("span[data-test-id='key-value-value-id']").text === id}
    end
  end
end
