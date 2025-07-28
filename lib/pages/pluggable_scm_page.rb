##########################################################################
# Copyright 2022 Thoughtworks, Inc.
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
  class PluggableSCMPage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/scms"

    element :flash_message, "div[data-test-id='flash-message-success']"
    element :error_message, "div[data-test-id='flash-message-alert']"
    element :confirm_delete, "button[data-test-id='button-delete']"
    element :add_scm_button, "div[data-test-id='pageActions'] button"

    element :scm_name, "input[data-test-id='form-field-input-name']"
    element :scm_plugin, "select[data-test-id='form-field-input-plugin']"
    element :scm_url, "input[ng-model='url']"
    element :scm_username, "input[ng-model='username']"
    element :scm_password, "input[ng-model='password']"
    element :save_button, "button[data-test-id='button-save']"

    load_validation { add_scm_button(wait: 20) }

    def scm_labels
      page.all("div[data-test-id='collapse-header'] span[data-test-id='key-value-value-name']")
          .collect(&:text)
    end

    def open_scm_config(scm_name)
      find_collapsible_header(scm_name).click
    end

    def scm_config(scm_name, id)
      find_collapsible_header(scm_name)
          .sibling('div')
          .find("span[data-test-id='key-value-value-#{id}']")
    end

    def clone_scm(scm_name)
      find_collapsible_header(scm_name)
          .find("button[data-test-id='pluggable-scm-clone']")
          .click
    end

    def edit_scm(scm_name)
      find_collapsible_header(scm_name)
          .find("button[data-test-id='pluggable-scm-edit']")
          .click
    end

    def delete_scm(scm_name)
      find_collapsible_header(scm_name)
          .find("button[data-test-id='pluggable-scm-delete']")
          .click
    end

    def is_connection_ok
      page.find("button[data-test-id='button-check-connection']").click
      page.find("div[data-test-id='flash-message-success']").text === "Connection Ok!"
    end

    private

    def find_collapsible_header(name)
      page.all("div[data-test-id='collapse-header']")
          .find {|widget| widget.find("span[data-test-id='key-value-value-name']").text === name}
    end

    def find_collapsible_body(name)
      panel = page.all("div[data-test-id='pluggable-scm-panel']")
                  .find {|widget| widget.find("div[data-test-id='collapse-header'] span[data-test-id='key-value-value-name']").text === name}
      panel.find("div[data-test-id='collapse-body']")
    end

  end
end
