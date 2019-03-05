##########################################################################
# Copyright 2016 ThoughtWorks, Inc.
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

step 'Smoke Configuration - setup' do
  secure_configuration.setup 'basic-secure-cruise-config.xml', 'password.properties'
end

step 'Basic Configuration - setup' do
  basic_configuration.setup 'basic-cruise-config.xml'
end

step 'Single Pipeline Configuration - setup' do
  basic_configuration.setup 'basic-single-pipeline-config.xml'
end

step 'Secure Configuration - setup' do
  secure_configuration.setup 'secure-cruise-config.xml', 'password.properties'
end

step 'ConflictingConfiguration - setup' do
  secure_configuration.setup 'conflict-cruise-config.xml', 'password.properties'
end

step 'ConflictingConfigurationForPipelineAdmin - setup' do
  secure_configuration.setup 'conflict-cruise-config-for-pipelineAdmin.xml', 'password.properties'
end

step 'Template admin configuration - setup' do 
  secure_configuration.setup 'template-admin-cruise-config.xml', 'password.properties'
end

step 'External Artifacts Configuration - setup' do
  secure_configuration.setup 'external-artifacts-cruise-config.xml', 'password.properties'
end

step 'Multiple agents Configuration - setup' do
  basic_configuration.setup 'multiple-agents-cruise-config.xml'
end

step 'Config repos Configuration - setup' do
  basic_configuration.setup 'with-config-repo-cruise-config.xml'
end

step 'Config repo git repository - setup' do
  basic_configuration.setup 'with-config-repo-cruise-config.xml'
end

step 'AuthPluginsConfiguration - setup' do
  secure_configuration.setup 'auth-plugins-config.xml', 'password.properties'
end

step 'Enable security and add <users> as admins' do |adminUsers|
  basic_configuration.enable_security_with_admin_rights 'password.properties', adminUsers
end

step 'Making <user> an admin user' do |user|
  basic_configuration.add_user_as_admin user
end
step 'Removing <user> as an admin user' do |user|
  basic_configuration.remove_user_as_admin user
end
step 'Enable security with password file' do
  basic_configuration.enable_security_with_password_file 'password.properties'
end
step 'With no users - setup' do
  basic_configuration.remove_all_users
end

step 'With no users - teardown' do
  basic_configuration.remove_all_users
end


step 'With Environments Configuration - setup' do
	basic_configuration.setup 'with-environments-cruise-config.xml'
end

step 'Fanin Configuration - setup' do
  basic_configuration.setup 'fanin-cruise-config.xml'
end

step 'Permissions configuration - setup' do
  secure_configuration.setup 'permissions-cruise-config.xml','password.properties'
end

step 'Changing the artifacts location to <artifact_location>' do |artifact_location|
  basic_configuration.set_artifact_location artifact_location
end

step 'Using timer with spec <spec>' do |spec|
  basic_configuration.add_new_timer_spec_to_file spec
end

step 'set timer with spec <spec> on server' do |spec|
basic_configuration.set_timer_spec spec
end

step 'Make cruise config file invalid' do ||
  basic_configuration.change_cruise_config_file_to 'invalid-cruise-config.xml'
end

step 'Group admin security configuration - setup' do
  secure_configuration.setup 'group-admin-security-config.xml','password.properties'
end

step 'Allow only known users to login' do ||
  basic_configuration.allow_known_user_to_login("true")
end

step 'Allow unknown users to login' do ||
  basic_configuration.allow_known_user_to_login("false")
end

step 'Verify that user <user> is authorized to operate on the stage <stage> of pipeline <pipeline>' do |user,stage,pipeline|
  assert_true basic_configuration.stage_is_authorised_with_user?(user,stage,pipeline).include?user
end

step 'Verify that role <role> is authorized to operate on the stage <stage> of pipeline <pipeline>' do |role,stage,pipeline|
  assert_true basic_configuration.stage_is_authorised_with_role?(role,stage,pipeline).include?role
end

step 'Rename pipeline <pipeline> to <new_pipeline>' do |pipeline,new_pipeline|
  basic_configuration.rename_pipeline pipeline, new_pipeline
end