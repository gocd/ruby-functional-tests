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

step 'On Admin Config XML page' do |_tmp|
  admin_config_xml_page.load
end

step 'Click edit Config XML' do
  admin_config_xml_page.click_edit_config
  # Loaded async, wait for it
  assert_true admin_config_xml_page.config_content_is_loaded?
end

step 'Change config to conflict' do
  admin_config_xml_page.change_config_to_conflict
end

step 'Verify that split pane appears' do
  admin_config_xml_page.verify_split_appears
end

step 'Add downstream pipeline to create post validation conflict' do
  admin_config_xml_page.add_downstream_pipeline_to_create_post_validations
end

step 'Click save - Already on config XML Tab' do
  admin_config_xml_page.save_config
end

step 'Verify post validation error is shown with message <message>' do |message|
  assert_true admin_config_xml_page.post_validation_error_message_exist? message
end

step 'Verify the message <message> is present on rails page' do |message|
  assert_includes admin_config_xml_page.get_message, message
end
