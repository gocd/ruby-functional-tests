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

step 'On Admin Config XML page' do |_tmp|
  admin_config_xml_page.load
end

step 'Click save - Already on config XML Tab' do
  admin_config_xml_page.save_config
end

step 'Verify the message <message> is present on rails page' do |message|
  assert_true admin_config_xml_page.get_message.include? message
end
