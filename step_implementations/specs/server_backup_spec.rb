##########################################################################
# Copyright 2016 ThoughtWorks, Inc.
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

step 'Perform server backup' do |user|
  server_backup_page.perform_backup
end

step "On server backup page" do
  server_backup_page.load
end

step 'Verify back up completed with message <msg>' do |msg|
  actual_msg = server_backup_page.backup_message
  assert_true server_backup_page.backup_message.eql?(msg), "Expected #{msg}, Actual #{actual_msg}"
end

