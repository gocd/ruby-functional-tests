##########################################################################
# Copyright 2022 Thoughtworks, Inc.
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
  stage_details_page.load(pipeline_name: scenario_state.get(pipeline_name), label: label, stage_name: stage_name, counter: counter, tab_name: tab)
end

step 'Looking at material of type <material_type> named <material_name>' do |material_type, material_name|
  scenario_state.put('current_material_type', material_type)
  scenario_state.put('current_material_name', material_name)
end

step 'Verify modification <modification_number> has latest revision' do |modification_number|
  assert_true stage_details_page.verify_latest_revision_for_modification(modification_number)
end

step 'Verify modification <modification_number> has revision <revision> - Already On Build Cause Section' do |modification_number, revision|
  material_type =   scenario_state.get('current_material_type')
  actual_revision = revision
  if material_type == 'Pipeline'
    revision_arr = revision.split(/\//)
    upstream_pipeline = revision_arr[0]
    revision_arr.delete(upstream_pipeline)
    actual_revision = [scenario_state.get(upstream_pipeline), revision_arr.join('/')].join('/')
  end
  assert_true stage_details_page.verify_revision_for_modification(modification_number, actual_revision)
end

step 'Verify material has changed - Already On Build Cause Section' do |_tmp|
  material_type =   scenario_state.get('current_material_type')
  material_name =   scenario_state.get('current_material_name')
  assert_true stage_details_page.verify_material_has_changed(material_type, material_name)
end

step 'Verify material has not changed - Already On Build Cause Section' do |_tmp|
  material_type =   scenario_state.get('current_material_type')
  material_name =   scenario_state.get('current_material_name')
  assert_false stage_details_page.verify_material_has_changed(material_type, material_name)
end

step 'Verify modification <modification_number> is checked in by <user_name> with comment <comment>' do |modification_number, user_name, comment|
  assert_true stage_details_page.verify_comment_in_modification(modification_number, comment)
  assert_true stage_details_page.verify_modification_triggered_by(modification_number, user_name)
end

step 'Verify modification <modification_number> is checked with comment <comment>' do |modification_number,comment|
  assert_true stage_details_page.verify_comment_in_modification(modification_number, comment)
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

step 'Wait for jobs to show <status> with jobs <job>' do |status,job|
 assert_true stage_details_page.status_with_job?(status,job)
end

step 'Verify Trigger is enabled for stage <stage>' do |stage|
  stage_details_page.stage_trigger_is_enabled? stage
end

step 'Verify stage <stage> does not have any action' do |stage|
  assert_false stage_details_page.stage_has_no_actions?(stage)
end

step 'Verify stage <stage> has action <action>' do |stage, action|
 assert_true stage_details_page.stage_has_action?(stage,action)
end

step 'Verify stage <stage> does not have action <action>' do |stage, action|
  assert_false stage_details_page.stage_has_action?(stage,action)
end

step 'Trigger stage <stage> - On stage details page' do |stage|
  stage_details_page.trigger_stage(stage)
end

step 'Click on stage bar run <run>' do |run|
  stage_details_page.click_other_runs(run)
end

step 'Verify jobs shows <status> collapsed' do |status|
  assert_true stage_details_page.job_status_in_collapsed_state.include?status
end

step 'Verify jobs shows <status> open with jobs <jobs>' do |status,jobs|
  assert_true stage_details_page.job_status_in_collapsed_state.include?status
  jobs.split(',').each {|job|
    assert_true stage_details_page.open_jobs(job,status.partition(':').first.downcase)
  }
end

step 'Verify stage bar is displaying run <run>' do |run|
  assert_equal run, stage_details_page.stage_bar_run.text
end

step 'Verify stage history has <runs>' do |runs|
  all_history_runs=stage_details_page.history_runs
  runs.split(', ').each {|run|
    assert_true all_history_runs.include?run
  }
end

step 'Verify stage bar triggered by shows <user>' do |user|
  assert_equal user, stage_details_page.stage_triggered_user.text
end

step 'Verify stage bar cancelled by shows <user>' do |user|
  assert_equal user, stage_details_page.stage_cancelled_user.text.partition(': ').last
end

step 'Verify stage bar triggered automatically by changes' do ||
  assert_equal "Automatically triggered", stage_details_page.automatically_triggered.text
end

step 'Verify selected stage history entry is <entry>' do |entry|
  assert_true stage_details_page.selected_history_entry.include?entry
end

step 'click on stage history page of number <number>' do |number|
  stage_details_page.click_stage_history_of_page_number(number)
end

step 'Verify stage history has <runs> - on Stage details page.' do |runs|
  stage_details_page.verify_total_history_runs runs
end

step 'Verify pipeline history page <page_number> is shown - on Stage details page' do |page_number|
  assert_true stage_details_page.has_history_page_number?(page_number)
end

step 'Setting first stage to auto approval' do ||
  basic_configuration.auto_approve_first_stage()
end

step 'Verify config changed marker after pipeline counter <pipeline_counter> stage counter <stage_counter> is a link' do |pipeline_counter,stage_counter|
  assert_true stage_details_page.config_changed_marker_exists?pipeline_counter,stage_counter
end

step 'Click on config changed link after pipeline counter <pipeline_counter> stage counter <stage_counter>' do |pipeline_counter,stage_counter|
  stage_details_page.click_config_changed_link pipeline_counter,stage_counter
end

step 'Verify added changes contains lines <lines>' do |lines|
  assert_true stage_details_page.config_changed_added_contains?lines
end

step 'Verify removed changes contains lines <lines>' do |lines|
  assert_true stage_details_page.config_changed_removed_contains?lines
end

step 'Verify config changed marker after pipeline counter <pipeline_counter> stage counter <stage_counter> is not a link' do |pipeline_counter,stage_counter|
  assert_false stage_details_page.config_changed_marker_exists?pipeline_counter,stage_counter
end

step 'Verify stage history shows current stage as <status>' do |status|
  assert_true stage_details_page.history_shows_status? status
end

step 'Verify stage bar triggered at shows a date' do ||
  assert_true stage_details_page.stage_bar_has_date?
end

step 'Verify stage bar does not have other runs' do ||
  assert_false stage_details_page.stage_has_other_runs?
end

step 'Verify stage bar duration shows a time' do ||
  assert_true stage_details_page.stage_bar_has_time?
end

step 'Wait for stage bar to show other runs' do ||
  stage_details_page.wait_for_stage_bar_to_show_run
end

step 'Click compare link for pipeline counter <counter>' do |counter|
  stage_details_page.select_counter_from_history counter
end

step 'Click Compare pipeline link - Already on stage details page' do ||
  stage_details_page.compare_pipeline_link.click
end

step 'Click compare link - Already on stage Detail Page' do
  stage_details_page.compare.click
end

step 'Click on revision <revision> - Already On Stage Detail Materials Tab' do |revision|
  stage_details_page.click_revision_link new_pipeline_dashboard_page.sanitize_message(revision)
end

step 'Verify current pipeline has label with counter <counter> concatenated with material revision of modification <modification_number>' do |counter,modification_number|
  assert_true stage_details_page.material_rev_concatinated_label?counter,modification_number
end
