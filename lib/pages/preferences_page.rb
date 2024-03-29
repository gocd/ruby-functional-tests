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
  class Preferences < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/preferences/notifications"

    element :page_title, 'h1[data-test-id="title"]'
    element :notifications_table, 'table[data-test-id="table"]'
    element :pipeline_selector, 'select[data-test-id="form-field-input-pipeline"]'
    element :stage_selector, 'select[data-test-id="form-field-input-stage"]'
    element :event_selector, 'select[data-test-id="form-field-input-event"]'
    element :only_my_commits, 'input[data-test-id="form-field-input-only-if-it-contains-my-check-ins"]'
    element :add_notification, 'button[data-test-id="notification-filter-add"]'
    element :save_notification, 'button[data-test-id="button-save"]'
    element :confirm_delete, 'button[data-test-id="button-cancel"]'

    def verify_title(title)
      assert_equal page_title.text, title
    end

    def notifications_configured
      page.all('table[data-test-id="table"] tbody tr').count
    end

    def delete_notification(row)
      page.all('table[data-test-id="table"] tbody tr')[row.to_i - 1]
          .find('button[data-test-id="notification-filter-delete"]')
          .click
    end
  end
end
