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

step 'Verify group list has <groups>' do |groups|
  config_xml_page.verify_group_links_visible groups
end

step 'Verify selected group is <name>' do |name|
  config_xml_page.verify_selected_group_is(name)
end

step 'Edit config xml' do |link|
  config_xml_page.edit_link.click
end

step 'Change group name of <old_name> to <new_name>' do |old_name, new_name|
  config_xml_page.modify_group_name old_name, new_name
end


step 'Verify that xml snippet contains <sub_string>' do |sub_string|
  assert_true config_xml_page.config_xml_include? sub_string
end

step 'Verify config save is successfull' do 
  config_xml_page.save_successful?
end

step 'Verify error message <message>' do |message|
  config_xml_page.error_message_displayed? message
end

step 'Open config tab from admin menu' do
  config_xml_page.open_config_from_admin_menu
end