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
  class RoleConfigSPA < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/security/roles"

    element :add, "button[data-test-id='role-add-button']"
    element :gocd_role, "input[class='core-role']"
    element :plugin_role, "input[class='plugin-role']"
    element :role_name, "input[data-test-id='form-field-input-role-name']"
    element :role_users, "input[data-test-id='form-field-input-role-users']"
    element :add_role, "button[data-test-id='role-add-user-button']"
    element :save, "button[data-test-id='button-save']"

    element :flash_message, "div[data-test-id='flash-message-success']"
    element :edit, "button[data-test-id='role-edit']"
    element :clone, "button[data-test-id='role-clone']"
    element :delete, "button[data-test-id='role-delete']"
    element :confirm_delete, "button[data-test-id='button-delete']"
    element :delete_user, "span[class*='role-user-delete-icon']"

    def click_add
      add.click
    end

    def click_edit
      edit.click
    end

    def click_delete
      delete.click
    end

    def click_confirm_delete
      confirm_delete.click
    end

    def gocd_role=(value)
      gocd_role.set(value)
    end

    def plugin_role=(value)
      plugin_role.set(value)
    end

    def save_role
      save.click
    end

    def has_role(role_name)
      return find_collapsable_header(role_name) != nil
    end

    def delete_role(role_name)
      selected_header = find_collapsable_header(role_name)
      if (selected_header)
        selected_header.find("button[data-test-id='role-delete']").click
      end
    end

    def edit_role(role_name)
      selected_header = find_collapsable_header(role_name)

      if (selected_header)
        selected_header.find("button[data-test-id='role-edit']").click
      end
    end

    def clone_role(role_name)
      selected_header = find_collapsable_header(role_name)

      if (selected_header)
        selected_header.find("button[data-test-id='role-clone']").click
      end
    end

    private

    def find_collapsable_header(name)
      page.all("div[data-test-id='collapse-header']")
          .find {|widget| widget.find("span[data-test-id='key-value-value-name']").text === name}
    end

  end
end
