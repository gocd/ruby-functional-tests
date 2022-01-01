##########################################################################
# Copyright 2022 ThoughtWorks, Inc.
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

step 'On User Summary page' do |_count|
  user_summary_page.load
end

step 'Search for <user> and add user <index> in the search result' do |user, index|
  user_summary_page.search_for(user)
  user_summary_page.add_user_at(index)
end

step 'Verify users <users> are enabled' do |users|
  users.split(',').each do |user|
    assert_true user_summary_page.enabled?(user.strip)
  end
end

step 'Verify users <users> are disabled' do |users|
  users.split(',').each do |user|
    assert_true user_summary_page.disabled?(user.strip)
  end
end

step 'Enable users <users>' do |users|
  users.split(',').each do |user|
    user_summary_page.enable(user)
  end
end

step 'Disable users <users>' do |users|
  users.split(',').each do |user|
    user_summary_page.select_user(user.strip)
  end
  user_summary_page.disable
end

step 'Promote <user> an admin user' do |user|
  user_summary_page.promote_to_admin(user)
end

step 'Verify error message <msg> is displayed' do |msg|
  assert_true user_summary_page.error_msg_displayed? msg
end

step 'Attempt to delete <user> user and should return <code>' do |user, response_code|
  RestClient.delete http_url("/api/users/#{user}"),
                    { accept: 'application/vnd.go.cd+json' }.merge(basic_configuration.header) do |response, _request, _result|
    assert_true response.code == response_code.to_i
  end
end

step 'Add Roles as <roles> to users <users>' do |roles, users|
  user_summary_page.add_roles_to_users(roles, users)
end

step 'Verify role state <role> is disabled with message <message>' do |role, message|
  assert_false user_summary_page.role_enabled? role
  assert_true user_summary_page.role_disabled_message(role).eql? message
end

step 'Open roles menu' do
  user_summary_page.btn_role.click
end

step 'Verify role state <role> is enabled' do |role|
  assert_true user_summary_page.role_enabled? role
end

step 'Verify message displayed as <message> after applying roles to users.' do |message|
  assert_true user_summary_page.message_after_applying_roles.start_with? message
end

step 'Verify users <users> are assigned role <roles>' do |users, roles|
  expected_roles = roles.split(',').collect(&:strip)
  users.split(',').each do |user|
    actual_roles = user_summary_page.get_user_roles(user.strip)
    expected_roles.each do |role|
      assert_true actual_roles.include? role
    end
  end
end

step 'Verify users <users> are administrators' do |users|
  users.split(',').each do |user|
    assert_true user_summary_page.admin? user.strip
  end
end

step 'Add roles <roles>' do |roles|
  user_summary_page.click_on_roles(roles)
end

step 'Remove roles <roles>' do |roles|
  user_summary_page.click_on_roles(roles)
end

step 'Verify users <users> are not administrators' do |users|
  users.split(',').each do |user|
    assert_true user_summary_page.admin? user, 'No'
  end
end

step 'Apply changes to roles' do
  user_summary_page.add_role.click
end

step 'Select users <users>' do |users|
  user_summary_page.select_users(users)
end

step 'Add new role as <new_role> to users <users>' do |new_role, users|
  user_summary_page.add_new_roles_to_users(new_role, users)
end

step 'Verify users <users> does not have the role <roles>' do |users, roles|
  users.split(',').each do |user|
    assert_false user_summary_page.get_user_roles(user).include? roles
  end
end

step 'Delete users <users> from DB' do |users|
  user_summary_page.delete_users_from_db(users)
end
