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
  class Preferences < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/preferences/notifications"

    element :page_title, "#page-title"
    element :notifications_table, ".notification-filters-list"
    element :pipeline_selector, "select[name='pipeline']"
    element :stage_selector, "select[name='stage']"
    element :event_selector, "select[name='event']"
    element :only_my_commits, "input[name='match_commits']"
    element :add_notification, "input[type='submit']"

    def verify_title(title)
      assert_equal page_title.text, title
    end

    def notifications_configured
      notifications_table.all('tbody tr').count
    end

    def delete_notification(row)
      notifications_table.all('tbody tr')[row.to_i - 1]
          .find('button')
          .click
    end
  end
end
