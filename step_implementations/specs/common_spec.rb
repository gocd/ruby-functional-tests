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


step 'Wait for <duration> seconds' do |duration|
  sleep duration.to_i
end

step 'Analytics menu should not be visible' do |_tmp|
	assert_false app_base_page.menu_item_visible "Analytics"
end

step 'Analytics menu should be visible' do |_tmp|
	assert_true app_base_page.menu_item_visible "Analytics"
end

step 'Sleep for <secs> seconds' do |secs|
	sleep secs.to_i
end

step 'Restart server' do ||
  go_server.stop
  go_server.start
  go_server.wait_to_start
  app_base_page.reload_page
end

step 'Set Fan In turned off' do ||
 ENV['FANINOFF']="true"
end

step  'Set Fan In turned off - teardown' do ||
  ENV['FANINOFF']="false"
  go_server.stop
  go_server.start
  go_server.wait_to_start
  app_base_page.reload_page
end

step 'Update toggle <toggle> to value <value>' do |toggle, value|
  basic_configuration.update_toggle toggle, value
end
