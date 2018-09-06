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

step 'Verify current view is <view_name>' do |view_name|
  assert_equal view_name.downcase, new_pipeline_dashboard_page.current_view_name.downcase
end

step 'Start creating new view' do
  new_pipeline_dashboard_page.dashboard_tabs.find(".add-tab").click
end

step 'Edit current tab' do
  new_pipeline_dashboard_page.edit_view
end

step 'Delete view <view>' do |view|
  new_pipeline_dashboard_page.switch_to_tab(view)
  new_pipeline_dashboard_page.edit_view
  new_pipeline_dashboard_page.delete_tab
end

step 'Change view to <view>' do |view|
  new_pipeline_dashboard_page.switch_to_tab(view)
end

step 'Verify view <view> is not available' do |view|
  assert_raise Capybara::ElementNotFound do
    new_pipeline_dashboard_page.switch_to_tab(view)
  end
end

step 'Set view name as <view_name>' do |view_name|
  new_pipeline_dashboard_page.set_view_name(view_name)
end

step 'Verify groups <groups> are visible' do |groups|
  modal = new_pipeline_dashboard_page.personalization_editor
  groups.split(',').each do |group|
    assert_true modal.find(".selected-pipelines li span", text: group.strip).visible?
  end
end

step 'Verify groups <groups> are not visible' do |groups|
  modal = new_pipeline_dashboard_page.personalization_editor
  groups.split(',').each do |group|
    modal.assert_no_selector(".selected-pipelines li span", text: group.strip)
  end
end

step 'Verify show newly created pipelines option status is checked' do |_tmp|
  assert_true new_pipeline_dashboard_page.show_new_pipelines?
end

step 'Uncheck show newly created pipelines' do
  new_pipeline_dashboard_page.uncheck_show_new_pipelines
end

step 'Check show newly created pipelines' do
  new_pipeline_dashboard_page.check_show_new_pipelines
end

step 'Deselect all pipelines' do |_tmp|
  new_pipeline_dashboard_page.deselect_all_pipelines
end

step 'Select all pipelines' do |_tmp|
  new_pipeline_dashboard_page.select_all_pipelines
end

step 'Verify all pipelines are selected' do |_tmp|
  assert_false new_pipeline_dashboard_page.all_pipelines_selected?
end

step 'Verify no pipelines are selected' do |_tmp|
  assert_false new_pipeline_dashboard_page.no_pipelines_selected?
end

step 'Select group <pipeline_group_name>' do |pipeline_group_name|
  new_pipeline_dashboard_page.select_pipeline_group(pipeline_group_name)
end

step 'Deselect group <pipeline_group_name>' do |pipeline_group_name|
  new_pipeline_dashboard_page.deselect_pipeline_group(pipeline_group_name)
end

step 'Expand group <pipeline_group>' do |pipeline_group_name|
  new_pipeline_dashboard_page.expand_pipeline_group(pipeline_group_name)
end

step 'Verify all pipelines in group <pipeline_group> are selected' do |pipeline_group_name|
  assert_true new_pipeline_dashboard_page.are_all_pipelines_selected_for?(pipeline_group_name)
end

step 'Verify all pipelines in group <pipeline_group> are deselected' do |pipeline_group_name|
  assert_true new_pipeline_dashboard_page.are_all_pipelines_deselected_for?(pipeline_group_name)
end

step 'Select pipeline <pipeline_name>' do |pipeline_name|
  new_pipeline_dashboard_page.select_pipeline(pipeline_name)
end

step 'Deselect pipeline <pipeline_name>' do |pipeline_name|
  new_pipeline_dashboard_page.deselect_pipeline(pipeline_name)
end

step 'Verify <pipeline_group> is selected' do |pipeline_group_name|
  assert_true new_pipeline_dashboard_page.pipeline_group_selected?(pipeline_group_name)
end

step 'Verify <pipeline_group> is deselected' do |pipeline_group_name|
  assert_false new_pipeline_dashboard_page.pipeline_group_selected?(pipeline_group_name)
end

step 'Verify <pipeline_group> is indeterminate' do |pipeline_group_name|
  assert_true new_pipeline_dashboard_page.is_pipeline_group_indeterminate?(pipeline_group_name)
end

step 'Verify <pipeline_group> is not indeterminate' do |pipeline_group_name|
  assert_false new_pipeline_dashboard_page.is_pipeline_group_indeterminate?(pipeline_group_name)
end

step 'Apply selections' do |_tmp|
  new_pipeline_dashboard_page.apply_selection
end

step 'Select filter state <state>' do |state|
  new_pipeline_dashboard_page.filter_by_state(state.capitalize)
end

step 'Trigger pipeline <name> - On Swift Dashboard page' do |name|
  new_pipeline_dashboard_page.trigger_pipeline(name)
end
