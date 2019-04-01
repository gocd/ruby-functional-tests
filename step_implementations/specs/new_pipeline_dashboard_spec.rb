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

step 'On Swift Dashboard Page' do |_tmp|
  new_pipeline_dashboard_page.load(autoRefresh: @auto_refresh)
end

step 'Turn on AutoRefresh - On Swift Dashboard page' do |_pipeline|
  @auto_refresh = true
end

step 'Trigger pipeline - On Swift Dashboard page' do |_tmp|
  new_pipeline_dashboard_page.trigger_pipeline
end

step 'Trigger pipeline and wait for building - On Swift Dashboard page' do |_tmp|
  new_pipeline_dashboard_page.trigger_pipeline(wait_to_build: true)
end

step 'Looking at pipeline <pipeline> - On Swift Dashboard page' do |pipeline|
  new_pipeline_dashboard_page.load(autoRefresh: @auto_refresh)
  scenario_state.put 'current_pipeline', pipeline
end

step 'Turn off AutoRefresh - On Swift Dashboard page' do |_pipeline|
  @auto_refresh = false
end

step 'Wait till stage <stage> completed - On Swift Dashboard page' do |stage|
  new_pipeline_dashboard_page.wait_till_stage_complete stage
end

step 'Wait till pipeline completed - On Swift Dashboard page' do |_stage|
  new_pipeline_dashboard_page.wait_till_pipeline_complete
end

step 'Wait for <secs> seconds till pipeline completed - On Swift Dashboard page' do |secs|
  new_pipeline_dashboard_page.wait_till_pipeline_complete(secs.to_i)
end

step 'Verify stage <stage> is <state> - On Swift Dashboard page' do |stage, state|
  new_pipeline_dashboard_page.verify_pipeline_stage_state scenario_state.get('current_pipeline'), stage, state.downcase
end

step 'Trigger and cancel stage <defaultStage> <trigger_number> times' do |stage_name, trigger_number|
  scenario_state.put 'current_stage_name', stage_name
  new_pipeline_dashboard_page.trigger_cancel_pipeline trigger_number
end

step 'Trigger and wait for stage <stage> is <state> with label <label> - On Swift Dashboard page' do |stage, state, label|
  new_pipeline_dashboard_page.trigger_pipeline
  new_pipeline_dashboard_page.wait_till_pipeline_complete
  new_pipeline_dashboard_page.verify_pipeline_stage_state scenario_state.self_pipeline, stage, state.downcase
  new_pipeline_dashboard_page.verify_pipeline_is_at_label scenario_state.self_pipeline, label
end

step 'Verify stage <stage> is <state> on pipeline with label <label> - On Swift Dashboard page' do |stage, state, label|
  new_pipeline_dashboard_page.verify_pipeline_stage_state scenario_state.self_pipeline, stage, state.downcase
  new_pipeline_dashboard_page.verify_pipeline_is_at_label scenario_state.self_pipeline, label
end

step 'Verify stage <stage> is <state> on pipeline with label <label> and counter <counter> - On Swift Dashboard page' do |stage, state, label,counter|
  new_pipeline_dashboard_page.verify_pipeline_stage_state scenario_state.self_pipeline, stage, state.downcase
  new_pipeline_dashboard_page.verify_pipeline_is_at_label scenario_state.self_pipeline, label
  new_pipeline_dashboard_page.verify_stage_counter_on_pipeline scenario_state.self_pipeline, stage, label, counter
end

step 'Verify stage <stage> is with label <label> - On Swift Dashboard page' do |_stage, label|
  new_pipeline_dashboard_page.verify_pipeline_is_at_label scenario_state.get('current_pipeline'), label
end

step 'Verify pipeline <pipeline> does not trigger and stays at label <label> - On Swift Dashboard page' do |pipeline, label|
  new_pipeline_dashboard_page.verify_pipeline_stays_at_label scenario_state.get(pipeline), label
end

