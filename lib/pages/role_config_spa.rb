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
  class RoleConfigSPA < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/security/roles"

    element :add,               "button[class='button add-role']"
    element :gocd_role,         "input[class='core-role']"
    element :role_name,         "input[data-model-type='role']"
    element :role_users,        "input[placeholder='username']"
    element :add_role,          "button[class='button add-role-user-button']"
    element :save,              "button[class='button save primary']"

    def click_add
      add.click
    end

    def gocd_role=(value)
      gocd_role.set(value)
    end

    def save_role
      save.click
    end

  end
end
