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
  class EnvironmentsPage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/environments"

    def wait_till_environment_showsup(environment)
      wait_till_event_occurs_or_bomb 300, "Environment #{scenario_state.get_environment(environment)} failed to showup on environments page" do
        reload_page
        break if page.has_css?("#environment_entity_#{scenario_state.get_environment(environment)}")
      end
    end

    def show_environment(environment)
      page.find("#environment_entity_#{scenario_state.get_environment(environment)}").click
    end

  end
end
