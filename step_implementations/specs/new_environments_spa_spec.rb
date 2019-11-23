##########################################################################
# Copyright 2019 ThoughtWorks, Inc.
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

step 'On new environments page' do
  new_environments_page.load
end

step 'Verify no environments present message' do
  new_environments_page.verify_no_envs_available_message
end

step 'Add new environment <env>' do |env|
  new_environments_page.add_new_environment(env)
end

step 'Verify if environment <env> is added' do |env|
  new_environments_page.has_environment(env)
end

step 'Open collapsible panel for <env>' do |env|
  new_environments_page.open_collapsible_for(env)
end

step 'Click on edit pipeline for <env>' do |env|
  new_environments_page.edit_pipeline_association_for(env)
end

# step 'Verify flash info message for no pipelines' do
#   new_environments_page.has_info_message("There are no pipelines available!")
# end

step 'Associate pipeline <pipeline> to environment' do |pipeline|
  new_environments_page.associate_pipeline(pipeline)
end

step 'Verify pipeline <pipeline> associated to environment <env>' do |pipeline, env|
  new_environments_page.has_pipeline(pipeline, env)
end

step 'Click on edit agent for <env>' do |env|
  new_environments_page.edit_agent_association_for(env)
end

step 'Associate agent <agent> to environment' do |agent|
  new_environments_page.associate_agent(agent)
end

step 'Verify agent <agent> associated to environment <env>' do |agent, env|
  new_environments_page.has_agent(agent, env)
end

