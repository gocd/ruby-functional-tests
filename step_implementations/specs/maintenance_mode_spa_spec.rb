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

step 'On Maintenance mode SPA' do
  maintenance_mode_page.load
end

step 'Enable maintenance mode' do
  maintenance_mode_page.switch_maintenance_mode
end

step 'Verify maintenance mode is in progress' do
  wait_till_event_occurs_or_bomb 30, 'Maintenance mode is not enabled as expected' do
    break if maintenance_mode_page.maintenance_in_progress?
  end
end

step 'Verify maintenance mode completed' do
  wait_till_event_occurs_or_bomb 30, 'Maintenance mode is not enabled as expected' do
    break if maintenance_mode_page.maintenance_complete?
  end
end

step 'Verify in progress subsystems section shows pipeline <pipeline> counter <p_counter> stage <stage> counter <s_counter>' do |pipeline, p_counter, stage, s_counter|
  assert_true maintenance_mode_page.stage_in_inprogress_subsystem(scenario_state.get(pipeline), p_counter, stage, s_counter)
end

step 'Verify in progress subsystems section does not show pipeline <pipeline> counter <p_counter> stage <stage> counter <s_counter>' do |pipeline, p_counter, stage, s_counter|
  assert_false maintenance_mode_page.stage_in_inprogress_subsystem(scenario_state.get(pipeline), p_counter, stage, s_counter)
end

step 'Verify pipeline <pipeline> counter <p_counter> stage <stage> counter <s_counter> can be cancelled - On Maintenance mode SPA' do |pipeline, p_counter, stage, s_counter|
  assert_false maintenance_mode_page.stage_in_inprogress_subsystem(scenario_state.get(pipeline), p_counter, stage, s_counter)
end

step 'Verify maintenance mode banner is shown' do
  assert_true maintenance_mode_page.maintenance_mode_banner_shown?
end

step 'Verify maintenance mode banner is not shown' do
  assert_false maintenance_mode_page.maintenance_mode_banner_shown?
end

step 'Cancel pipeline <pipeline> counter <p_counter> stage <stage> counter <s_counter> - On Maintenance mode spa' do |pipeline, p_counter, stage, s_counter|
  maintenance_mode_page.cancel_stage(scenario_state.get(pipeline), p_counter, stage, s_counter)
end

step 'Disable maintenance mode' do
  maintenance_mode_page.switch_maintenance_mode
  assert_false maintenance_mode_page.maintenance_mode_enabled?
end

step 'Verify in progress subsystems section shows material <name>' do |name|
  maintenance_mode_page.shows_running_mdu_for_material(name)
end

step 'Verify server is not in maintenance mode' do
  assert_false maintenance_mode_page.maintenance_mode_enabled?
end

step 'Maintenance mode - teardown' do
  maintenance_mode_page.load
	maintenance_mode_page.disable_maintenance_mode
end
