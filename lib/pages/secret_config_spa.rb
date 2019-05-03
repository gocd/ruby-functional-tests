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
    element :file_path, "input[ng-model='SecretsFilePath']"

    element :flash_message, "div[data-test-id='flash-message-success']"
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

    def plugin_id(value)
      plugin_id.select_option(value)
    end

    def filepath(value)
      file_path.set(value)
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

    private

    def find_collapsible_header(id)
      page.all("div[data-test-id='collapse-header']")
          .find {|widget| widget.find("span[data-test-id='key-value-value-id']").text === id}
    end

  end
end
