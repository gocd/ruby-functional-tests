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

step 'Open stage overview for stage <stage> - On Swift Dashboard page' do |stage|
  new_pipeline_dashboard_page.open_stage_overview scenario_state.self_pipeline, stage
end

step 'Verify stage overview has header <pipeline> <pipeline_counter> <stage> <stage_counter>' do |pipeline, pipeline_counter, stage, stage_counter|
  new_pipeline_dashboard_page.verify_stage_overview_header pipeline, pipeline_counter, stage, stage_counter
end

step 'Verify stage overview renders stage triggered by <username>' do |username|
  new_pipeline_dashboard_page.verify_stage_overview_triggered_by_user username
end

step 'Verify stage overview renders triggered by time and duration' do
  new_pipeline_dashboard_page.verify_stage_overview_element_not_empty "triggered-on-container"
end

step 'Verify stage overview renders stage cancelled by <username>' do |username|
  new_pipeline_dashboard_page.verify_stage_overview_cancelled_by_user username
end

step 'Verify stage overview renders cancelled by time' do
  new_pipeline_dashboard_page.verify_stage_overview_element_not_empty "cancelled-on-container"
end


step 'Verify stage overview renders rerun stage button in enabled state' do
  new_pipeline_dashboard_page.verify_stage_overview_rerun_stage_is_enabled
end

step 'Verify stage overview renders cancel stage button in enabled state' do
  new_pipeline_dashboard_page.verify_stage_overview_cancel_stage_is_enabled
end

step 'Verify stage overview renders stage settings button in enabled state' do
  new_pipeline_dashboard_page.verify_stage_overview_stage_settings_is_enabled
end

step 'Verify stage overview renders rerun stage button in disabled state' do
  new_pipeline_dashboard_page.verify_stage_overview_rerun_stage_is_disabled
end

step 'Verify stage overview renders stage settings button in disabled state' do
  new_pipeline_dashboard_page.verify_stage_overview_stage_settings_is_disabled
end

step 'Go to stage settings page from stage overview and verify page url for stage <stage>' do |stage|
  new_pipeline_dashboard_page.open_stage_settings_from_stage_overview_and_verify_url "/go/admin/pipelines/#{scenario_state.self_pipeline}/edit#!#{scenario_state.self_pipeline}/#{stage}/stage_settings"
end

step 'Go to stage details page from stage overview and verify page url for stage <stage> <counter>' do |stage, counter|
  new_pipeline_dashboard_page.open_stage_details_from_stage_overview_and_verify_url "/go/pipelines/#{scenario_state.self_pipeline}/1/#{stage}/#{counter}"
end

step 'Rerun stage from stage overview' do
  new_pipeline_dashboard_page.stage_overview_rerun_stage
end

step 'Cancel stage from stage overview' do
  new_pipeline_dashboard_page.stage_overview_cancel_stage
end

step 'Verify page url is <url>' do |url|
  new_pipeline_dashboard_page.verify_page_url url
end
