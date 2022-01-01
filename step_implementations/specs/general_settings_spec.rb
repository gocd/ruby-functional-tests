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

step 'Add environment variable <variable_name> with value <variable_value>' do |variable_name, variable_value|
  general_settings_page.add_env_variable(variable_name, variable_value)
end

step 'Add secure environment variable <variable_name> with value <variable_value>' do |variable_name, variable_value|
  general_settings_page.add_sec_env_variable(variable_name, variable_value)
end

step 'Save task changes' do
  general_settings_page.task_save.click
end

step 'Save Changes' do
  general_settings_page.global_save.click
end

step 'Reset Changes' do
  general_settings_page.global_cancel.click
end

step 'Close modal' do
  general_settings_page.task_cancel.click
end

step 'Verify the message <message> is present' do |message|
  actual = general_settings_page.get_message
  assert_true actual.include?(message), "Expected '#{message}' to be a part of '#{actual}'"
end

step 'Verify the error message <message> is present' do |message|
  actual   = general_settings_page.error_message.text
  expected = new_pipeline_dashboard_page.sanitize_message(message)
  assert_true actual.include?(expected), "Expected '#{expected}' to be a part of '#{actual}'"
end

step 'Verify secure environment variable with name <key> is present' do |key|
  assert_not_nil general_settings_page.verify_secure_variables_table_row(key)
end

step 'Verify environment variable with name <key> and value <value> is present' do |key, value|
  assert_not_nil general_settings_page.verify_variables_table_row(key, value)
end

step 'Verify parameter with name <key> and value <value> is present' do |key, value|
  general_settings_page.verify_parameters_table_row(key, value)
end

step 'Add parameter name <name> and value <value>' do |name, value|
  general_settings_page.add_parameter(name, value)
end

step 'Add more parameter' do
  general_settings_page.add_parameter_button.click
end

step 'Confirm discard changes' do
  general_settings_page.confirm_change.click
end
