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
  class PersonalAccessToken < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/access_tokens"

    element :btn_generate_token, "[data-test-id='generate-token-button']"
    element :text_description, "[data-test-id='form-field-input-description']"
    element :btn_submit, "[data-test-id='button-save']"
    element :tab_active_tokens, "[data-test-id='tab-header-0']"
    element :tab_revoked_tokens, "[data-test-id='tab-header-1']"
    element :table_access_tokens, "[data-test-id='table-body']"

    load_validation { has_btn_generate_token? }

    def generate_token(description = '')
      btn_generate_token.click
      text_description.set(description, rapid: false)
      btn_submit.click
    end

    def remember_token_as(token_id)
      scenario_state.put(token_id, page.find('input').value)
    end

    def has_token_listed?(desc)
      !table_access_tokens.all("[data-test-id='table-row']").collect{ |row|
        row.has_css?('span', text: desc)
      }.empty?
    end
  end
end
