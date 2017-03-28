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


step "Verify environment <environment> shows up on the environments page" do |environment|
  environments_dashboard_page.load
  environments_dashboard_page.wait_till_environment_showsup environment
end

step "Open Environment edit page for environment <environment>" do |environment|
  environments_dashboard_page.load
  environments_dashboard_page.click_environment environment
  scenario_state.current_environment(environment)
end

step "Verify pipelines <pipelines> are available on <environment> edit page" do |pipelines, environment|
   pipelines.split(',').each { |p|
     assert_true environments_edit_page(scenario_state.get_environment(environment)).is_pipeline_exists? scenario_state.get_pipeline(p.strip)}
end

step "Verify pipelines <pipelines> are not available on <environment> edit page" do |pipelines, environment|
  pipelines.split(',').each { |p|
    assert_false environments_edit_page(scenario_state.get_environment(environment)).is_pipeline_exists? scenario_state.get_pipeline(p.strip)}
end

step "Edit pipelines" do
  environments_edit_page(scenario_state.get_current_environment).click_pipeline_edit
end

step "Add pipeline <pipeline> and save environment" do |pipeline|
  environments_edit_page(scenario_state.get_current_environment).add_pipeline(scenario_state.get_pipeline(pipeline))
  environments_edit_page(scenario_state.get_current_environment).save
end

step "Verify removing pipelines <pipelines> is not allowed" do |pipelines|
  pipelines.split(',').each { |p|
    assert_false environments_edit_page(scenario_state.get_current_environment).can_edit_pipeline? scenario_state.get_pipeline(p.strip)}
end

step "Remove pipelines <pipelines> and save environment" do |pipelines|
  pipelines.split(',').each { |p| environments_edit_page(scenario_state.get_current_environment).remove_pipeline scenario_state.get_pipeline(p.strip)}
  environments_edit_page(scenario_state.get_current_environment).save
end