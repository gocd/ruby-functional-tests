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

module Pages
  class Login < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/auth/login"

    element :username, '#user_login'
    element :password, '#user_password'
    element :submit, '#signin2'
    element :current_user, "a[class='current_user_name dropdown-arrow-icon']"


    def signin(user, pwd = 'badger')
      username.set user
      password.set pwd
      submit.click
      assert_equal current_user.text.downcase, user.downcase
      scenario_state.set_current_user user
    end
  end
end
