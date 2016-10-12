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

step "Add resource <resources>" do |resources|
  agents_spa_page.click_on('Resources')
  resources.split(',').map(&:strip).each { |resource| agents_spa_page.add_resource resource }
  agents_spa_page.apply_changes
end

step "Remove resource <resources>" do |resources|
  agents_spa_page.click_on('Resources')
  resources.split(',').map(&:strip).each { |resource| agents_spa_page.set_resource resource, false}
  agents_spa_page.apply_changes
end

step "Set resource <resources>" do |resources|
  agents_spa_page.click_on('Resources')
  resources.split(',').map(&:strip).each { |resource| agents_spa_page.set_resource resource, true}
  agents_spa_page.apply_changes
end

step "Verify agent <row> assigned resources <resources>" do |row, resources|
  assert agents_spa_page.get_listed_agents('Resources')[row.to_i-1].split(',').map(&:strip).eql?resources.split(',').map(&:strip).sort
end

step "Verify agents <hostnames> are displayed" do |hostnames|
  assert agents_spa_page.get_listed_agents('Agent Name').sort.eql?(hostnames.split(',').map!(&:strip).sort)
end

step "Sort by <column>" do |column|
  agents_spa_page.get_listed_agents(column)
end

step "With <count> live agents - setup" do |count|
  go_agents.create_agents count
  agents_spa_page.load
  p 'Agents page loaded' if agents_spa_page.loaded?
  agents_spa_page.wait_till_agents_are_idle count
end

step "With <count> live agents - teardown" do |count|
  go_agents.destroy_agents count
end
