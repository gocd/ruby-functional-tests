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

step 'Go next from settings' do
  pipeline_creation_wizard.next_to_settings.click
end

step 'Select material type as <type>' do |type|
  pipeline_creation_wizard.select type
end

step 'Set pipeline and stage <pipeline> <stage>' do |pipeline, stage|
  pipeline_creation_wizard.pipeline_material.set "#{scenario_state.get(pipeline)} [#{stage}]"
end

step 'Go next from materials' do ||
	pipeline_creation_wizard.next_to_materials.click
end

step 'Set stage name as <stage_name>' do |stage_name|
	pipeline_creation_wizard.stage_name.set stage_name
end

step 'Mark stage manual - On new pipeline wizard' do ||
	pipeline_creation_wizard.trigger_type_manual.click
end

step 'Set job name as <job_name>' do |job_name|
	pipeline_creation_wizard.job_name.set job_name
end

step 'Select task type as <task_type>' do |task_type|
	pipeline_creation_wizard.task_type.select task_type
end

step 'Set task as <task_name> <field> name <value>' do |task_name, field, value|
	pipeline_creation_wizard.set_task_field(task_name, field, value)
end

step 'Save pipeline <arg0> successfully' do |arg0|
	pipeline_creation_wizard.finish.click
end

step 'Enter material url for parameter <arg0> name <arg1> and material name <arg2> associated with pipeline <arg3>' do |arg0, arg1, arg2, arg3|
	raise 'Unimplemented Step'
end

step 'Add new Job' do ||
pipeline_creation_wizard.add_new_job.click
end

step 'Add task <task> - Already on Add New Job popup' do |task|
	pipeline_creation_wizard.add_new_task(task)
end

step 'Set job name as <job> - Already on Add New Job popup' do |job|
	pipeline_creation_wizard.job_name_on_popup.set job
end

step 'Set command as <command> - Already on Add New Job popup' do |command|
	pipeline_creation_wizard.command_on_popup.set command
end

step 'Set resources as <windows> - Already on Add New Job popup' do |resource|
	pipeline_creation_wizard.resources_on_popup.set resource
end

step 'Set url <url> for material  <material>' do |url,material|
	pipeline_creation_wizard.set_material_url_for(material, url)
end

step 'Set url <url> for material' do |url|
	pipeline_creation_wizard.material_url.set(url)
end

step 'Enter project path as <path>' do |path|
	pipeline_creation_wizard.project_path.set(path)
end

step 'Verify the stages are <stages>' do |stages|
	pipeline_stages=pipeline_creation_wizard.get_pipeline_stages()
	stages.split(',').each{|stage|
		assert_true pipeline_stages.include?stage
	}
end

step 'Verify <stage> has <type> trigger option with <jobs> jobs' do |stage,type,jobs|
   assert_true pipeline_creation_wizard.stage_has_approval_type?stage,type
   assert_true pipeline_creation_wizard.stage_has_jobs?stage,jobs
end

step 'Verify cannot move <stage> to <direction>' do |stage,direction|
	assert_false pipeline_creation_wizard.can_move_stage?stage,direction
end

step 'Move stage <stage> to <direction>' do |stage,direction|
	pipeline_creation_wizard.move_stage stage,direction
end

step 'Verify reset button exists' do ||
	assert_true pipeline_creation_wizard.verify_reset_button_exist?
end

step 'Open tab <tab> - On Pipeline Creation Page' do |tab|
	pipeline_creation_wizard.open_tab(tab)
end

step 'Select tracking tool as <tool>' do |tool|
pipeline_creation_wizard.select_tracking_tool tool
end

step 'Set mingle URL as <url>' do |url|
	pipeline_creation_wizard.mingle_URL.set url
end

step 'Set mingle project identifier as <identifier>' do |identifier|
	pipeline_creation_wizard.mingle_identifier.set identifier
end

step 'Set MQA grouping conditions as <mqa>' do |mqa|
	pipeline_creation_wizard.mingle_mqa.set  mqa
end

step 'Add new stage' do ||
pipeline_creation_wizard.add_new_stage.click
end

step 'Set stage as <stage> - On Add new stage pop up' do |stage|
	pipeline_creation_wizard.stage_on_popup.set stage
end

step 'Set job name as <job1> - on Job popup' do |job|
	pipeline_creation_wizard.job_name_popup.set job
end

step 'Set command as <command> - On Job popup' do |command|
	pipeline_creation_wizard.command_on_stage_popup.set command
end

step 'Open stage <stage>' do |stage|
	pipeline_creation_wizard.select_stage stage
end


step 'Set branch as <branch>' do |branch|
	pipeline_creation_wizard.branch_name.set branch
end

step 'Unpause pipeline - On pipeline creation page' do ||
	pipeline_creation_wizard.unpause_pipeline
end

step 'Select stage type as <type>' do |type|
	pipeline_creation_wizard.select_approval_type type
end
