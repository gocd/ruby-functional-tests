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

    element :agents_check_box, '#agents > div > div.row.expanded > div > table > thead > tr > th:nth-child(1) > input[type="checkbox"]'
    elements :agents_row, '#agents > div > div.row.expanded > div > table > tbody > tr'
    elements :agents_column, '#agents > div > div.row.expanded > div > table > tbody > tr > td'
    elements :agents_menu, '#agents div header div div.columns.medium-7.large-7 ul'

    load_validation { has_agents_check_box? }

    def select_all_agents
      agents_check_box.set(true)
    end

    def select_agent_at(row)
      agents_row.each_with_index{|val, index| val.find('input[type="checkbox"]').set(true) if index == row}
    end

    def get_idle_agents_count
      (agents_column :text => 'Idle').size
    end

    def add_resource(resource)
      agents_menu.each{|menu|
        menu.find('button', :text => 'Resources').click
        menu.find('li.has-dropdown.is-open').find('input[type="text"]').set resource
        menu.find('li.has-dropdown.is-open').find('button', :text => 'Add').click
        menu.find('li.has-dropdown.is-open').find('button', :text => 'Apply').click
      }
    end

    def set_resource(resource, value)
      agents_menu.each{|menu| menu.find('button', :text => 'Resources').click
        wait_for_agents_menu(5)
        menu.all('li.has-dropdown.is-open > div > ul > li').each{|res| res.find('input[type="checkbox"]').set(value) if res.text == resource }
        binding.pry
        menu.find('li.has-dropdown.is-open').find('button', :text => 'Apply').click
      }
    end

    def wait_till_agents_are_idle(count)
      wait_till_event_occurs_or_bomb 60, "Expected #{count} agents be regsitered by now" do
        reload_page
        break if get_idle_agents_count == count.to_i
      end
    end
  end
end
