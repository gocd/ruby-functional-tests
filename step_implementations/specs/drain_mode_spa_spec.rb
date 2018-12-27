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

step 'On Drain mode SPA' do
  drain_mode_page.load
end

step 'Enable drain mode' do
  drain_mode_page.switch_drain_mode
  assert_true drain_mode_page.drain_in_progress?
end

step 'Verify in progress subsystems section shows pipeline <pipeline> counter <p_counter> stage <stage> counter <s_counter>' do |pipeline, p_counter, stage, s_counter|
  assert_true drain_mode_page.stage_in_inprogress_subsystem(scenario_state.get(pipeline), p_counter, stage, s_counter)
end

step 'Verify in progress subsystems section does not show pipeline <pipeline> counter <p_counter> stage <stage> counter <s_counter>' do |pipeline, p_counter, stage, s_counter|
  assert_false drain_mode_page.stage_in_inprogress_subsystem(scenario_state.get(pipeline), p_counter, stage, s_counter)
end

step 'Verify pipeline <pipeline> counter <p_counter> stage <stage> counter <s_counter> can be cancelled - On Drain mode SPA' do |pipeline, p_counter, stage, s_counter|
  assert_false drain_mode_page.stage_in_inprogress_subsystem(scenario_state.get(pipeline), p_counter, stage, s_counter)
end

step 'Verify drain mode banner is shown' do
  assert_true drain_mode_page.has_css? drain_mode_banner
end

step 'Cancel pipeline <pipeline> counter <p_counter> stage <stage> counter <s_counter> - On Drain mode spa' do |pipeline, p_counter, stage, s_counter|
  drain_mode_page.cancel_stage(scenario_state.get(pipeline), p_counter, stage, s_counter)
end

step 'Verify drain mode successful' do
  assert_true drain_mode_page.drain_complete?
end

step 'Disable drain mode' do
  drain_mode_page.switch_drain_mode
  assert_false drain_mode_page.drain_mode_enabled?
end

step 'Verify in progress subsystems section shows material <name>' do |name|
	drain_mode_page.shows_running_mdu_for_material(name)
end