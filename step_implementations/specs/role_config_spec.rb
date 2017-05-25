##########################################################################
# Copyright 2017 ThoughtWorks, Inc.
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

step "Start to add a GoCD config role <name>" do |name|
  role_config_page.load
  role_config_page.click_add
  role_config_page.gocd_role=(true)
  role_config_page.role_name.set name
end

step "Add user <names> to the role" do |names|
  names.split(',').each{|name|
    role_config_page.role_users.set name.strip
    role_config_page.add_role.click
  }
end

step "Save role config" do |i|
  role_config_page.save_role
end
