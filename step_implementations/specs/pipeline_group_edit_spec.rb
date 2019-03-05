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

step "Edit pipeline group <group>" do |grp|
  pipeline_group_edit_page.load(group: grp)
end

step "Add role <role> as view user" do |role|
  pipeline_group_edit_page.role_name.set role
  pipeline_group_edit_page.role_view_privilege.set true
end

step "Add user <name> as admin user" do |name|
  pipeline_group_edit_page.user_name.set name
  pipeline_group_edit_page.user_admin_privilege.set true
end

step "Save pipeline group permissions" do |i|
  pipeline_group_edit_page.save.click
end

step 'Remove permission <permission> for role <role>' do |permission,role|
  pipeline_group_edit_page.remove_permission_for_role permission,role
end