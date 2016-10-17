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

module Pages
  class AgentsSPA < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/agents"

    element :agents_head, '#agents > div > div.row.expanded > div > table > thead > tr'
    elements :agents_row, '#agents > div > div.row.expanded > div > table > tbody > tr'
    elements :agents_column, '#agents > div > div.row.expanded > div > table > tbody > tr > td'
    elements :agents_menu, '#agents div header div div.columns.medium-7.large-7 ul'
    element :agent_menu, '#agents div header div div.columns.medium-7.large-7 ul'
    element :filter_agent, '#filter-agent'
    elements :agents_summary, '#agents > div > div.search-panel > div > div.columns.medium-6.large-8 > ul > li'

    load_validation { has_agents_check_box? }

    def select_all_agents
      agents_head.find('input[type="checkbox"]').set(true)
    end

    def select_agent_at(row)
      agents_row.each_with_index { |val, index| val.find('input[type="checkbox"]').set(true) if index == row }
    end

    def listed_agents_count
      reload_page
      wait_for_agents_menu(5)
      agents_row.size
    end

    def get_agents_count(state)
      (agents_column text: state).size
    end

    def add_resource(resource)
      agents_menu[0].find('li.has-dropdown.is-open').find('input[type="text"]').set resource
      agents_menu[0].find('li.has-dropdown.is-open').find('button', text: 'Add').click
    end

    def set_resource(resource, value)
      agents_menu[0].all('li.has-dropdown.is-open > div > ul > li').each { |res| res.find('input[type="checkbox"]').set(value) if res.text == resource }
    end

    def set_environment(environment, value)
      agents_menu[0].all('li.has-dropdown.is-open > div > ul > li').each { |env| env.find('input[type="checkbox"]').set(value) if env.text == environment }
    end

    def apply_changes()
      agents_menu[0].find('li.has-dropdown.is-open').find('button', text: 'Apply').click
      wait_for_agents_row(10)
    end

    def click_on(action)
      agents_menu[0].find('button', text: action).click
      wait_for_agents_menu(5)
    end

    def summary_count(label)
      agents_summary.select { |summary| summary.find('label').text == label }.first.find('span').text
    end

    def get_listed_agents(column_name)
      headers = {}
      agents_head.all('th').each_with_index { |head, index| headers.merge!(head.text.to_s => (index + 1).to_s) }
      agents_row.map { |row| row.find("td:nth-child(#{headers[column_name]})").text }
    end

    def get_message
      find('#agents > div > div:nth-child(3) > div').text
    end

    def sort_by(column)
      agents_head.find('label', text: column).click
    end

    def filter_by(search_string)
      filter_agent.set(search_string)
      wait_for_agents_summary(5)
    end

    def wait_till_agent_status_is(status, row)
      wait_till_event_occurs_or_bomb 60, "Expected agent at #{row} to move to status #{status} by now" do
        reload_page
        wait_for_agents_menu(5)
        break if agents_spa_page.get_listed_agents('Status')[row.to_i-1] == status
      end
    end

    def wait_till_agents_are_idle(count)
      wait_till_event_occurs_or_bomb 60, "Expected #{count} agents be regsitered by now" do
        reload_page
        wait_for_agents_menu(5)
        break if get_agents_count('Idle') == count.to_i
      end
    end
  end
end
