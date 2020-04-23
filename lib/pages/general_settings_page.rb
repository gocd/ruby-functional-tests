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
    element :global_save, 'button[data-test-id="save"]'
    element :task_save, 'button[data-test-id="save-pipeline-group"]'
    element :task_cancel, 'button[data-test-id="cancel-button"]'
    element :save_message, 'div[data-test-id="flash-message-success"]'
    element :error_message, 'div[data-test-id="flash-message-alert"]'

    def on_tab(tab_name)
      page.find('a', text: tab_name.upcase).click
    end

    def add_env_variable(variable_name, variable_value)
      page.find('button[data-test-id="add-plain-text-variables-btn"]').click
      page.find_all('input[data-test-id="env-var-name"]').last.set(variable_name)
      page.find_all('input[data-test-id="env-var-value"]').last.set(variable_value)
    end

    def add_sec_env_variable(variable_name, variable_value)
      page.find('button[data-test-id="add-secure-variables-btn"]').click
      page.find_all('input[data-test-id="secure-env-var-name"]').last.set(variable_name)
      page.find_all('input[data-test-id="secure-env-var-value"]').last.set(variable_value)
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
