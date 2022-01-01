##########################################################################
# Copyright 2022 ThoughtWorks, Inc.
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
  class BackUpPage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/backup"

    element :btn_confirm_backup, '[data-test-id="button-save"]'
    element :btn_perform_backup, '[data-test-id="perform-backup"]'

    load_validation { has_btn_perform_backup? }

    def perform_backup()
      page.find('button', text: 'Perform Backup').click(wait: 10)
      btn_confirm_backup.click(wait: 5)
    end

    def backup_successful? msg
      page.has_css?('p', text: msg)
    end

    def backup_location
      page.find('p', text: 'Backups are stored in ').find('strong').text
    end

    def last_backup_message
      page.find('p', text:"Last backup was taken by ").text
    end
  end
end
