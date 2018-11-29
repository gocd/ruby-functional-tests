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

step 'Verify environment <environment> shows up on the environments page' do |environment|
  environments_dashboard_page.load
  environments_dashboard_page.wait_till_environment_showsup environment
end

step 'Looking at environment <environment>' do |environment|
  scenario_state.store environment, environment
end

step 'Open Environment edit page for environment <environment>' do |environment|
  environments_dashboard_page.load
  environments_dashboard_page.show_environment(environment)
  scenario_state.store('current_env', environment)
end

step 'Verify pipelines <pipelines> are available on <environment> edit page' do |pipelines, environment|
  pipelines.split(',').each do |pipeline|
    assert_true environments_edit_page(scenario_state.retrieve(environment)).is_pipeline_exists? scenario_state.retrieve(pipeline.strip)
  end
end

step 'Verify pipelines <pipelines> are not available on <environment> edit page' do |pipelines, environment|
  pipelines.split(',').each do |pipelines|
    assert_false environments_edit_page(scenario_state.retrieve(environment)).is_pipeline_exists? scenario_state.retrieve(pipelines.strip)
  end
end

step 'Edit pipelines' do
  environments_edit_page(scenario_state.retrieve(scenario_state.retrieve('current_env'))).edit_pipeline
end

step 'Verify agents <agents> are available on <environment> edit page' do |agents, environment|
  sleep 2
  agents.split(',').each do |agent|
    assert_true environments_edit_page(scenario_state.retrieve(environment)).is_agent_exists? agent
  end
end

step 'Verify environment variables <vars> are available on <environment> edit page' do |vars, environment|
  vars.split(',').each do |var|
    assert_true environments_edit_page(scenario_state.retrieve(environment)).is_env_vars_exists? var
  end
end

step 'Edit Agents' do
  environments_edit_page(scenario_state.retrieve(scenario_state.retrieve('current_env'))).edit_agents
end

step 'Save environment' do
  environments_edit_page(scenario_state.retrieve(scenario_state.retrieve('current_env'))).save
end

step 'Edit environment variables' do
  environments_edit_page(scenario_state.retrieve(scenario_state.retrieve('current_env'))).edit_environment_variables
end

step 'Select all agents and verify all are selected' do
  env = environments_edit_page(scenario_state.retrieve(scenario_state.retrieve('current_env')))
  env.select_all_agents
  assert_true env.all_agents_checked
end

step 'Add agent <agent> and save environment' do |agent|
  environments_edit_page(scenario_state.retrieve(scenario_state.retrieve('current_env'))).add_agent(agent)
  environments_edit_page(scenario_state.retrieve(scenario_state.retrieve('current_env'))).save
end

step 'Add pipeline <pipeline> and save environment' do |pipeline|
  environments_edit_page(scenario_state.retrieve(scenario_state.retrieve('current_env'))).add_pipeline(scenario_state.retrieve(pipeline))
  environments_edit_page(scenario_state.retrieve(scenario_state.retrieve('current_env'))).save
end

step 'Verify removing pipelines <pipelines> is not allowed' do |pipelines|
  pipelines.split(',').each do |p|
    assert_false environments_edit_page(scenario_state.retrieve(scenario_state.retrieve('current_env'))).can_edit_pipeline? scenario_state.retrieve(p.strip)
  end
end

step 'Remove pipelines <pipelines> and save environment' do |pipelines|
  pipelines.split(',').each { |p| environments_edit_page(scenario_state.retrieve(scenario_state.retrieve('current_env'))).remove_pipeline scenario_state.retrieve(p.strip) }
  environments_edit_page(scenario_state.retrieve(scenario_state.retrieve('current_env'))).save
end

step 'Verify message <message> is present' do |message|
  assert_true environments_edit_page(scenario_state.retrieve(scenario_state.retrieve('current_env'))).get_message.include? message
end

step 'For variable at row <row> set name <var> value <value>' do |row, var, value|
  environments_edit_page(scenario_state.retrieve(scenario_state.retrieve('current_env'))).set_vars_at(row, var, value)
end

step 'Add new variable' do
  environments_edit_page(scenario_state.retrieve(scenario_state.retrieve('current_env'))).add_new_var
  environments_edit_page(scenario_state.retrieve(scenario_state.retrieve('current_env'))).save
end

step 'Expand environment <environment>' do |environment|
	environments_dashboard_page.show_environment(environment)
end