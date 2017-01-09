##########################################################################
# Copyright 2016 ThoughtWorks, Inc.
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

step "Trigger <pipeline>" do |pipeline|
  pipeline_dashboard_page.trigger_pipeline pipeline
  #pipeline_dashboard_page.wait_till_pipeline_start_building pipeline,1
end

step "Looking at pipeline <pipeline>" do |pipeline|
  pipeline_dashboard_page.load
  scenario_state.set_current_pipeline pipeline
end

step "Wait till pipeline completed stage <stage>" do |stage|
  pipeline_dashboard_page.wait_till_pipeline_complete scenario_state.current_pipeline, stage
end

step "Verify stage <stage> is <state> on pipeline with label <label>" do |stage, state, label|
  pipeline_dashboard_page.verify_pipeline_stage_state scenario_state.current_pipeline, stage, state
end

step "Verify pipeline <pipeline> shows up on the dashboard" do |pipeline|
  pipeline_dashboard_page.load
  pipeline_dashboard_page.wait_till_pipeline_showsup pipeline
end

step "Verify pipeline <pipeline> do not show up on the dashboard" do |pipeline|
  pipeline_dashboard_page.load
  assert_raise RuntimeError do
    pipeline_dashboard_page.wait_till_pipeline_showsup pipeline
  end
end
