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

step 'Reload page' do |_count|
  app_base_page.reload_page
end

step 'With <count> pending agents - setup' do |count|
  go_agents.create_agents count
  agents_spa_page.load
  agents_spa_page.resize
  agents_spa_page.wait_till_agents_are_pending count
end

step 'With <count> live agents - setup' do |count|
  go_agents.create_agents count
  agents_spa_page.load
  agents_spa_page.resize
  agents_spa_page.wait_till_agents_are_idle count
end

step 'With <count> live agents - teardown' do |count|
  go_agents.destroy_agents count
end

step 'Create a <file> file' do |file|
  go_agents.create_stopjob(file)
end

step 'Create a <file> file and validate pipeline completed' do |file|
  go_agents.create_stopjob(file)
  new_pipeline_dashboard_page.wait_till_pipeline_complete
  go_agents.delete_stopjobs
end
