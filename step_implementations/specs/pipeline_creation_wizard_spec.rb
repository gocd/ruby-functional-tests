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

step 'Start add new pipeline in pipeline group <pipeline_group>' do |pipeline_group|
  pipeline_creation_wizard.load(group: pipeline_group)
end

step 'Enter new pipeline name as <name>' do |name|
  pipeline_creation_wizard.new_pipeline_name.set name
end

step 'Select material type as <type>' do |type|
  pipeline_creation_wizard.material_type.select type
end

step 'Set url <url> for material  <material>' do |url, material|
  pipeline_creation_wizard.set_material_url(new_pipeline_dashboard_page.sanitize_message(url))
end

step 'Set pipeline and stage <pipeline> <stage>' do |pipeline, stage|
  pipeline_creation_wizard.pipeline_material.set "#{scenario_state.get(pipeline)} [#{stage}]"
end

step 'Set stage name as <stage_name>' do |stage_name|
  pipeline_creation_wizard.stage_name.set stage_name
end

step 'Set job name as <job_name>' do |job_name|
  pipeline_creation_wizard.job_name.set job_name
end

step 'Set task as <task_with_args>' do |task_with_args|
  pipeline_creation_wizard.set_task_field(task_with_args)
end

step 'Save pipeline <arg0> successfully' do |_arg0|
  pipeline_creation_wizard.save_and_edit
end

step 'Set job name as <job1> - on Job popup' do |job|
  pipeline_creation_wizard.job_name_popup.set job
end

step 'Set command as <command> - On Job popup' do |command|
  pipeline_creation_wizard.command_on_stage_popup.set command
end

step 'Set branch as <branch> for material <material_type>' do |branch, material_type|
  pipeline_creation_wizard.set_branch(branch)
end



step 'Select stage type as <type>' do |type|
  pipeline_creation_wizard.select_approval_type type
end

step 'Check connectivity should be successful' do
  pipeline_creation_wizard.check_connection.click
  assert_true pipeline_creation_wizard.connection_ok?
end

step 'Set exec command as <command>' do |command|
  pipeline_creation_wizard.exec_tas_command.set command
end

step 'Open Materials advanced settings' do ||
  pipeline_creation_wizard.open_material_advanced_settings
end

step 'Set <material_type> username as <username>' do |material_type, username|
  pipeline_creation_wizard.set_username(username)
end

step 'Set <material_type> password as <password>' do |material_type, password|
  pipeline_creation_wizard.set_password(new_pipeline_dashboard_page.sanitize_message(password))
end

step 'Turn off Poll for new changes for <material_type> material' do |material_type|
  pipeline_creation_wizard.set_polling_off material_type
end

step 'Check connectivity should be failed with message <error_message> for <material_type>' do |error_message, material_type|
  pipeline_creation_wizard.check_connection(wait: 10).click
  pipeline_creation_wizard.git_error_message_present?(error_message, material_type)
end
