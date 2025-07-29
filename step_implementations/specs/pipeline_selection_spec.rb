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

step 'Verify current view is <view_name>' do |view_name|
  assert_equal view_name.downcase, dashboard_personalization.current_view_name.downcase
end

step 'Start creating new view' do
  dashboard_personalization.dashboard_tabs.find(".add-tab").click
end

step 'Edit current tab' do
  dashboard_personalization.edit_view
end

step 'Delete view <view>' do |view|
  dashboard_personalization.switch_to_tab(view)
  dashboard_personalization.edit_view
  dashboard_personalization.delete_tab
end

step 'Change view to <view>' do |view|
  dashboard_personalization.switch_to_tab(view)
end

step 'Verify view <view> is not available' do |view|
  assert_raise Capybara::ElementNotFound do
    dashboard_personalization.switch_to_tab(view)
  end
end

step 'Set view name as <view_name>' do |view_name|
  dashboard_personalization.set_view_name(view_name)
end

step 'Verify groups <groups> are visible' do |groups|
  modal = dashboard_personalization.personalization_editor
  groups.split(',').each do |group|
    assert_true modal.find(".selected-pipelines li span", text: group.strip).visible?
  end
end

step 'Verify groups <groups> are not visible' do |groups|
  modal = dashboard_personalization.personalization_editor
  groups.split(',').each do |group|
    modal.assert_no_selector(".selected-pipelines li span", text: group.strip)
  end
end

step 'Verify show newly created pipelines option status is checked' do |_tmp|
  assert_true dashboard_personalization.show_new_pipelines?
end

step 'Uncheck show newly created pipelines' do
  dashboard_personalization.uncheck_show_new_pipelines
end

step 'Check show newly created pipelines' do
  dashboard_personalization.check_show_new_pipelines
end

step 'Deselect all pipelines' do |_tmp|
  dashboard_personalization.deselect_all_pipelines
end

step 'Select all pipelines' do |_tmp|
  dashboard_personalization.select_all_pipelines
end

step 'Verify all pipelines are selected' do |_tmp|
  assert_false dashboard_personalization.all_pipelines_selected?
end

step 'Verify no pipelines are selected' do |_tmp|
  assert_false dashboard_personalization.no_pipelines_selected?
end

step 'Select group <pipeline_group_name>' do |pipeline_group_name|
  dashboard_personalization.select_pipeline_group(pipeline_group_name)
end

step 'Deselect group <pipeline_group_name>' do |pipeline_group_name|
  dashboard_personalization.deselect_pipeline_group(pipeline_group_name)
end

step 'Expand group <pipeline_group>' do |pipeline_group_name|
  dashboard_personalization.expand_pipeline_group(pipeline_group_name)
end

step 'Verify all pipelines in group <pipeline_group> are selected' do |pipeline_group_name|
  assert_true dashboard_personalization.are_all_pipelines_selected_for?(pipeline_group_name)
end

step 'Verify all pipelines in group <pipeline_group> are deselected' do |pipeline_group_name|
  assert_true dashboard_personalization.are_all_pipelines_deselected_for?(pipeline_group_name)
end

step 'Select pipeline <pipeline_name>' do |pipeline_name|
  dashboard_personalization.select_pipeline(pipeline_name)
end

step 'Deselect pipeline <pipeline_name>' do |pipeline_name|
  dashboard_personalization.deselect_pipeline(pipeline_name)
end

step 'Verify <pipeline_group> is selected' do |pipeline_group_name|
  assert_true dashboard_personalization.pipeline_group_selected?(pipeline_group_name)
end

step 'Verify <pipeline_group> is deselected' do |pipeline_group_name|
  assert_false dashboard_personalization.pipeline_group_selected?(pipeline_group_name)
end

step 'Verify <pipeline_group> is indeterminate' do |pipeline_group_name|
  assert_true dashboard_personalization.is_pipeline_group_indeterminate?(pipeline_group_name)
end

step 'Verify <pipeline_group> is not indeterminate' do |pipeline_group_name|
  assert_false dashboard_personalization.is_pipeline_group_indeterminate?(pipeline_group_name)
end

step 'Apply selections' do |_tmp|
  dashboard_personalization.apply_selection
end

step 'Select filter state <state>' do |state|
  dashboard_personalization.filter_by_state(state.capitalize)
end

step 'Trigger pipeline <name> - On Swift Dashboard page' do |pipeline|
  scenario_state.put 'current_pipeline', pipeline
  new_pipeline_dashboard_page.trigger_pipeline(name: pipeline)
end
