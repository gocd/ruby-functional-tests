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
  class Agents < Base
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/agents"

    element :environments, '#show_environments_panel'

    def unselect_all_agents
      page.all('table#agent_details tr td input').each do |checkbox|
        checkbox.set(false)
      end
    end

    def select_agent_at_row(number)
      count = 0
      page.all('table#agent_details tr td input').each do |checkbox|
        count += 1
        checkbox.set(true) if count == number
      end
    end

    def get_idle_agents_count
      count = 0
      page.all('table#agent_details tr td.status').each do |status|
        count += 1 if status.text == 'idle'
      end
      count
    end

    def set_environment(_environment)
      environments.click
      page.all('#environments_panel > div.environments_selector.scrollable_panel div select option.add').each(&:click)
    end

    def wait_till_agents_are_idle(count)
      wait_till_event_occurs_or_bomb 60, "Expected #{count} agents be regsitered by now" do
        reload_page
        break if get_idle_agents_count == count.to_i
      end
    end
  end
end
