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

step 'Verify show newly created pipelines option status is checked' do |_tmp|
  assert_true new_pipeline_dashboard_page.is_checked?('#show-newly-created-pipelines')
end

step 'Set show newly created pipelines option status as <status>' do |status|
  new_pipeline_dashboard_page.set_newly_created_pipeline_status(status)
end

step 'Verify groups <pipeline_group_names> are visible - Already on pipelines selector section' do |pipeline_group_names|
  pipeline_group_names.split(',').each {|pipeline_group_name|
    assert_true new_pipeline_dashboard_page.group_name_visible_in_selection_dropdown(pipeline_group_name.strip)
  }
end

step 'Verify groups <pipeline_group_names> are not visible - Already on pipelines selector section' do |pipeline_group_names|
  pipeline_group_names.split(',').each {|pipeline_group_name|
    assert_raise Capybara::ElementNotFound do
      new_pipeline_dashboard_page.group_name_visible_in_selection_dropdown(pipeline_group_name.strip)
      binding.pry
    end
  }
end

step 'Deselect all pipelines' do |_tmp|
  new_pipeline_dashboard_page.deselect_all_pipelines
end

step 'Select all pipelines' do |_tmp|
  new_pipeline_dashboard_page.select_all_pipelines
end

step 'Verify all pipelines are selected' do |_tmp|
  assert_true new_pipeline_dashboard_page.all_pipelines_selected?
end

step 'Verify no pipelines are selected' do |_tmp|
  assert_true new_pipeline_dashboard_page.no_pipelines_selected?
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
  assert_true new_pipeline_dashboard_page.is_checked?("#pgroup_#{pipeline_group_name}")
end

step 'Verify <pipeline_group> is deselected' do |pipeline_group_name|
  assert_false new_pipeline_dashboard_page.is_checked?("#pgroup_#{pipeline_group_name}")
end

step 'Apply selections' do |_tmp|
  new_pipeline_dashboard_page.apply_selection
end