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

step 'On Stage settings page of pipeline <pipeline_name> stage <stage_name>' do |pipeline_name, stage_name|
  stage_settings_page.load(pipeline_name: scenario_state.get(pipeline_name), stage_name: stage_name)
end

step 'Open <tab_id> tab - On Stage settings page' do |tab_id|
  stage_settings_page.on_tab(tab_id)
end

step 'Set stage as <stage> - On Stage settings page' do |stage|
  stage_settings_page.stage_name.set stage
end

step 'Verify that stage is named <stage_name>' do |stage_name|
  assert_true stage_settings_page.stage_name.value.include? stage_name
end

step 'Verify job <job> with resources as <resources> and run on all as <run_on_all>' do |job, resources, run_on_all|
  assert_equal resources, stage_settings_page.job_resources(job)
  assert_equal run_on_all, stage_settings_page.run_on_all(job)
end

step 'Open job <job>' do |job|
  stage_settings_page.open_job job
end

step 'Delete job <job>' do |job|
  stage_settings_page.delete_job job
end

step 'Verify <job> job is present' do |job|
  assert_true stage_settings_page.job_present? job
end

step 'Verify <job> job is not present' do |job|
  assert_false stage_settings_page.job_present? job
end

step 'Verify option <option> is selected' do |option|
  assert_true stage_settings_page.option_is_selected? option
end

step 'Verify that the message <message> shows up - Already On Edit Stage Page' do |message|
  assert_true stage_settings_page.has_message?(message)
end

step 'Select <option>' do |option|
  stage_settings_page.select_permission_option(option)
end

step 'Set <user> as user name - On Permission tab' do |user|
  stage_settings_page.set_permission_user user
end

step 'Set <role> as role name - On Permission tab' do |role|
  stage_settings_page.set_permission_role role
end

step 'Verify that user <user> is inherited' do |user|
  inherited_users = stage_settings_page.inherited_users
  assert_true inherited_users.include?(user), "Expected '#{user}' to be a part of '#{inherited_users}'"
end

step 'Verify that role <user> is inherited' do |role|
  inherited_roles = stage_settings_page.inherited_roles
  assert_true inherited_roles.include?(role), "Expected '#{role}' to be a part of '#{inherited_roles}'"
end

step 'Verify that user <user> is already added - On Permission tab' do |user|
  assert_true stage_settings_page.specified_users.include? user
end

step 'Verify that role <role> is already added - On Permission tab' do |role|
  assert_true stage_settings_page.specified_roles.include? role
end

step 'Verify message <message> shows up - On Permission tab' do |message|
  assert_true stage_settings_page.has_message? message
end

step 'Verify auto approval type is selected' do
  assert_true stage_settings_page.auto_selected?
end

step 'Open tab <tab> - On Template Page' do |_tab|
  stage_settings_page.open_tab
end

step 'Add new Job' do
  stage_settings_page.add_new.click
end

step 'Add task <task> - Already on Add New Job popup' do |task|
  stage_settings_page.add_new_task(task)
end

step 'Add task <task> - Already on Add New stage popup' do |task|
  stage_settings_page.task_on_stage_popup.select (task)
end

step 'Set job name as <job> - Already on Add New Job popup' do |job|
  stage_settings_page.job_name_on_popup.set job
end

step 'Mark stage manual - On Stage settings page' do
  stage_settings_page.set_trigger_type(false)
end

step 'Mark stage success - On Stage settings page' do
  stage_settings_page.set_trigger_type(true)
end

step 'Verify <stage> has <type> trigger option with <jobs> jobs' do |stage, type, jobs|
  assert_true stage_settings_page.stage_has_approval_type? stage, type
  assert_true stage_settings_page.stage_has_jobs? stage, jobs
end

step 'Set command as <command> - Already on Add New stage popup' do |command|
  stage_settings_page.command_on_stage_popup.set command
end

step 'Set command args as <args> - Already on Add New stage popup' do |args|
  stage_settings_page.command_args_on_stage_popup.set args
end

step 'Verify error message <message> is shown for stage name' do |message|
  assert_true stage_settings_page.error_message_for_stage_name === new_pipeline_dashboard_page.sanitize_message(message)
end

step 'Add new user permission' do
  stage_settings_page.add_new_user_permission.click
end

step 'Add new role permission' do
  stage_settings_page.add_new_role_permission.click
end

step 'Save job changes' do
  stage_settings_page.save_job.click
end
