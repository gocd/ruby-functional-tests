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
  class GeneralSettingsPage < AppBase
    element :env_variable, '#variables'
    element :parameter, '.popup_form #params'
    element :secure_variable, '#variables_secure'
    element :task_save, "button[value='SAVE']"
    element :save_message, '#message_pane > p'

    def on_tab(tab_name)
      page.find('a', text: tab_name).click
    end

    def add_env_variable(variable_name, variable_value)
      env_variable.find('tbody').find_all('tr').last.find('.environment_variable_name').set(variable_name)
      env_variable.find('tbody').find_all('tr').last.find('.environment_variable_value').set(variable_value)
      env_variable.find('a', text: 'Add').click
    end

    def add_sec_env_variable(variable_name, variable_value)
      secure_variable.find('tbody').find_all('tr').last.find('.environment_variable_name').set(variable_name)
      secure_variable.find('tbody').find_all('tr').last.find('.environment_variable_value').set(variable_value)
      secure_variable.find('a', text: 'Add').click
    end

    def get_message
      save_message.text
    end

    def verify_secure_variables_table_row(key)
      secure_variable.find('tbody').find_all('tr').each do |tr|
        return tr.find('.environment_variable_name').value == key
      end
    end

    def verify_variables_table_row(key, value)
      env_variable.find('tbody').find_all('tr').each do |tr|
        return tr.find('.environment_variable_name').value == key && tr.find('.environment_variable_value').value == value
      end
    end

    def verify_parameters_table_row(key, value)
      parameter.find('tbody').find_all('tr').each do |tr|
        return tr.find('.environment_variable_name').value == key && tr.find('.environment_variable_value').value == value
      end
    end

    def is_link_exist?(link)
      page.has_css?('.menu_link', text: link)
    end

    def verify_reset_button_exist?
        page.has_css?('.reset_button')
    end

    def unpause_pipeline
      page.find("button[title='Unpause']").click
    end

    def open_tab(tab)
      page.find('a', text: tab).click
    end

  end
end
