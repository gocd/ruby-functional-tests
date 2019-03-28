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

step 'Add environment variable <variable_name> with value <variable_value>' do |variable_name, variable_value|
  general_settings_page.add_env_variable(variable_name,variable_value)
end

step 'Add secure environment variable <variable_name> with value <variable_value>' do |variable_name, variable_value|
  general_settings_page.add_sec_env_variable(variable_name,variable_value)
end

step 'Save Changes' do
  general_settings_page.task_save.click
end

step 'Verify the message <message> is present' do |message|
  assert_true general_settings_page.get_message.include?message
end

step 'Verify secure environment variable with name <key> is present' do |key|
  general_settings_page.verify_secure_variables_table_row(key)
end

step 'Verify environment variable with name <key> and value <value> is present' do |key,value|
  general_settings_page.verify_variables_table_row(key,value)
end

step 'Verify parameter with name <key> and value <value> is present' do |key,value|
  general_settings_page.verify_parameters_table_row(key,value)
end

step 'Verify <link> link is present' do |link|
  general_settings_page.is_link_exist?(link)
end
