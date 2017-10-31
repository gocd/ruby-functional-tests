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

step "Login as <user> - setup" do |user|
  login_page.load
  login_page.signin user
end

step "Login as <user>" do |user|
  pipeline_dashboard_page.load
  app_base_page.logout
  login_page.signin user
end

step "Logout and login as <user>" do |user|
  pipeline_dashboard_page.load
  app_base_page.logout
  login_page.signin user
end


step "Login as <user> with password as <pwd>" do |user, pwd|
  pipeline_dashboard_page.load
  app_base_page.logout
  login_page.signin user, pwd
end

step "As user <user>" do |user|
  scenario_state.set_current_user user
end

step "As user <user> for teardown" do |user|
  scenario_state.set_current_user user
end
