##########################################################################
# Copyright 2017 ThoughtWorks, Inc.
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
  class SecretConfigSPA < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/secret_configs"

    element :add, "button[data-test-id='add-secret-config']"
    element :save, "button[data-test-id='button-save']"
    element :input_id, "input[data-test-id='form-field-input-id']"
    element :plugin_id, "select[data-test-id='form-field-input-plugin']"
    element :rule_table_body, "tbody[data-test-id='table-body']"
    element :rule_resource_entity, "input[data-test-id='rule-resource']"
    element :file_path, "input[ng-model='SecretsFilePath']"
    element :add_rule_button, "button[data-test-id='add-rule-button']"

    element :flash_message, "div[data-test-id='flash-message-success']"
    element :error_message, "div[data-test-id='flash-message-alert']"
    element :confirm_delete, "button[data-test-id='button-delete']"

    def click_add
      add.click
    end

    def click_confirm_delete
      confirm_delete.click
    end

    def save_secret_conig
      save.click
    end

    def config_id(value)
      input_id.set(value)
    end

    def plugin_value(value)
      plugin_id.select value
    end

    def filepath(value)
      file_path.set(value)
    end

    def rule_resource(value)
      rule_resource_entity.set(value)
    end

    def has_secret_config(id)
      find_collapsible_header(id) != nil
    end

    def delete_secret_config(secret_config_id)
      selected_header = find_collapsible_header(secret_config_id)
      if (selected_header)
        selected_header.find("button[data-test-id='secret-config-delete']").click
      end
    end

    def edit_secret_config(secret_config_id)
      selected_header = find_collapsible_header(secret_config_id)

      if (selected_header)
        selected_header.find("button[data-test-id='secret-config-edit']").click
      end
    end

    def clone_secret_config(secret_config_id)
      selected_header = find_collapsible_header(secret_config_id)

      if (selected_header)
        selected_header.find("button[data-test-id='secret-config-clone']").click
      end
    end

    def add_rule(directive, type, resource)
      add_rule_button.click
      rule_table_body.all("select[data-test-id='rule-directive']", wait: 10).last.select directive
      rule_table_body.all("select[data-test-id='rule-type']").last.select type
      rule_table_body.all("input[data-test-id='rule-resource']").last.set(resource)
    end

    def rearrange_rules
      rule_table_body.find("tr[data-id='0']")
    end

    private

    def find_collapsible_header(id)
      page.all("div[data-test-id='collapse-header']")
          .find {|widget| widget.find("span[data-test-id='key-value-value-id']").text === id}
    end

  end
end
