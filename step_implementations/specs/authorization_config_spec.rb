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

step 'Start to add a new authorization config with id as <id> for plugin <plugin_id>' do |id, plugin_id|
  authorization_config_page.load
  authorization_config_page.click_add
  authorization_config_page.id.set id
  authorization_config_page.plugin = plugin_id
end

step 'Go to auth config page' do |_i|
  authorization_config_page.load
end

step 'Set auth config id as <auth_config_id>' do |auth_config_id|
  authorization_config_page.id.set auth_config_id
end

step 'Set password file path as <file>' do |file|
  authorization_config_page.pwd_file_path.set file == 'non_existent_file' ? file : File.expand_path("#{GoConstants::CONFIG_PATH}/#{file}")
end

step 'Save authorization config' do |_i|
  authorization_config_page.save_config
end

step 'Perform check connection' do |_i|
  authorization_config_page.do_check_connection
end

step 'Verify flash message <message>' do |message|
  assert_true authorization_config_page.flash_message.text.include? message
end

step 'Verify if auth config <auth_config_id> is added' do |auth_config_id|
  assert_true authorization_config_page.has_auth_config(auth_config_id)
end

step 'Delete auth config <auth_config_id>' do |auth_config_id|
  authorization_config_page.delete_auth_config(auth_config_id)
end
step 'Edit auth config <auth_config_id>' do |auth_config_id|
  authorization_config_page.edit_auth_config(auth_config_id)
end

step 'Clone auth config <auth_config_id>' do |auth_config_id|
  authorization_config_page.clone_auth_config(auth_config_id)
end

step 'Confirm delete auth config' do |_i|
  authorization_config_page.click_confirm_delete
end

step 'Set LDAP Url' do |_i|
  authorization_config_page.ldap_url.set "ldap://#{GoConstants::LDAP_SERVER_IP}"
end

step 'Set Manager DN as <manager_dn>' do |dn|
  authorization_config_page.manager_dn.set dn
end

step 'Set Password as <pwd>' do |pwd|
  authorization_config_page.password.set pwd
end

step 'Set Search Bases as <sb>' do |sb|
  authorization_config_page.search_bases.set sb
end

step 'Set User Login Filter as <lf>' do |lf|
  authorization_config_page.login_filter.set lf
end

step 'Set Display Name Attribute as <dn>' do |dn|
  authorization_config_page.display_name.set dn
end

step 'Set Email Attribute as <email>' do |email|
  authorization_config_page.email.set email
end

step 'Set User Search Filter as <sf>' do |sf|
  authorization_config_page.search_filter.set sf
end

step 'Verify error message on auth config spa <msg>' do |msg|
  assert_true authorization_config_page.error_message.text === msg
end
