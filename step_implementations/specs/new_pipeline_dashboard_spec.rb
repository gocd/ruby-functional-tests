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

@auto_refresh = true

step 'Trigger <pipeline> - On Swift Dashboard page' do |pipeline|
  new_new_pipeline_dashboard_page.trigger_pipeline pipeline
end

step 'Looking at pipeline <pipeline> - On Swift Dashboard page' do |pipeline|
  new_pipeline_dashboard_page.load(autoRefresh: @auto_refresh)
  scenario_state.set_current_pipeline pipeline
end

step 'Turn off AutoRefresh - On Swift Dashboard page' do |_pipeline|
  @auto_refresh = false
end

step 'Wait till stage <stage> completed - On Swift Dashboard page' do |stage|
  new_pipeline_dashboard_page.wait_till_stage_complete scenario_state.current_pipeline, stage
end

step 'Wait till pipeline completed - On Swift Dashboard page' do |_stage|
  new_pipeline_dashboard_page.wait_till_pipeline_complete scenario_state.current_pipeline
end

step 'Verify stage <stage> is <state> - On Swift Dashboard page' do |stage, state|
  new_pipeline_dashboard_page.verify_pipeline_stage_state scenario_state.current_pipeline, stage, state
end

step 'Verify pipeline <pipeline> shows up - On Swift Dashboard page' do |pipeline|
  new_pipeline_dashboard_page.load(autoRefresh: @auto_refresh)
  new_pipeline_dashboard_page.wait_till_pipeline_showsup pipeline
end

step 'Verify pipeline <pipeline> do not show up - On Swift Dashboard page' do |pipeline|
  new_pipeline_dashboard_page.load(autoRefresh: @auto_refresh)
  assert_raise RuntimeError do
    new_pipeline_dashboard_page.wait_till_pipeline_showsup pipeline
  end
end

step 'Verify pipeline is editable - On Swift Dashboard page' do |pipeline|
  assert_true new_pipeline_dashboard_page.editable?
end

step 'Verify pipeline is not editable - On Swift Dashboard page' do |pipeline|
  assert_false new_pipeline_dashboard_page.editable?
end

step 'Verify pipeline is locked - On Swift Dashboard page' do |pipeline|
  assert_true new_pipeline_dashboard_page.locked?
end

step 'Verify pipeline is not locked - On Swift Dashboard page' do |pipeline|
  assert_false new_pipeline_dashboard_page.locked?
end

step 'Verify pipeline <pipeline> is not visible' do |pipeline|
  assert_false new_pipeline_dashboard_page.visible?(pipeline)
end

step 'Verify group <group> is not visible' do |group|
  assert_false new_pipeline_dashboard_page.group_visible?(group)
end

step 'Verify pipeline is in group <group>' do |group|
  assert_true new_pipeline_dashboard_page.pipeline_in_group?(group)
end

step 'Verify pipeline has no history' do |_tmp|
  assert_true new_pipeline_dashboard_page.pipeline_history_exists?
end

step 'Verify pipeline is triggered by <user>' do |user|
  assert_true new_pipeline_dashboard_page.triggered_by? user
end

step 'Pause pipeline with reason <message>' do |message|
  new_pipeline_dashboard_page.pause_pipeline(reason)
end

step 'Verify pipeline is paused with reason <reason> by <user>' do |reason, user|
  new_pipeline_dashboard_page.pause_message?("Paused by #{user} (#{reason})")
end

step 'Unpause pipeline' do |tmp|
  new_pipeline_dashboard_page.unpause_pipeline
end

step 'Click on history' do |tmp|
  new_pipeline_dashboard_page.click_history
end

step 'Open changes section' do |tmp|
  new_pipeline_dashboard_page.open_build_cause
end

step 'Looking at material of type <material_type> named <name>' do |type, name|
  latest_revision = Context::GitMaterials.new(basic_configuration.material_url_for(scenario_state.self_pipeline)).latest_revision
  revision = new_pipeline_dashboard_page.revision_of_material(type, name)
  new_pipeline_dashboard_page.shows_revision?(revision, latest_revision)
end

step 'Checkin file <filename> as user <user> with message <message>' do |filename, user, message|
  Context::GitMaterials.new(basic_configuration.material_url_for(scenario_state.self_pipeline)).new_commit(filename, user, message)
end