step 'Verify pipeline <pipeline> shows up - On Swift Dashboard page' do |pipeline|
  new_pipeline_dashboard_page.load(autoRefresh: @auto_refresh)
  new_pipeline_dashboard_page.wait_till_pipeline_showsup pipeline
end

step 'Verify pipeline <pipeline> do not show up - On Swift Dashboard page' do |pipeline|
  new_pipeline_dashboard_page.load(autoRefresh: @auto_refresh)
  assert_raise RuntimeError do
    new_pipeline_dashboard_page.wait_till_pipeline_showsup pipeline, 5
  end
end

step 'Verify pipeline is editable - On Swift Dashboard page' do |_pipeline|
  assert_true new_pipeline_dashboard_page.editable?
end

step 'Verify pipeline is not editable - On Swift Dashboard page' do |_pipeline|
  assert_false new_pipeline_dashboard_page.editable?
end

step 'Verify pipeline is locked - On Swift Dashboard page' do |_pipeline|
  assert_true new_pipeline_dashboard_page.locked?
end

step 'Verify pipeline is not locked - On Swift Dashboard page' do |_pipeline|
  assert_false new_pipeline_dashboard_page.locked?
end

step 'Unlock the pipeline - On Swift Dashboard Page' do |_tmp|
  new_pipeline_dashboard_page.unlock
end

step 'Verify pipeline <pipeline> is not visible - On Swift Dashboard page' do |pipeline|
  assert_false new_pipeline_dashboard_page.visible?(pipeline)
end

step 'Verify pipeline <pipeline> is visible - On Swift Dashboard page' do |pipeline|
  assert_true new_pipeline_dashboard_page.visible?(pipeline)
end

step 'Verify group <group> is not visible - On Swift Dashboard page' do |group|
  assert_false new_pipeline_dashboard_page.group_visible?(group)
end

step 'Verify group <group> is visible - On Swift Dashboard page' do |group|
  assert_true new_pipeline_dashboard_page.group_visible?(group)
end

step 'Verify pipeline is in group <group> - On Swift Dashboard page' do |group|
  assert_true new_pipeline_dashboard_page.pipeline_in_group?(group)
end

step 'Verify pipeline has no history - On Swift Dashboard page' do |_tmp|
  assert_true new_pipeline_dashboard_page.pipeline_history_exists?
end

step 'Verify pipeline is triggered by <user> - On Swift Dashboard page' do |user|
  assert_true new_pipeline_dashboard_page.triggered_by? user
end

step 'Pause pipeline with reason <message> - On Swift Dashboard page' do |message|
  new_pipeline_dashboard_page.pause_pipeline(message)
end

step 'Verify pipeline is paused with reason <reason> by <user> - On Swift Dashboard page' do |reason, user|
  assert_true new_pipeline_dashboard_page.pause_message?("Paused by #{user} (#{reason})")
end

step 'Verify pipeline is paused by <user> - On Swift Dashboard page' do |user|
  assert_true new_pipeline_dashboard_page.pause_message?("Paused by #{user} ()")
end

step 'Unpause pipeline - On Swift Dashboard page' do |_tmp|
  new_pipeline_dashboard_page.unpause_pipeline
end

step 'Click on history - On Swift Dashboard page' do |_tmp|
  new_pipeline_dashboard_page.click_history
end

step 'Open changes section - On Swift Dashboard page' do |_tmp|
  new_pipeline_dashboard_page.open_build_cause
end

step 'Verify can trigger pipeline' do |_tmp|
  assert_false new_pipeline_dashboard_page.trigger_pipeline_disabled?
end

step 'Looking at material of type <material_type> named <name> verify shows latest revision - On Swift Dashboard page' do |type, name|
  latest_revision = Context::GitMaterials.new(basic_configuration.material_url_for(scenario_state.self_pipeline)).latest_revision
  material_name = new_pipeline_dashboard_page.sanitize_message(name)
  revision = new_pipeline_dashboard_page.revision_of_material(type, material_name)
  new_pipeline_dashboard_page.shows_revision_at?(revision, latest_revision)
end

