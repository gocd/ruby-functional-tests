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
      page.all('input[data-test-id="secure-env-var-name"]')
          .find {|element| element.text === key}
    end

    def verify_variables_table_row(key, value)
      page.all('div[data-test-id="environment-variable-wrapper"]').find do |tr|
        tr.find('input[data-test-id="env-var-name"]').value === key && tr.find('input[data-test-id="env-var-value"]').value === value
      end
    end

    def verify_parameters_table_row(key, value)
      page.find('tbody')
          .find_all('tr')
          .each do |tr|
        return tr.find('input[data-test-id^="form-field-input-param-name-"]').value == key && tr.find('input[data-test-id^="form-field-input-param-value-"]').value == value
      end
    end

    def is_link_exist?(link)
      page.has_css?('.menu_link', text: link)
    end

    def verify_reset_button_exist?
      page.has_css?('.reset_button')
    end

    def unpause_pipeline
      page.find("button[data-test-id='page-header-unpause-btn'").click
    end

    def open_tab(tab)
      page.find('a', text: tab).click
    end

    def enable_new_pipeline_config
      page.find('a.quick_edit_button').click
    end

    def set_parameter(index, env_name, env_value)
      page.find("#params > table:nth-child(1) tr:nth-child(#{index}) td .environment_variable_name").set(env_name)
      page.find("#params > table:nth-child(1) tr:nth-child(#{index}) td .environment_variable_value").set(env_value)
      save.click
    end

    def add_parameter(name, value)
      params_row = page.find('table[data-test-id="table"] tbody').all('tr').last
      params_row.find("input[data-test-id^='form-field-input-param-name-']").set name
      params_row.find("input[data-test-id^='form-field-input-param-value-']").set new_pipeline_dashboard_page.sanitize_message(value)
    end
  end
end
