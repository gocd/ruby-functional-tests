##########################################################################
# Copyright 2018 ThoughtWorks, Inc.
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

    element :add_user, '.add_new_users'
    element :search_text, '#search_id'
    element :search_btn, '#search_user_submit'
    element :search_result, '#search_users_table'
    element :submit_add_user, '#submit_add_user'
    element :user_list, '.list_table.sortable_table'
    element :username, '.username'
    element :edit_panel, '.edit_panel'
    element :btn_disable, "button[value='Disable']"
    element :btn_enable, "button[value='Enable']"
    element :btn_role, "button[value='Roles']"
    element :roles_panel, "#roles_panel"
    element :admin, "span", text:"Go System Administrator"
    element :add_role, ".apply_resources"
    element :message_after_adding_role ,"#message_pane"
    element :add_new_role, "input[name='new_role']"


    load_validation { has_add_user? }

    def search_for(user)
      add_user.click
      search_text.set user
      search_btn.click
    end

    def add_user_at(row)
      search_result.all('.user')[row.to_i-1].find('input[type="radio"]').set(true)
      submit_add_user.click
    end

    def select_user(user)
      (username text: user,exact_text: true).ancestor('.user').find('.selector').find("input[type='checkbox']").set(true)
    end

    def deselect_all_users
      page.all('.user').each{|user|
        user.find("input[type='checkbox']").set(false)
      }
    end

    def select_users(users_list)
      deselect_all_users
      users_list.split(',').each { |user| select_user(user)
      }
    end

    def enable(user)
      select_user(user)
      btn_enable.click
    end

    def enabled?(user)
      (username text: user,exact_text: true).ancestor('.user').find('.enabled')['title'] == 'Yes'
    end

    def disabled?(user)
      (username text: user,exact_text: true).ancestor('.user').find('.enabled')['title'] == 'No'
    end

    def update_success?(message)
      page.find('.success').text.eql? message
    end

    def promote_to_admin(user)
      select_user(user)
      btn_role.click
      admin.click
      roles_panel.find("button[value='Add']").click
      update_success? "Role(s)/Admin-Privilege modified for 1 user(s) successfully."
    end

    def admin?(user, expected='Yes')
      (username text: user ,exact_text: true).ancestor('.user').find('.is_admin')['title'].eql?expected
    end

    def error_msg_displayed? message
      page.find('.error').text.eql? message
    end

    def role_disabled_message(role)
      page.find('.selectors .tristate', text: role.strip, exact_text: true).ancestor('.selectors').find('.tristate_disabled_message').text
    end

    def role_enabled?(role)
      !page.find('.selectors .tristate', text: role.strip, exact_text: true).ancestor('.selectors').has_css?('.tristate_disabled_message')
    end

    def click_on_roles(roles_list)
      click_roles(roles_list)
    end

    def click_roles(roles_list)
      roles_list.split(',').each{
        |role| page.find('.selectors .tristate', text: role.strip, exact_text: true).click
      }
    end

    def add_roles_to_users(roles_list,users_list)
      select_users(users_list)
      btn_role.click
      click_on_roles(roles_list)
      add_role.click
    end

    def message_after_applying_roles
      message_after_adding_role.text
    end

    def get_user_roles(user)
      (username text: user,exact_text: true).ancestor('.user').find('.selector').sibling('.roles').find('span').text
    end

    def add_new_roles_to_users(new_role,users)
      users.split(',').each { |user| select_user(user)
      }
      btn_role.click
      add_new_role.set(new_role)
      add_role.click
    end

    def delete_users_from_db(users)
      payload="{\"enabled\":\"false\"}"
      users.split(',').each{|user|
        RestClient.patch http_url("/api/users/#{user}"), payload,
        { content_type: :json, accept: 'application/vnd.go.cd.v3+json' }.merge(basic_configuration.header)

        RestClient.delete http_url("/api/users/#{user}"),
        { content_type: :json, accept: 'application/vnd.go.cd.v3+json' }.merge(basic_configuration.header)
      }
    end
  end
end
