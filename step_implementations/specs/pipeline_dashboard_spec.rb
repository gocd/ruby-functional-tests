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

@auto_refresh = false

step 'Trigger <pipeline>' do |pipeline|
  pipeline_dashboard_page.trigger_pipeline pipeline
end

step 'Looking at pipeline <pipeline>' do |pipeline|
  pipeline_dashboard_page.load(autoRefresh: @auto_refresh)
  scenario_state.set_current_pipeline pipeline
end

step 'Turn off AutoRefresh - Dashboard page' do |_pipeline|
  @auto_refresh = false
end

step 'Wait till stage <stage> completed' do |stage|
  pipeline_dashboard_page.wait_till_stage_complete scenario_state.current_pipeline, stage
end

step 'Wait till pipeline completed' do |_stage|
  pipeline_dashboard_page.wait_till_pipeline_complete scenario_state.current_pipeline
end

step 'Verify stage <stage> is <state>' do |stage, state|
  pipeline_dashboard_page.verify_pipeline_stage_state scenario_state.current_pipeline, stage, state
end

step 'Verify pipeline <pipeline> shows up on the dashboard' do |pipeline|
  pipeline_dashboard_page.load(autoRefresh: @auto_refresh)
  pipeline_dashboard_page.wait_till_pipeline_showsup pipeline
end

step 'Verify pipeline <pipeline> do not show up on the dashboard' do |pipeline|
  pipeline_dashboard_page.load(autoRefresh: @auto_refresh)
  assert_raise RuntimeError do
    pipeline_dashboard_page.wait_till_pipeline_showsup pipeline
  end
end

step 'Verify pipeline <pipeline> is editable' do |pipeline|
  assert_true pipeline_dashboard_page.is_editable?(pipeline)
end

step 'Verify pipeline <pipeline> is not editable' do |pipeline|
  assert_false pipeline_dashboard_page.is_editable?(pipeline)
end

step 'Verify pipeline <pipeline> is locked - On dashboard page' do |pipeline|
  assert_true pipeline_dashboard_page.is_locked?(pipeline)
end

step 'Verify pipeline <pipeline> is not locked - On dashboard page' do |pipeline|
  assert_false pipeline_dashboard_page.is_locked?(pipeline)
end
