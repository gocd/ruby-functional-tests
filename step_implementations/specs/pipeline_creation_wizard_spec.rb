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
  pipeline_creation_wizard.pipeline_material.set "#{scenario_state.actual_pipeline_name(pipeline)} [#{stage}]"
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


