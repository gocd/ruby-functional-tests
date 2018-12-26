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
    


    load_validation { has_add_store? }

    def start_add_store
      add_store.click
      assert_true has_store_modal?
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


  end
end
