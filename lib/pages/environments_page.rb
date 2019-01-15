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
      wait_till_event_occurs_or_bomb 300, "Environment #{scenario_state.get(environment)} failed to showup on environments page" do
        reload_page
        break if page.has_css?("#environment_entity_#{scenario_state.get(environment)}")
      end
    end

    def show_environment(environment)
      reload_page
      page.find("#environment_entity_#{scenario_state.get(environment)}").click
    end

    def click_on_add_new_environment
      page.all("div .add_new_environment")[1].click
    end
    
    def verify_button_is_disabled_on_tab(button_name, tab_name)
      assert_true (page.find("#tab-content-of-#{tab_name}").find(".#{button_name.downcase}.submit").disabled?)
    end

    def verify_button_is_enabled_on_tab(button_name, tab_name)
      assert_true (!page.find("#tab-content-of-#{tab_name}").find(".#{button_name.downcase}.submit").disabled?)
    end

    def add_new_environment(env_name)
      page.find('div .environment_name').find('input' , id: 'environment_name').set env_name
    end

    def verify_tab_is_disabled(list_of_tab_names)
      list_of_tab_names=list_of_tab_names.split(',')
      counter=0
      list_of_tab_names.each do |tab_name|
        page.all('li', class: ['subsequent_tab','disabled'], visible:false)[counter].find('a' ,class: 'tab_button_body_match_text', visible:false, exact_text:"#{tab_name}")
        counter=counter +1
      end   
    end

    def verify_tab_is_enabled(list_of_tab_names)
      list_of_tab_names=list_of_tab_names.split(',')
      counter=0
      list_of_tab_names.each do |tab_name|
        page.all('li', class: ['subsequent_tab','!disabled'], visible:false)[counter].find('a' ,class: 'tab_button_body_match_text', visible:false, exact_text:"#{tab_name}")
        counter=counter +1
      end   
    end

    def click_on_cancel(tab_name)
      page.find("#tab-content-of-#{tab_name}").find(".cancel_button").click
    end

    def verify_on_environments_page
      assert_true (page.all('h1', id: 'page-title', class: 'entity_title')[1].text == 'Environments')
    end

    def verify_current_tab(tab_name)
      page.find('li', class: 'current_tab').find('a', class: 'tab_button_body_match_text',visible:false, exact_text:"#{tab_name}")
    end

    def click_on_tab(tab_name)
      page.find('a', id: "tab-link-of-#{tab_name}").click
    end

    def click_on_button_on_tab(button_name,tab_name)
      page.find("#tab-content-of-#{tab_name}").find(".#{button_name.downcase}.submit").click
    end

    def verify_button_not_present_on_tab(button_name,tab_name)
      assert_true(page.find("#tab-content-of-#{tab_name}").has_no_button?('Next'))
    end

end
end
