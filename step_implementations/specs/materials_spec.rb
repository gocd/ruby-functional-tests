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

step "Using pipeline <pipeline> - setup" do |pipelines|
  pipelines.split(',').each { |pipeline| git_materials.setup_material_for pipeline.strip }
  basic_configuration.remove_pipelines_except pipelines.split(',').map { |p| p.strip }
end

step "Using environment <environment> - setup" do |environments|
  environments.split(',').each { |env| scenario_state.add_environment(env, env) }
  basic_configuration.remove_environments_except environments.split(',').map { |e| e.strip }
end

step "Using environment <environment> - teardown" do |environments|
  basic_configuration.reset_config_environment
end

step "Using pipeline <pipeline> - teardown" do |pipelines|
  basic_configuration.reset_config_pipeline
end
