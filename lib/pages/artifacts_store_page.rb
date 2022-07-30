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

  class ArtifactsStore < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/artifact_stores"

    element :add_store, "button[data-test-id='add-artifact-stores-button']"
    element :store_modal, 'div[data-test-id="modal-body"]'
    element :save, "button[data-test-id='button-save']"
    element :id, "input[data-test-id='form-field-input-id']"
    element :plugin_id, "select[data-test-id='form-field-input-plugin-id']"
    element :server_url, "input[ng-model='Url']"
    element :username, "input[ng-model='Username']"
    element :password, "input[ng-model='Password']"
    element :flash_message, "div[data-test-id='flash-message-success']"
    element :error_message, "div[data-test-id='flash-message-alert']"
    element :confirm_delete, "button[data-test-id='button-delete']"


    load_validation {has_add_store?}

    def start_add_store
      add_store.click
      assert_true has_store_modal?
    end

    def click_confirm_delete
      confirm_delete.click
    end

    def plugin=(plugin)
      plugin_id.select plugin
    end

    def fill_form(field_value)
      f = field_value.split(':', 2)
      instance_eval(f[0]).set("#{f[1].strip}")
    end

    def save_store
      save.click
    end

    def expand_plugin
      page.find("div[data-test-id='collapse-header']").click
    end

    def has_artifact_store(artifact_store_id)
      page.all("span[data-test-id='key-value-value-id']")
          .find {|widget| widget.text === artifact_store_id} != nil
    end

    def edit_artifact_store(artifact_store_id)
      selected_header = find_collapsable_header(artifact_store_id)

      if selected_header
        selected_header.find("button[data-test-id='artifact-store-edit']").click
      end
    end

    def clone_artifact_store(artifact_store_id)
      selected_header = find_collapsable_header(artifact_store_id)

      if selected_header
        selected_header.find("button[data-test-id='artifact-store-clone']").click
      end
    end

    def delete_artifact_store(artifact_store_id)
      selected_header = find_collapsable_header(artifact_store_id)

      if selected_header
        selected_header.find("button[data-test-id='artifact-store-delete']").click
      end
    end

    private

    def find_collapsable_header(artifact_store_id)
      page.all("div[data-test-id='collapse-body'] div[data-test-id='collapse-header']")
          .find {|widget| widget.find("span[data-test-id='key-value-value-id']").text === artifact_store_id}
    end
  end
end
