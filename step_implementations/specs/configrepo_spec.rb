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

step 'Create a new config repo pipeline with name <pipeline> on repo <repo> as downstream of <upstream>' do |pipeline, repo, upstream|
  Context::ConfigRepoMaterial.new.setup(pipeline, repo.to_i, upstream)
end

step 'Create a new config repo environment with name <environment> on repo <repo>' do |environment, repo|
  Context::ConfigRepoEnvironment.new.setup(environment, repo.to_i)
end

step 'Create a partial config repo environment with name <environment> on repo <repo>' do |environment, repo|
  Context::ConfigRepoEnvironment.new.setup_existing(environment, repo.to_i)
end

step 'On Config repo page' do
  config_repos_page.load
end

step 'Verify config repo with name <repo> has pipeline with name <pipeline>' do |repo, pipeline|
  config_repos_page.verify_config_repo repo, pipeline
end

step 'Wait for config repo changes to sync' do
  sleep 30
end

step 'Add pipelines <pipelines> to config repo environment <environment>' do |pipelines, environment|
  pipelines.split(',').each { |p| scenario_state.get("#{environment}-configrepo").add_pipeline(scenario_state.get(p.strip)) }
end

step 'Update config repo pipeline with name <pipeline> as downstream of <upstream>' do |pipeline, upstream|
  scenario_state.get("#{pipeline}-configrepo").update_pipeline(upstream)
end
