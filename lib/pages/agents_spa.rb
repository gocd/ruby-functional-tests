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
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/agents"

    element :agents_head, "div[data-test-id='tab-content-0'] table[data-test-id='table'] > thead > tr"
    element :agents_table, '.agents-table.stack'
    elements :agents_row, "div[data-test-id='tab-content-0'] table[data-test-id='table'] > tbody > tr"
    elements :agents_column, "div[data-test-id='tab-content-0'] table[data-test-id='table'] > tbody > tr > td"
    elements :agents_menu, "div[data-test-id='tab-content-0'] > div > div > div > div"
    element :agent_menu, '#agents div header div div.columns.medium-7.large-7 ul'
    element :filter_agent, "[data-test-id='form-field-input-search-for-agents']"
    elements :agents_summary, '#agents > div > div.header-panel > div.agents-search-panel > div.show-for-large > ul > li'

    load_validation {has_filter_agent?}

    def select_all_agents
      wait_until_agents_menu_visible(wait: 5)
      agents_head.find('input[type="checkbox"]').set(true)
    end

    def select_agent_at(row)
      wait_until_agents_menu_visible(wait: 5)
      agents_row[row].find('input[type="checkbox"]').set(true)
    end

    def select_agent_with_status(status)
      agents_table.all(".#{status}").first.find('input[type="checkbox"]').set(true)
    end

    def listed_agents_count
      reload_page
      wait_until_agents_menu_visible(wait: 5)
      agents_row.size
    end

    def get_agents_count(state)
      (agents_column text: state).size
    end

    def add_resource(resource)
      agents_menu[0].find("div[data-test-id='association']").find('input[type="text"]').set resource
      agents_menu[0].find("div[data-test-id='association']").find('button', text: 'Add').click
    end

    def set_resource(resource, value)
      agents_menu[0].find("div[data-test-id='association'] input[type='checkbox'][data-test-id='form-field-input-#{slugify(resource)}']").set(value)
    end

    def verify_column(row_number, column_name, collection, error_message)
      assert_equal collection.split(',').map(&:strip).sort, agents_spa_page.get_listed_agents(column_name)[row_number.to_i - 1].split(',').map(&:strip), error_message
    end

    def set_environment(environment, value)
      agents_menu[0].find("div[data-test-id='association'] input[type='checkbox'][data-test-id='form-field-input-#{environment}']").set(value)
    end

    def apply_changes
      agents_menu[0].find("div[data-test-id='association']").find('button', text: 'Apply').click
      reload_page
    end

    def click_on(action)
      agents_menu[0].find('button', text: action).click
      wait_until_agents_menu_visible(wait: 5)
    end

    def summary_count(label)
      agents_summary.select { |summary| summary.find('label').text == label }.first.find('span').text
    end

    def get_listed_agents(column_name)
      headers = {}
      agents_head.all('th').each_with_index { |head, index| headers.merge!(head.text.to_s => (index + 1).to_s) }
      agents_row.map { |row| row.find("td:nth-child(#{headers[column_name.upcase]})").text }
    end

    def get_message
      find('#agents > div > div.header-panel > div.row.expanded.message > div').text
    end

    def sort_by(column)
      agents_head.find('th', text: column.upcase).find('span').click
    end

    def filter_by(search_string)
      filter_agent.set(search_string)
      wait_until_agents_summary_visible(wait: 5)
    end

    def wait_till_agent_status_is(status, row)
      wait_till_event_occurs_or_bomb 120, "Expected agent at #{row} to move to status #{status} by now" do
        reload_page
        wait_until_agents_menu_visible(wait: 5)
        break if agents_spa_page.get_listed_agents('Status')[row.to_i - 1] == status
      end
    end

    def wait_till_agents_are_pending(count)
      wait_till_event_occurs_or_bomb 120, "Expected #{count} agents be regsitered by now" do
        reload_page
        wait_until_agents_menu_visible(wait: 5)
        break if get_agents_count('Pending') == count.to_i
      end
    end

    def wait_till_agents_are_idle(count)
      wait_till_event_occurs_or_bomb 120, "Expected #{count} agents be regsitered by now" do
        reload_page
        wait_until_agents_menu_visible(wait: 5)
        break if get_agents_count('Idle') == count.to_i
      end
    end

    def slugify(value)
      value.downcase.strip.gsub(/[ _]+/, '-').gsub(/[^\w-]/, '')
    end
  end
end
