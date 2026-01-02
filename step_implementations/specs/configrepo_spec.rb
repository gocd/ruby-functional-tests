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
  sleep 12
end

step 'Add pipelines <pipelines> to config repo environment <environment>' do |pipelines, environment|
  pipelines.split(',').each {|p| scenario_state.get("#{environment}-configrepo").add_pipeline(scenario_state.get(p.strip))}
end

step 'Update config repo pipeline with name <pipeline> as downstream of <upstream>' do |pipeline, upstream|
  scenario_state.get("#{pipeline}-configrepo").update_pipeline(upstream)
end

step 'Verify that the page contains all of <repos>' do |repos|
  config_repos_page.has_config_repos(repos)
end

step 'Verify that the config repos <repos> have enabled action buttons' do |repos|
  repos.split(',').each {|repo| config_repos_page.has_enabled_action_buttons(repo.strip)}
end

step 'Verify that the config repos <repo> have disabled action buttons' do |repos|
  repos.split(',').each {|repo| config_repos_page.has_disabled_action_buttons(repo.strip)}
end

step 'Click on edit config repo <repo>' do |repo|
  config_repos_page.click_edit_config_repo repo
end

step 'Click on save config repo' do
  config_repos_page.click_save_config_repo
end

step 'Click on delete config repo <repo>' do |repo|
  config_repos_page.click_delete_config_repo repo
end

step 'Click on confirm delete config repo' do
  config_repos_page.click_confirm_delete
end

step 'Verify that the page does not contain single repo <repo>' do |repo|
  config_repos_page.does_not_contain_repo(repo)
end

step 'Click on create config repo' do
  config_repos_page.click_on_add_config_repo
end

step 'Enter config repo name <name>' do |name|
  config_repos_page.enter_config_repo_name(name)
end

step 'Enter config repo url <url>' do |url|
  config_repos_page.enter_config_repo_url(url)
end

step 'Verify that the <repo> is successfully parsed with environment <env>' do |repo, env|
  config_repos_page.repo_successfully_parsed(repo)
  config_repos_page.repo_has_env(repo, env)
end

step 'Verify that the <repo> has failed to parse with rule validation error on <entity> <name>' do |repo, entity, name|
  config_repos_page.repo_failed_parsing(repo, entity, actual_name(name))
end


def actual_name(env)
  scenario_state.get(env) || env
end
