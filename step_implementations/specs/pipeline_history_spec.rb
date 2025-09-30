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
@auto_refresh = false
step 'Verify pipeline activity page is shown' do |_tmp|
  assert_true pipeline_history_page.has_pipeline_activity_page?
end

step 'Verify pipeline history page <page_number> is shown' do |page_number|
  pipeline_history_page.verify_current_pagination_number page_number
end

step 'Navigate to next pipeline history page' do
  pipeline_history_page.click_for_next_page
end

step 'Navigate to previous pipeline history page' do
  pipeline_history_page.click_for_previous_page
end

step 'Verify pipeline history list starts with <pipeline_histories>' do |pipeline_histories|
  pipeline_history_page.verify_stage_history_starts_with pipeline_histories
end

step 'Verify pipeline history list doesnt have <pipeline_histories>' do |pipeline_histories|
  pipeline_history_page.verify_stage_history_doesnt_have pipeline_histories
end

step 'Search for <search_string> on pipeline history page' do |search_string|
  pipeline_history_page.search_given_pipeline search_string
end

step 'Click on page number <clickable_page_number>' do |clickable_page_number|
  pipeline_history_page.click_on_pagenumber clickable_page_number
end

step 'Clear label filter selection field' do
  pipeline_history_page.clear_label_filter_selection
end

step 'Approve stage <stage> with label <label>' do |stage, label|
  # Since there is javascript alert on history page during stage approval handling stage approval via API
  begin
    RestClient.post http_url("/api/stages/#{scenario_state.self_pipeline}/#{label}/#{stage}/run"), {}, {accept: 'application/vnd.go.cd+json', X_GoCD_Confirm: 'true'}.merge(basic_configuration.header)
  rescue RestClient::ExceptionWithResponse => err
    p "Stage #{stage} approval on history page failed with response code #{err.response.code} and the response body - #{err.response.body}"
  end
end

step 'Open build cause of pipeline with label <label>' do |label|
  pipeline_history_page.open_build_cause(scenario_state.self_pipeline, label)
end

step 'Verify build cause message contains <message>' do |message|
  pipeline_history_page.shows_build_cause_message?(message)
end

step 'Verify pipeline with label <label> is triggered by <user>' do |label, user|
  pipeline_history_page.triggered_by?(scenario_state.self_pipeline, label, user)
end

step 'Pause pipeline on activity page' do ||
  pipeline_history_page.pause_pipeline
end

step 'Looking at pipeline with label <label>' do |label|
  scenario_state.put('current_label', label)
end

step 'Verify stage <stage_name> of pipeline can be rerun' do |stage_name|
  pipeline_history_page.verify_stage_can_rerun?(scenario_state.get('current_label'), stage_name)
end

step 'Rerun stage <stage_name> - Already On Pipeline History Page' do |stage_name|
  pipeline_history_page.stage_rerun(scenario_state.get('current_label'), stage_name)
end

step 'Verify <stage_name> stage can be cancelled' do |stage_name|
  pipeline_history_page.verify_stage_can_cancel?(scenario_state.get('current_label'), stage_name)
end

step 'Verify pipeline is paused on pipeline activity page' do ||
  pipeline_history_page.verify_pipeline_is_paused?
end

step 'Unpause pipeline on pipeline activity page' do ||
  pipeline_history_page.pause_pipeline
end

step 'Verify <stage_name> can be approved on Pipeline Activity Page' do |stage_name|
  pipeline_history_page.verify_stage_can_be_approved?(stage_name, scenario_state.get('current_label'))
end

step 'Approve stage <stage_name> on Pipeline Activity Page' do |stage_name|
  pipeline_history_page.approve_stage(stage_name, scenario_state.get('current_label'))
end

step 'Verify stage <stage_name> of pipeline cannot be rerun on Pipeline Activity Page' do |stage_name|
  pipeline_history_page.verify_stage_cannot_rerun?(scenario_state.get('current_label'), stage_name)
end

step 'Verify <stage_name> cannot be approved on Pipeline Activity Page' do |stage_name|
  pipeline_history_page.verify_cannot_approve_stage?(stage_name, scenario_state.get('current_label'))
end

step 'Verify on pipeline history page for <pipeline>' do |pipeline|
  assert_true pipeline_history_page.current_path.include? scenario_state.get(pipeline)
end

step 'Verify pipeline is triggered by <user> - On History page' do |user|
  assert_true pipeline_history_page.triggered_by_on_history_page? user
end

step 'Open stage overview for stage <stage> - On Pipeline Activity page' do |stage|
  pipeline_history_page.open_stage_overview stage
end
