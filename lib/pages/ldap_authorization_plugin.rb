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

module Pages
  class LDAPAuthorizationPluginAuthConfigModal < AppBase
    element :id, "input[data-test-id='form-field-input-id']"
    element :plugin_id, "select[data-test-id='form-field-input-plugin']"
    element :url, "input[ng-model='Url']"
    element :start_tls, "input[ng-model='StartTLS']"
    element :manager_dn, "input[ng-model='ManagerDN']"
    element :password, "input[ng-model='Password']"
    element :search_bases, "textarea[ng-model='SearchBases']"
    element :user_login_filter, "input[ng-model='UserLoginFilter']"
    element :user_name_attribute, "input[ng-model='UserNameAttribute']"
  end

  class LDAPAuthorizationPluginRoleConfigModal < AppBase
    element :name, "input[data-test-id='form-field-input-role-name']"
    element :auth_config_id, "select[data-test-id='form-field-input-auth-config-id']"
    element :group_membership_attribute, "input[ng-model='UserGroupMembershipAttribute']"
    element :group_identifiers, "textarea[ng-model='GroupIdentifiers']"
    element :group_search_bases, "textarea[ng-model='GroupSearchBases']"
    element :group_membership_filter, "input[ng-model='GroupMembershipFilter']"
  end
end
