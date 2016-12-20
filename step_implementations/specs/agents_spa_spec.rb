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

step "On Agents page" do |count|
  agents_spa_page.load
  p 'Agents page loaded' if agents_spa_page.loaded?
end

step "Select All agents" do |agents|
  agents_spa_page.select_all_agents
end

step "Select agent <rows>" do |rows|
  rows.split(',').map(&:strip).each { |row| agents_spa_page.select_agent_at row.to_i-1}
end

step "Add resources <resources>" do |resources|
  agents_spa_page.click_on('RESOURCES')
  resources.split(',').map(&:strip).each { |resource| agents_spa_page.add_resource resource }
  agents_spa_page.apply_changes
end

step "Remove resources <resources>" do |resources|
  agents_spa_page.click_on('RESOURCES')
  resources.split(',').map(&:strip).each { |resource| agents_spa_page.set_resource resource, false}
  agents_spa_page.apply_changes
end

step "Set resources <resources>" do |resources|
  agents_spa_page.click_on('RESOURCES')
  resources.split(',').map(&:strip).each { |resource| agents_spa_page.set_resource resource, true}
  agents_spa_page.apply_changes
end

step "Verify agent <row> assigned resources <resources>" do |row, resources|
  assert_equal resources.split(',').map(&:strip).sort, agents_spa_page.get_listed_agents('Resources')[row.to_i-1].split(',').map(&:strip), "Mismatch in agent assigned resources"
end

step "Remove environments <envs>" do |envs|
  agents_spa_page.click_on('ENVIRONMENTS')
  envs.split(',').map(&:strip).each { |env| agents_spa_page.set_environment env, false}
  agents_spa_page.apply_changes
end

step "Set environments <envs>" do |envs|
  agents_spa_page.click_on('ENVIRONMENTS')
  sleep 2 # added it to avoid the flakiness in selcting the environment name from the environments box. Need to find better way to handle the flakiness
  envs.split(',').map(&:strip).each { |env| agents_spa_page.set_environment env, true}
  agents_spa_page.apply_changes
end

step "Verify agent <row> assigned environments <envs>" do |row, envs|
  assert_equal envs.split(',').map(&:strip).sort, agents_spa_page.get_listed_agents('Environments')[row.to_i-1].split(',').map(&:strip), "Mismatch in agent assigned environments"
end

step "Verify message <message>" do |message|
  assert_equal message, agents_spa_page.get_message, "Agent modified message mismatch"
end

step "Verify agents <hostnames> show up in results" do |hostnames|
  assert_equal (hostnames.split(',').map!(&:strip).sort), agents_spa_page.get_listed_agents('Agent Name').map!(&:strip).sort, "Listed agents not as expected"
end

step "Sort by <column>" do |column|
  agents_spa_page.sort_by column
end

step "Verify agents <column> has values in order as <values>" do |col, val|
  assert_equal val.split(',').map!(&:strip), agents_spa_page.get_listed_agents(col), "Sort order on #{col} mismatch"
end

step "<action> agent" do |action|
  agents_spa_page.click_on action.upcase
end

step "Verify agent <row> status is <status>" do |row, status|
  assert_equal status, agents_spa_page.get_listed_agents('Status')[row.to_i-1], "Agent at #{row} is not at expected state #{status}"
end

step "Verify listed agents count is <count>" do |count|
  assert_equal count.to_i, agents_spa_page.listed_agents_count, "Listed agents count expected to be #{count}"
end

step "Enter filter value <search>" do |search|
  agents_spa_page.filter_by(search)
end

step "Verify total agent count is <count>" do |count|
  assert_equal count, agents_spa_page.summary_count("Total"), "Total agent count not as expected"
end

step "Verify agents at state <state> is <count>" do |state, count|
  assert_equal count.to_i, agents_spa_page.get_agents_count(state), "Expected #{count} agents at state #{state}"
end


step "Wait till agent <row> status is <status>" do |row, status|
  agents_spa_page.wait_till_agent_status_is status, row
end

step "With <count> live agents - setup" do |count|
  go_agents.create_agents count
  agents_spa_page.load
  p 'Agents page loaded' if agents_spa_page.loaded?
  agents_spa_page.resize
  agents_spa_page.wait_till_agents_are_idle count
end

step "With <count> live agents - teardown" do |count|
  go_agents.destroy_agents count
end
