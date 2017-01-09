##########################################################################
# Copyright 2017 ThoughtWorks, Inc.
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


step "Create a new config repo pipeline with name <pipeline> on repo <repo> as downstream of <upstream>" do |pipeline, repo, upstream|
  Context::ConfigRepoMaterial.new.setup(pipeline, repo.to_i, upstream)
end

step "Update config repo pipeline with name <pipeline> as downstream of <upstream>" do |pipeline, upstream|
  scenario_state.configrepo(pipeline).update_pipeline(upstream)
end
