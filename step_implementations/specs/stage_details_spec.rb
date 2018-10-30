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

step 'On stage details page <tab> tab for <pipeline_name> label <label> stage name <stage_name> counter <counter>' do |tab,pipeline_name, label, stage_name, counter|
  stage_details_page.load(pipeline_name: scenario_state.actual_pipeline_name(pipeline_name), label: label, stage_name: stage_name, counter: counter, tab_name: tab)
end

step 'Looking at material of type <material_type> named <material_name>' do |material_type, material_name|
  scenario_state.store('current_material_type', material_type)
  scenario_state.store('current_material_name', material_name)
end

step 'Verify modification <modification_number> has latest revision' do |modification_number|
  assert_true stage_details_page.verify_latest_revision_for_modification(modification_number)
end

step 'Verify modification <modification_number> has revision <revision> - Already On Build Cause Section' do |modification_number, revision|
  material_type =   scenario_state.retrieve('current_material_type')
  actual_revision = revision
  if material_type == 'Pipeline'
    revision_arr = revision.split(/\//)
    upstream_pipeline = revision_arr[0]
    revision_arr.delete(upstream_pipeline)
    actual_revision = [scenario_state.actual_pipeline_name(upstream_pipeline), revision_arr.join('/')].join('/')
  end
  assert_true stage_details_page.verify_revision_for_modification(modification_number, actual_revision)
end

step 'Verify material has changed - Already On Build Cause Section' do |_tmp|
  material_type =   scenario_state.retrieve('current_material_type')
  material_name =   scenario_state.retrieve('current_material_name')
  assert_true stage_details_page.verify_material_has_changed(material_type, material_name)
end

step 'Verify material has not changed - Already On Build Cause Section' do |_tmp|
  material_type =   scenario_state.retrieve('current_material_type')
  material_name =   scenario_state.retrieve('current_material_name')
  assert_false stage_details_page.verify_material_has_changed(material_type, material_name)
end

step 'Verify modification <modification_number> is checked in by <user_name> with comment <comment>' do |modification_number, user_name, comment|
  assert_true stage_details_page.verify_comment_in_modification(modification_number, comment)
  assert_true stage_details_page.verify_modification_triggered_by(modification_number, user_name)
end

step 'Verify the lock status is <status> - On Stage Details page' do |status|
  assert_true stage_details_page.locked_status?(status)
end

step 'Unlock the pipeline - On Stage Details page' do
	stage_details_page.unlock_pipeline
end

step 'Rerun stage <stage> - On Stage Details page' do |stage|
	stage_details_page.rerun_stage(stage)
end

step 'Cancel <stage> - On Stage Detail Page' do |stage|
	stage_details_page.cancel_stage(stage)
end

step 'Verify rerun is enabled for stage <stage_name>' do |stage_name|
	stage_details_page.verify_stage_rerun_is_enabled? stage_name
end

step 'Verify rerun selected button is enabled on jobs tab' do ||
  stage_details_page.verify_jobs_can_rerun?
end

step 'Verify stage result shows <status> - On Stage Detail Page' do |status|
  stage_details_page.check_pipeline_status(status)
end