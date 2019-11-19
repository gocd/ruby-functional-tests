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

step "Start to add a GoCD config role <name>" do |name|
  role_config_page.load
  role_config_page.click_add
  role_config_page.gocd_role = (true)
  role_config_page.role_name.set name
end

step "Create a new gocd role <name>" do |name|
  role_config_page.click_add
  role_config_page.gocd_role = (true)
  role_config_page.role_name.set name
end

step "Add user <names> to the role" do |names|
  names.split(',').each {|name|
    role_config_page.role_users.set name.strip
    role_config_page.add_role.click
  }
end

step "Save role" do |i|
  role_config_page.save_role
end

step "Go to roles page" do |i|
  role_config_page.load
end

step 'Verify flash message for role <message>' do |message|
  assert_true role_config_page.flash_message.text.include? message
end

step "Verify if role <role_name> is added" do |role_name|
  assert_true role_config_page.has_role(role_name)
end

step "Verify if role <role_name> is not present" do |role_name|
  assert_false role_config_page.has_role(role_name)
end

step 'Edit role <role_name>' do |role_name|
  role_config_page.edit_role(role_name)
end

step 'Clone role <role_name>' do |role_name|
  role_config_page.clone_role(role_name)
end

step 'Set role name as <role_name>' do |role_name|
  role_config_page.role_name.set role_name
end

step 'Delete role <role_name>' do |role_name|
  role_config_page.delete_role(role_name)
end

step 'Confirm delete role' do |i|
  role_config_page.click_confirm_delete
end

step 'Add permission' do |i|
  role_config_page.add_permission
end

step 'Remove permission' do |i|
  role_config_page.remove_permission
end

# use the text value of the required option
step 'Update permission with <permission>, action <action>, type <type> and resource <res>' do |permission, action, type, res|
  role_config_page.update_permission(permission, action, type, res)
end

# use the text value of the required option
step 'Update permission: type <type>' do |type|
  role_config_page.update_permission_type(type)
end
