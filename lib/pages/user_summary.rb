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
  class UserSummary < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/users"

    element :import_user, "[data-test-id='pageActions']"
    element :search_result, "[data-test-id='table-body']"
    element :submit_add_user, '[data-test-id="button-add"]'
    element :user_list, '.list_table.sortable_table'
    element :username, "[data-test-id='user-username']"
    element :edit_panel, '.edit_panel'
    element :btn_disable, 'button', text: 'Disable'
    element :btn_enable, 'button', text: 'Enable'
    element :btn_role, 'button', text: 'Roles'
    element :roles_panel, '#roles_panel'
    element :admin, 'span', text: 'Go System Administrator'
    element :add_role, '.apply_resources'
    element :message_after_adding_role, '#message_pane'
    element :add_new_role, "input[name='new_role']"

    load_validation { has_import_user? }

    def search_for(user)
      import_user.click
      page.find("input[placeholder='Search user..']", wait: 5).set(user)
      page.find('button', text: 'Search').click
    end

    def add_user_at(row)
      search_result.all("[data-test-id='table-row']", wait: 5)[row.to_i - 1].find('input[type="radio"]').set(true)
      submit_add_user.click
    end

    def select_user(user)
      (username text: user, exact_text: true).ancestor("[data-test-id='user-row']").find("input[type='checkbox']").set(true)
    end

    def deselect_all_users
      page.all("[data-test-id='user-row']").each do |user|
        user.find("input[type='checkbox']").set(false)
      end
    end

    def select_users(users_list)
      deselect_all_users
      users_list.split(',').each do |user|
        select_user(user)
      end
    end

    def enable(user)
      select_user(user)
      page.find('button', text: 'Enable').click
    end

    def disable
      page.find('button', text: 'Disable').click
    end

    def enabled?(user)
      (username text: user, exact_text: true).ancestor("[data-test-id='user-row']").find("[data-test-id='user-enabled']").text.eql? 'Yes'
    end

    def disabled?(user)
      (username text: user, exact_text: true).ancestor("[data-test-id='user-row']").find("[data-test-id='user-enabled']").text.eql? 'No'
    end

    def update_success?(message)
      page.find("[data-test-id='flash-message-success']").text.eql? message
    end

    def promote_to_admin(user)
      select_user(user)
      page.find('button', text: 'Roles').click
      page.find("[data-test-id='form-field-input-admins']").click
      page.find('button', text: 'Apply').click
      update_success? 'Roles are updated successfully!'
    end

    def admin?(user, expected = 'Yes')
      (username text: user, exact_text: true).ancestor("[data-test-id='user-row']").find("[data-test-id='is-admin-text']").text.eql? expected
    end

    def error_msg_displayed?(message)
      page.find("[data-test-id='flash-message-alert']").text.eql? message
    end

    def role_disabled_message(role)
      page.find("[data-test-id='form-field-input-#{role.strip}']").ancestor('.selectors').find('.tristate_disabled_message').text
    end

    def role_enabled?(role)
      !page.find("[data-test-id='form-field-input-#{role.strip}']").ancestor('.selectors').has_css?('.tristate_disabled_message')
    end

    def click_on_roles(roles_list)
      click_roles(roles_list)
    end

    def click_roles(roles_list)
      roles_list.split(',').each do |role|
        page.find("[data-test-id='form-field-input-#{role.strip}']").click
      end
    end

    def add_roles_to_users(roles_list, users_list)
      select_users(users_list)
      page.find('button', text: 'Roles').click
      click_on_roles(roles_list)
      page.find('button', text: 'Apply').click
    end

    def message_after_applying_roles
      page.find("[data-test-id='flash-message-success']").text
    end

    def get_user_roles(user)
      (username text: user, exact_text: true).ancestor("[data-test-id='user-row']").find("[data-test-id='user-roles']").text
    end

    def add_new_roles_to_users(new_role, users)
      users.split(',').each do |user|
        select_user(user)
      end
      page.find('button', text: 'Roles').click
      page.find("input[placeholder='Add role']").set(new_role, rapid: false)
      page.find('button', text: 'Add').click
      page.find('button', text: 'Apply').click
    end

    def delete_users_from_db(users)
      payload = '{"enabled":"false"}'
      users.split(',').each do |user|
        RestClient.patch http_url("/api/users/#{user}"), payload,
                         { content_type: :json, accept: 'application/vnd.go.cd+json' }.merge(basic_configuration.header)

        RestClient.delete http_url("/api/users/#{user}"),
                          { content_type: :json, accept: 'application/vnd.go.cd+json' }.merge(basic_configuration.header)
      end
    end
  end
end
