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

step 'On Server Configuration page' do
  server_configuration_page.load
end

step 'On Job timeout configuration' do
  server_configuration_page.job_timeout_link.click
end

step 'On Email server configuration' do
  server_configuration_page.email_server_link.click
end

step 'Save Server Configuration' do
  server_configuration_page.save_button.click
end

step 'Set cancel job after <time> minutes' do |time|
  server_configuration_page.never_job_timeout_checkbox.set(false)
  server_configuration_page.job_timeout_input.set time
end

step 'Set SMTP server hostname as <hostname>' do |hostname|
  server_configuration_page.smtp_hostname.set hostname
end

step 'Set SMTP server port as <port>' do |port|
  server_configuration_page.smtp_port.set port
end

step 'Enable SMTPs' do
  server_configuration_page.use_smtps_checkbox.set(true)
end

step 'Set SMTP server username as <username>' do |username|
  server_configuration_page.smtp_username.set username
end

step 'Set SMTP server password as <password>' do |password|
  server_configuration_page.smtp_password.set password
end

step 'Set sender email as <email>' do |email|
  server_configuration_page.sender_email_address.set email
end

step 'Set administrator email as <email>' do |email|
  server_configuration_page.admin_email_address.set email
end

step 'Verify server configuration save is successful' do
  assert_equal server_configuration_page.flash_message.text, "Mail server configuration updated successfully!", "Actual message shown #{server_configuration_page.flash_message.text}"
end
