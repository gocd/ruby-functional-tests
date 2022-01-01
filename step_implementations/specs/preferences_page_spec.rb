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

step "On Preferences page" do
  preferences_page.load
end

step "Verify page title is <title>" do |title|
  preferences_page.verify_title(title)
end

step "Verify <count> notifications are present" do |count|
  assert_equal count.to_i, preferences_page.notifications_configured
end

step "Set pipeline as <pipeline>" do |pipeline|
  preferences_page.pipeline_selector.select scenario_state.get(pipeline)
end

step "Set stage as <stage>" do |stage|
  preferences_page.stage_selector.select stage
end

step "Set event as <event>" do |event|
  preferences_page.event_selector.select event
end

step "Set notification for all commits" do
  preferences_page.only_my_commits.set false
end

step "Save notification" do
  preferences_page.save_notification.click
end

step "Delete notification <row>" do |row|
  preferences_page.delete_notification(row)
end

step 'Add new notification' do
  preferences_page.add_notification.click
end

step 'Confirm delete notification' do
  preferences_page.confirm_delete.click
end
