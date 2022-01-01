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

step 'Verify server health message is shown' do |_pipeline|
  server_health_message.verify_message_notifier_showsup
end

step 'Verify server health message <message> is shown' do |msg|
  server_health_message.verify_message_notifier_showsup
  server_health_message.verify_message_displayed(msg)
end

step 'Wait till error message popup appears' do
  server_health_message.wait_till_error_popup_appears
end

step 'Verify message contains <message>' do |message|
  server_health_message.verify_error_message(message)
end

step 'Verify error description contains <message>' do |message|
  server_health_message.verify_error_description(message)
end

step 'Open error messages popup' do
  server_health_message.message_notifier.click
end

step 'Verify there are no warnings' do
  server_health_message.verify_there_are_no_warnings
end

step 'Verify there are no error and warnings' do
  assert_false server_health_message.verify_there_are_no_errors_and_warnings
end

step 'Verify there are no error messages' do
  server_health_message.verify_there_are_no_error_messages
end

step 'Verify message do not contain <message>' do |message|
  server_health_message.verify_message_do_not_contains message
end

step 'Verify error description does not contain <message>' do |message|
  server_health_message.verify_error_description_do_not_contains message
end

step 'Close the error popup' do
  server_health_message.error_popup_ok_button.click
end

step 'Verify there are <number_of_warnings> warnings' do |number_of_warnings|
  server_health_message.verify_number_of_warnings number_of_warnings
end

step 'Verify there are <number_of_errors> errors' do |number_of_errors|
  server_health_message.verify_number_of_error_message number_of_errors
end

step 'Verify there are a minimum <number_of_errors> errors' do |number_of_errors|
  server_health_message.verify_minimum_number_of_error_message number_of_errors
end
