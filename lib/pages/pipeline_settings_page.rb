##########################################################################
# Copyright 2018 ThoughtWorks, Inc.
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
  class PipelineSettingsPage < GeneralSettingsPage
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/pipelines{/pipeline_name}/general"

    element :message, '#success'
    element :add_variables, '#add_variables'
    element :save, "button[value='SAVE']"
    element :material_url_field, '.url'
    element :check_connection, "button[value='CHECK CONNECTION']"
    element :cron_timer, "input#pipeline_timer_timerSpec"

    def message_displayed?(message)
      page.has_css?('.success', text: message, exact_text: true)
    end

    def partial_message_displayed?(message)
      page.find('.success').text.include?(message)
    end

    def add_parameter(name, value)
      params_row = page.find('.params.variables').find('.params').all('tr').last
      params_row.find("input[name='pipeline[params][][name]']").set name
      params_row.find("input[name='pipeline[params][][valueForDisplay]']").set value
      add_variables.click
    end

    def select_material(material_name)
      page.find('td a', text: material_name).click
    end

    def connection_ok?
      page.has_css?('.ok_message')
    end

    def set_material_url(url)
      page.find('.url').set url
    end

    def select_add_new_material(type)
      page.find('.menu_link', text: 'Add Material').click
      page.find('#new_material_popup ul li a', text: type, exact_text: true).click
    end

    def delete_material(material_name)
      page.find('.material_name', text: material_name, exact_text: true).ancestor('tr').find('.icon_remove').click
      page.find("button[value='Proceed']").click
    end

    def set_material_blacklist(blacklist)
      page.find("textarea[name='material[filterAsString]']").set blacklist
    end

    def only_on_changes_checkbox_disabled?
      page.find("input#pipeline_timer_onlyOnChanges").disabled?
    end

    def set_only_on_changes_checkbox
      page.find("input#pipeline_timer_onlyOnChanges").set(true)
    end  


  end
end
