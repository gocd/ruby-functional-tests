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
  class AdminAccessToken < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/admin_access_tokens"

    element :tab_active_tokens, "[data-test-id='tab-header-0']"
    element :tab_revoked_tokens, "[data-test-id='tab-header-1']"
    element :table_access_tokens, "[data-test-id='table-body']"
    element :text_revoke_reason, "[data-test-id='form-field-input-are-you-sure-you-want-to-revoke-this-token']"
    element :btn_revoke, "[data-test-id='button-revoke-token']"

    load_validation { has_tab_active_tokens? }

    def revoke_token(user, description, reason)
      token_row = table_access_tokens.all("[data-test-id='table-row']").select{|row| row.has_css?('td', text: user) && row.has_css?('span', text: description) }
      token_row.first.find("[data-test-id='button-revoke']").click
      text_revoke_reason.set reason
      btn_revoke.click
    end

  end
end