step 'With material <material> of type <type> for pipeline <pipeline>' do |material_name,material_type,pipeline|
  current_material_url=basic_configuration.material_url(pipeline,material_type,material_name)
  scenario_state.put("current_material_url",current_material_url)
end

step 'Checkin file <filename> as user <user> with message <message> - On Swift Dashboard page' do |filename, user, message|
  Context::GitMaterials.new(scenario_state.get("current_material_url")).new_commit(filename, message, user)
end

step 'Open trigger with options - On Swift Dashboard page' do |_tmp|
  new_pipeline_dashboard_page.trigger_pipeline_with_options
end

step 'Verify last run revision is <identifier> - On Swift Dashboard page' do |revision_id|
  assert_true new_pipeline_dashboard_page.last_run_revision.eql? scenario_state.material_revision revision_id
end

step 'Close - Trigger with options - On Swift Dashboard page' do |_tmp|
  new_pipeline_dashboard_page.close_trigger_with_options
end

step 'Trigger pipeline with options - On Swift Dashboard page' do |_tmp|
  new_pipeline_dashboard_page.trigger_with_options
end

step 'Using material <material_name> set revision to trigger with as <identifier> - On Swift Dashboard page' do |material_name, identifier|
  material_name = new_pipeline_dashboard_page.sanitize_message(material_name)
  identifier = new_pipeline_dashboard_page.sanitize_message(identifier)
  new_pipeline_dashboard_page.set_revision_to_trigger_with(material_name, identifier)
end

step 'Verify cannot trigger pipeline' do |_tmp|
  assert_true new_pipeline_dashboard_page.trigger_pipeline_disabled?
end

step 'Verify trigger with option is disabled' do |_tmp|
  assert_true new_pipeline_dashboard_page.trigger_pipeline_with_options_disabled?
end

step 'Verify trigger with option is enabled' do |_tmp|
  assert_false new_pipeline_dashboard_page.trigger_pipeline_with_options_disabled?
end

step 'Open pipelines selector - On Swift Dashboard page' do |_tmp|
  new_pipeline_dashboard_page.load(autoRefresh: @auto_refresh)
  new_pipeline_dashboard_page.open_pipeline_selector_dropdown
end

step 'Open pipeline build analytics' do |_tmp|
  new_pipeline_dashboard_page.open_build_analytics
end

step 'Verify pipeline build time graph is displayed' do |_tmp|
  assert_true new_pipeline_dashboard_page.build_time_graph_displayed?
end

step 'Verify the MTTR value is calculated' do |_tmp|
  assert_true new_pipeline_dashboard_page.mttr_displayed?
end

step 'Close pipeline build analytics' do |_tmp|
  new_pipeline_dashboard_page.close_analytics
end

step 'Visit pipeline VSM page and verify VSM is rendered' do
  new_pipeline_dashboard_page.click_vsm scenario_state.self_pipeline
  assert_true new_pipeline_dashboard_page.current_vsm_rendered_for scenario_state.self_pipeline
end

step 'Click pipeline compare link' do |_tmp|
  new_pipeline_dashboard_page.click_compare scenario_state.self_pipeline
end

step 'Click on material revision <revision> and verify material VSM is rendered' do |revision|
  assert_true new_pipeline_dashboard_page.material_vsm_rendered_for revision
end

step 'Switch to Environment Variables tab - On Swift Dashboard page' do
  new_pipeline_dashboard_page.switch_to_environment_variables_tab
end

step 'Switch to Secure Environment Variables tab - On Swift Dashboard page' do
  new_pipeline_dashboard_page.switch_to_secure_environment_variables_tab
end

step 'Change variable <key> to <value>' do |key, value|
  new_pipeline_dashboard_page.change_variable_to(key, value)
end

step 'Override secure variable named <secure_env_variable_key> with value <secure_env_variable_value>' do |secure_env_variable_key, secure_env_variable_value|
  new_pipeline_dashboard_page.override_secure_env_variable(secure_env_variable_key, secure_env_variable_value)
end

