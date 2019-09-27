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

step 'On Pipeline settings page of pipeline <pipeline_name>' do |pipeline_name|
  pipeline_settings_page.load(pipeline_name: scenario_state.get(pipeline_name))
end

step 'Open <tab_id> tab - On Pipeline settings page' do |tab_id|
  pipeline_settings_page.on_tab(tab_id)
end

step 'Verify pipeline created successfully' do
  assert_true pipeline_settings_page.partial_message_displayed?('Pipeline successfully created.')
end

step 'Add parameter name <name> and value <value>' do |name, value|
  pipeline_settings_page.add_parameter(name, value)
end

step 'Save Pipeline settings' do
  pipeline_settings_page.save
end

step 'Edit material <material_name>' do |material_name|
  pipeline_settings_page.select_material material_name
end

step 'Enter destination directory <dest>' do |dest|
  pipeline_settings_page.material_dest_directory.set dest
end

step 'Copy over material url from material url as <material-url>' do |material_url|
  pipeline_settings_page.set_material_url scenario_state.get(material_url)
end

step 'Check connectivity should be successful - Already on Git Material Creation Popup' do
  pipeline_settings_page.check_connection.click
  assert_true pipeline_settings_page.connection_ok?
end

step 'Check connectivity should be failed - Already on Git Material Creation Popup' do
  pipeline_settings_page.check_connection.click
  assert_false pipeline_settings_page.connection_ok?
end
step 'Select add new material of type <type>' do |type|
  pipeline_settings_page.select_add_new_material type
end

step 'Delete material with name <material_name>' do |material_name|
  pipeline_settings_page.delete_material material_name
end

step 'Enter black list <balcklicst>' do |blacklist|
  pipeline_settings_page.set_material_blacklist(blacklist)
end

step 'Verify only on changes checkbox is disabled' do
  assert_true pipeline_settings_page.only_on_changes_checkbox_disabled?
end

step 'Verify only on changes checkbox is enabled' do
  assert_false pipeline_settings_page.only_on_changes_checkbox_disabled?
end

step 'Enter <timer> for cron time specifier' do |timer|
  pipeline_settings_page.cron_timer.set timer
end

step 'Enter <label> for label template' do |label|
  pipeline_settings_page.label_template.set label
end

step 'Select onlyOnChanges flag to trigger pipeline only on new material' do
  pipeline_settings_page.set_only_on_changes_checkbox
end

step 'Set material name as <pipeline_material>' do |material|
  pipeline_settings_page.material_name.set material
end

step 'Set pipeline Stage as <stage_name>' do |stage|
  pipeline_settings_page.stage_name.set new_pipeline_dashboard_page.sanitize_message(stage)
end

step 'Verify material <material> is exist with URL <url>' do |material, url|
  assert_true pipeline_settings_page.url_exist_for_material? material, new_pipeline_dashboard_page.sanitize_message(url)
end

step 'Enter Environment variable name <name> with value <value>' do |name, value|
  pipeline_settings_page.add_env(name, value)
end

step 'Verify that material <material> can be deleted' do |material|
  assert_true pipeline_settings_page.can_material_be_deleted? new_pipeline_dashboard_page.sanitize_message(material)
end

step 'Verify that material <material> can not be deleted' do |material|
  assert_false pipeline_settings_page.can_material_be_deleted? new_pipeline_dashboard_page.sanitize_message(material)
end

step 'Make autoupdate to be <flag> - Already on edit material popup' do |flag|
  flag = flag == 'true'
  pipeline_settings_page.make_material_auto_update flag
end

step 'Invert material' do
  pipeline_settings_page.invert_material
end

step 'Select Clean working directory' do
  pipeline_settings_page.clean_work_dir
end

step 'Verify cannot move <stage> to <direction>' do |stage, direction|
  assert_false pipeline_settings_page.can_move_stage? stage, direction
end

step 'Move stage <stage> to <direction>' do |stage, direction|
  pipeline_settings_page.move_stage stage, direction
end

step 'Enter project path as <path>' do |path|
  pipeline_settings_page.project_path.set(path)
end

step 'Verify the stages are <stages>' do |stages|
  pipeline_stages = pipeline_settings_page.get_pipeline_stages
  stages.split(',').each do |stage|
    assert_true pipeline_stages.include? stage
  end
end

step 'Open stage <stage>' do |stage|
  pipeline_settings_page.select_stage stage
end

step 'Unpause pipeline - On pipeline edit page' do
  pipeline_settings_page.unpause_pipeline
end

step 'Set url <url> for material <material> - On material popup' do |url, material|
  pipeline_settings_page.set_material_url new_pipeline_dashboard_page.sanitize_message(url)
end

step 'Open tab <tab> - On Pipeline Creation Page' do |tab|
  pipeline_settings_page.open_tab(tab)
end

step 'Verify reset button exists' do
  assert_true pipeline_settings_page.verify_reset_button_exist?
end
