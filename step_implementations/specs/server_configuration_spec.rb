##########################################################################
# Copyright 2019 ThoughtWorks, Inc.
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

step 'Save Server Configuration' do
  server_configuration_page.save_button.click
end

step 'Set cancel job after <time> minutes' do |time|
  server_configuration_page.never_job_timeout_checkbox.set(false)
  server_configuration_page.job_timeout_input.set time
end
