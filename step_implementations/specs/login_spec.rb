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

step 'Login as <user> - setup' do |user|
  login_page.load
  login_page.signin user
end

step 'Login as <user>' do |user|
  login_page.load
  login_page.signin user
  login_page.signin_success user
end

step 'Login as <user> - Swift Dashboard' do |user|
  login_page.load
  login_page.signin user
  login_page.signin_success user
end

step 'Logout and login as <user>' do |user|
  logout
  login_page.load
  login_page.signin user
  login_page.signin_success user
end

step 'Logout - from any page' do |_count|
  logout
end

step 'Logout and Login as <user> with password as <pwd>' do |user, pwd|
  logout
  login_page.load
  login_page.signin user, pwd
  login_page.signin_success user
end

step 'As user <user>' do |user|
  scenario_state.put 'current_user', user
end

step 'As unauthenticated user' do
  scenario_state.put 'current_user', nil
end

step 'As user <user> for teardown' do |user|
  scenario_state.put 'current_user', user
end

def logout
  app_base_page.logout
end

step 'Logout and Login as <user> should fail with message <message>' do |user, message|
  logout
  login_page.load
  login_page.signin user
  login_page.signin_failure message
end

step 'Load login page' do |_tmp|
  login_page.load
end

step 'VerifyIfUserHasRole <table>' do |table|
  table.rows.each_with_index do |row, index|
    p "Executing Verify user role validation for row #{index + 1}"
    scenario_state.put('current_user', row['login as user'])
    logout
    login_page.load
    login_page.signin scenario_state.get('current_user')
    (1..table.columns.length - 1).each do |column_count|
      new_pipeline_dashboard_page.load
      method_name = table.columns[column_count]
      raise "The method #{method_name} does not exist" unless new_pipeline_dashboard_page.respond_to?(method_name)
      assert_equal row[table.columns[column_count]], new_pipeline_dashboard_page.send(method_name).to_s
    end
  end
end
