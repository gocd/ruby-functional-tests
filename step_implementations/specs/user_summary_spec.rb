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

require 'json'
step "On User Summary page" do |count|
  user_summary_page.load
end

step "Search for <user> and add user <index> in the search result" do |user, index|
  user_summary_page.search_for(user)
  user_summary_page.add_user_at(index)
end


step "Verify users <users> are enabled" do |users|
  users.split(',').each{|user|
    assert_true user_summary_page.enabled?(user)
  }
end

step "Verify users <users> are disabled" do |users|
  users.split(',').each{|user|
    assert_true user_summary_page.disabled?(user)
  }
end

step "Enable users <users>" do |users|
  users.split(',').each{|user|
    user_summary_page.enable(user)
  }
end

step "Disable users <users>" do |users|
  users.split(',').each{|user|
    user_summary_page.select_user(user)
  }
  user_summary_page.btn_disable.click
end

step "Promote <user> an admin user" do |user|
  user_summary_page.promote_to_admin(user)
end

step "Verify error message <msg> is displayed" do |msg|
  assert_true user_summary_page.error_msg_displayed? msg
end

step "Add user <user> - Using user API" do |user|
  RestClient.post http_url('/api/users'), {"login_name": user}.to_json,
  {content_type: :json, accept: 'application/vnd.go.cd.v2+json'}.merge(basic_configuration.header)
end

step "Add Roles as <roles> to users <users>" do |roles,users|
  user_summary_page.add_roles_to_users(roles,users)
end

step "Verify message displayed as <message> after applying roles to users." do |message|
  assert_true user_summary_page.verify_message_after_applying_roles().start_with? message
end

step "Verify users <users> are assigned role <roles>" do |users,roles|
  users.split(',').each{ |user| 
      assert_true user_summary_page.get_user_roles(user).include?roles
  }
end

step "Add new role as <new_role> to users <users>" do |new_role,users|
  user_summary_page.add_new_roles_to_users(new_role,users)
end

step "Verify users <users> does not have the role <roles>" do |users,roles|
  users.split(',').each{  |user|
    assert_false user_summary_page.get_user_roles(user).include?roles
 }
end