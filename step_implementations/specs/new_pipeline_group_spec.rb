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

step "On pipelines page" do
  new_pipeline_group_page.load
end

step "Verify groups <groups> are visible on new page" do |groups|
  actual   = new_pipeline_group_page.all('[data-test-id="pipeline-group-name"]').collect(&:text).sort
  expected = groups.split(/[\s,]+/).map(&:strip).sort
  assert_true (expected - actual).empty?, "Assertion failed. Expected: #{expected}, Actual: #{actual}"
end

step "Click on edit pipeline group <group>" do |group|
  new_pipeline_group_page.edit_pipeline_group(group)
end

step "Enter pipeline group name <name> on edit pipeline group modal" do |name|
  new_pipeline_group_page.set_group_name(name)
end

step "Enter pipeline group name <name> - create pipeline group" do |name|
  new_pipeline_group_page.set_group_name(name)
end

step "Click on add pipeline group" do
  new_pipeline_group_page.click_on_add_new_group
end

step "Click on save pipeline group" do
  new_pipeline_group_page.click_on_save
end

step "Click on delete pipeline group <group>" do |group|
  new_pipeline_group_page.click_on_delete(group)
end

step "Click on create new pipeline group - save" do
  new_pipeline_group_page.click_on_create
end

step "Click on add user permission - add <permission> permission for <user>" do |permission, user|
  new_pipeline_group_page.add_new_user_permission(permission, user)
end

step "Click on add role permission - add <permission> permission for <role>" do |permission, role|
  new_pipeline_group_page.add_new_role_permission(permission, role)
end

step "Update role permission - set <permission> permission for <role>" do |permission, role|
  new_pipeline_group_page.update_role_permission(permission, role)
end

step "Verify user permission <permissions> for user <user>" do |permissions, user|
  new_pipeline_group_page.verify_user_permission(permissions, user)
end

step "Verify role permission <permissions> for role <role>" do |permissions, role|
  new_pipeline_group_page.verify_role_permission(permissions, role)
end

step "Verify <group> is not visible on new page" do |group|
  new_pipeline_group_page.does_not_contain_group(group)
end

step "Close pipeline group edit modal" do
  new_pipeline_group_page.close_pipeline_group_edit_modal
end

step 'Click on confirm delete pipeline group' do
  new_pipeline_group_page.confirm_delete
end

step 'Verify error message on admin pipeline page <msg>' do |msg|
  assert_true new_pipeline_group_page.error_message.text === msg
end

step "Add role <role> as view user" do |role|
  new_pipeline_group_page.add_new_role_permission("view", role)
end

step "Add user <name> as admin user" do |name|
  new_pipeline_group_page.add_new_user_permission("admin", name)
end

step "Save pipeline group permissions" do
  new_pipeline_group_page.click_on_save
end