step 'Verify modification <position> has revision <revision> - On Build Cause popup' do |position, revision|
  material_name = new_pipeline_dashboard_page.sanitize_message(scenario_state.get('current_material_name'))
  revision_element = new_pipeline_dashboard_page.revision_of_material(scenario_state.get('current_material_type'), material_name)
  revision =  new_pipeline_dashboard_page.sanitize_message(revision)
  revision =  scenario_state.get(revision) || revision
  assert_true new_pipeline_dashboard_page.shows_revision_at?(revision_element, revision, position.to_i)
end

step 'Verify material has changed - On Build Cause popup' do
  material_name = new_pipeline_dashboard_page.sanitize_message(scenario_state.get('current_material_name'))
  revision_element = new_pipeline_dashboard_page.revision_of_material(scenario_state.get('current_material_type'), material_name)
 assert_true new_pipeline_dashboard_page.material_revision_changed? revision_element
end

step 'Verify pipeline does not get triggered' do
  new_pipeline_dashboard_page.wait_to_check_pipeline_do_not_start
end

step 'Verify pipeline does not get triggered for <seconds> seconds' do |seconds|
  new_pipeline_dashboard_page.wait_to_check_pipeline_do_not_start(seconds.to_i)
end

step 'Verify material has not changed - On Build Cause popup' do
  material_name = new_pipeline_dashboard_page.sanitize_message(scenario_state.get('current_material_name'))
  revision_element = new_pipeline_dashboard_page.revision_of_material(scenario_state.get('current_material_type'), material_name)
  assert_false new_pipeline_dashboard_page.material_revision_changed? revision_element
end

step 'PipelineVisibility <table>' do |table|
  table.rows.each do |row|
    scenario_state.put('current_pipeline', row['Pipeline Name'])
    p "Executing validation for pipeline #{row['Pipeline Name']}"
    (1..table.columns.length - 1).each do |i| # this is assuming the first column is reserved for pipeline name
      method_name = table.columns[i].tr(' ', '_').downcase
      raise "The method #{method_name} does not exist" unless new_pipeline_dashboard_page.respond_to?(method_name)
      p "Validating method - #{method_name}"
      assert_equal row[table.columns[i]], new_pipeline_dashboard_page.send(method_name).to_s
    end
  end
end

step 'Verify admin link is disabled' do ||
  assert_false new_pipeline_dashboard_page.admin_link_visible?
end

step 'Edit pipeline <pipeline>' do |pipeline|
  new_pipeline_dashboard_page.edit_pipeline pipeline
end

step 'Update auto scheduling to false' do ||
  new_pipeline_dashboard_page.unset_auto_sceduling
end

step 'Wait till pipeline start building - On Swift Dashboard page' do ||
  new_pipeline_dashboard_page.wait_till_pipeline_start_building
end

step 'Wait till pipeline start building for <seconds> seconds - On Swift Dashboard page' do |seconds|
  new_pipeline_dashboard_page.wait_till_pipeline_start_building seconds.to_i
end
step 'Wait till <seconds> seconds for stage <stage> shows status <status> - On Swift Dashboard page' do |seconds,stage,status|
  new_pipeline_dashboard_page.wait_for_expected_stage_state scenario_state.self_pipeline, stage, status.downcase, seconds.to_i
end

step 'Set auto scheduling' do ||
  new_pipeline_dashboard_page.set_auto_sceduling
end

step 'Verify auto scheduling is selected' do ||
  assert_true new_pipeline_dashboard_page.auto_sceduling_selected?
end

step 'Verify auto scheduling is not selected' do ||
  assert_false new_pipeline_dashboard_page.auto_sceduling_selected?
end

step 'Verify auto scheduling checkbox is disabled' do ||

  assert_true new_pipeline_dashboard_page.auto_sceduling_enabled?
end
step 'Commit file <file> to directory <dir>' do |file,dir|
  Context::GitMaterials.new(scenario_state.get("current_material_url")).create_new_directory_and_add_file(file,dir )
end
