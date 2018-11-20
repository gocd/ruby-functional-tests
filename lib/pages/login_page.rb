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
  class Login < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/auth/login"

    element :username, '#user_login'
    element :password, '#user_password'
    element :submit, '#signin2'

    element :current_user_new_dashboard, '[data-test-id="username"]'
    element :current_user_old_dashboard, '.current_user_name'
    element :login_error, '#error-box'

    def signin(user, pwd = 'badger')
      username.set user
      password.set pwd
      submit.click
    end

    def signin_success(user)
      begin
        wait_until_current_user_old_dashboard_visible 10
        assert_equal current_user_old_dashboard.text.downcase, user.downcase
      rescue => e
        assert_equal current_user_new_dashboard.text.downcase, user.downcase
      end
      scenario_state.set_current_user user
    end

    def signin_failure(message)
      wait_until_login_error_visible 10
      assert_equal login_error.text, message
    end
  end
end
