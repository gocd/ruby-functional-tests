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

step "Go to Secret Management page" do |i|
  secret_management_page.load
end

step "Create new secret config <id> with <filepath>" do |id, filepath|
  plugin_id = 'cd.go.secrets.file-based-plugin'
  secret_management_page.load
  secret_management_page.click_add
  secret_management_page.config_id(id)
  secret_management_page.plugin_id(plugin_id)
  secret_management_page.filepath(filepath)
end

step "Save secret config" do |i|
  secret_management_page.save_secret_conig
end

step 'Verify flash message for secret config <message>' do |message|
  assert_true secret_management_page.flash_message.text.include? message
end

step "Verify if secret config <secret_config> is added" do |secret_config|
  assert_true secret_management_page.has_secret_config(secret_config)
end

# step "Verify if role <role_name> is not present" do |role_name|
#   assert_false secret_management_page.has_role(role_name)
# end
#
# step 'Edit role <role_name>' do |role_name|
#   secret_management_page.edit_role(role_name)
# end
#
# step 'Clone role <role_name>' do |role_name|
#   secret_management_page.clone_role(role_name)
# end
#
# step 'Set role name as <role_name>' do |role_name|
#   secret_management_page.role_name.set role_name
# end
#
# step 'Delete role <role_name>' do |role_name|
#   secret_management_page.delete_role(role_name)
# end
#
# step 'Confirm delete role' do |i|
#   secret_management_page.click_confirm_delete
# end
