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
  class PipelineGroupEditPage < AppBase

    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/pipeline_group{/group}/edit"

    element :add_user_permission, "#USER_add_users_and_roles"
    element :add_role_permission, "#ROLE_add_users_and_roles"
    element :save, "button[type='submit']"
    element :user_name, "input[class='form_input permissions_USER_name ac_input']"
    element :role_name, "input[class='form_input permissions_ROLE_name ac_input']"
    element :role_view_privilege, "#viewPrivilege_ROLE_name"
    element :user_view_privilege, "#viewPrivilege_USER_name"
    element :role_admin_privilege, "#adminPrivilege_ROLE_name"
    element :user_admin_privilege, "#adminPrivilege_USER_name"

    def remove_permission_for_role permission,role
      page.find("#{permission}Privilege_ROLE_#{role}").click if !page.find("#{permission}Privilege_ROLE_#{role}").checked?
    end
  end
end
