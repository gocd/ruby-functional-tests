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
  class AuthConfigSPA < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/security/auth_configs"

    element :add,               "button[class='button add-auth-config']"
    element :id,                "input[data-prop-name='id']"
    element :plugin_id,         "select[data-prop-name='pluginId']"
    element :pwd_file_path,     "input[ng-model='PasswordFilePath']"
    element :ldap_url,          "input[ng-model='Url']"
    element :manager_dn,        "input[ng-model='ManagerDN']"
    element :password,          "input[ng-model='Password']"
    element :search_bases,      "textarea[ng-model='SearchBases']"
    element :login_filter,      "input[ng-model='UserLoginFilter']"
    element :display_name,      "input[ng-model='DisplayNameAttribute']"
    element :email,             "input[ng-model='EmailAttribute']"
    element :search_filter,     "input[ng-model='UserSearchFilter']"
    element :save,              "button[class='button save primary']"
    element :check_connection,  "button[class='button verify-connection save primary']"

    def click_add
      add.click
    end

    def plugin=(plugin)
      plugin_id.select plugin
    end

    def save_config
      save.click
    end

  end
end
