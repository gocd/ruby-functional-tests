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

module Pages
  class NewPipelineGroupPage < AppBase

    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/pipelines"

    element :add_new_group, "[data-test-id='create-new-pipeline-group']"
    element :add_user_permission, "#USER_add_users_and_roles"
    element :add_role_permission, "#ROLE_add_users_and_roles"
    element :save, "button[data-test-id='save-pipeline-group']"
    element :create, "button[data-test-id='button-create']"
    element :user_name, "input[class='user-name']"
    element :role_name, "input[class='form_input permissions_ROLE_name ac_input']"
    element :role_view_privilege, "#viewPrivilege_ROLE_name"
    element :user_view_privilege, "#viewPrivilege_USER_name"
    element :role_admin_privilege, "#adminPrivilege_ROLE_name"
    element :user_admin_privilege, "#adminPrivilege_USER_name"
    element :edit_group_name, "[data-test-id='form-field-input-pipeline-group-name']"
    element :confirm_delete_button, "button[data-test-id='button-delete']"
    element :cancel_button, "button[data-test-id='cancel-button']"
    element :error_message, "div[data-test-id='flash-message-alert']"

    def remove_permission_for_role permission, role
      page.find("#{permission}Privilege_ROLE_#{role}").click if !page.find("#{permission}Privilege_ROLE_#{role}").checked?
    end

    def set_group_name group
      edit_group_name.set group
    end

    def edit_pipeline_group(group_name)
      page.find("[data-test-id='edit-pipeline-group-#{group_name}']").click
    end

    def add_new_user_permission(permission, user)
      page.find("[data-test-id='add-user-permission']").click
      new_user_element = page.all("[data-test-id='user-name']").last
      new_user_element.set user
      new_user_element.ancestor("tr").find("[data-test-id='#{permission}-permission']").click unless permission.eql? 'view'
    end

    def add_new_role_permission(permission, role)
      page.execute_script('document.querySelector("[data-test-id=\'add-role-permission\']").scrollIntoView(true)')
      page.find("[data-test-id='add-role-permission']").click
      new_role_element = page.all("[data-test-id='role-name']", wait: 10).last
      new_role_element.set role
      new_role_element.ancestor("tr").find("[data-test-id='#{permission}-permission']").click unless permission.eql? 'view'
    end

    def update_role_permission(permission, role)
      role_input = page.all("[data-test-id='role-name']")
                       .find {|input| input.value === role}
      role_input.ancestor("tr")
          .find("[data-test-id='#{permission}-permission']")
          .click unless permission.eql? 'view'
    end

    def verify_user_permission(permissions, user)
      user_permission_wrapper = page.all("[data-test-id='user-name']")
                                    .find {|user_input| user_input.value === user}
                                    .ancestor('tr')

      permissions.split(/[\s,]+/).map(&:strip).each do |permission|
        assert_true(user_permission_wrapper.find("[data-test-id='#{permission}-permission']").checked?)
      end
    end

    def verify_role_permission(permissions, role)
      role_permission_wrapper = page.all("[data-test-id='role-name']")
                                    .find {|role_input| role_input.value === role}
                                    .ancestor('tr')
      permissions.split(/[\s,]+/).map(&:strip).each do |permission|
        assert_true(role_permission_wrapper.find("[data-test-id='#{permission}-permission']").checked?)
      end
    end

    def click_on_save
      save.click
    end

    def click_on_create
      create.click
    end

    def click_on_add_new_group
      add_new_group.click
    end

    def click_on_delete group
      page.find("[data-test-id='delete-pipeline-group-#{group}']").click
    end

    def does_not_contain_group group
      actual = new_pipeline_group_page.all('[data-test-id="pipeline-group-name"]').collect(&:text).sort
      assert_not_includes(actual, group)
    end

    def close_pipeline_group_edit_modal
      cancel_button.click
    end

    def confirm_delete
      confirm_delete_button.click
    end
  end
end
