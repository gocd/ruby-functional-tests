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
  secret_management_page.plugin_value(plugin_id)
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

step 'Clone secret config <secret_config>' do |secret_config|
  secret_management_page.clone_secret_config(secret_config)
end

step 'Set secret config id as <id>' do |id|
  secret_management_page.config_id(id)
end

step 'Set filepath as <filepath>' do |filepath|
  secret_management_page.filepath(filepath)
end

step 'Edit secret config <secret_config>' do |secret_config|
  secret_management_page.edit_secret_config(secret_config)
end

step "Verify if secret config <secret_config> is not present" do |secret_config|
  assert_false secret_management_page.has_secret_config(secret_config)
end

step 'Delete secret config <secret_config>' do |secret_config|
  secret_management_page.delete_secret_config(secret_config)
end

step 'Confirm delete secret config' do |i|
  secret_management_page.click_confirm_delete
end
