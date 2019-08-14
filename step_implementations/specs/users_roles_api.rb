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

USERS_API_VERION = 'application/vnd.go.cd+json'.freeze
ROLES_API_VERION = 'application/vnd.go.cd+json'.freeze

step 'Add user <user> - Using user API' do |user|
  RestClient.post http_url('/api/users'), { login_name: user }.to_json,
                  { content_type: :json, accept: USERS_API_VERION }.merge(basic_configuration.header)
end

step 'Add user <user> using access token <token_id> - Using user API' do |user, token_id|
  p "Using token id #{scenario_state.get(token_id)}"
  RestClient.post http_url('/api/users'), { login_name: user }.to_json,
                  { content_type: :json, accept: USERS_API_VERION, Authorization: "Bearer #{scenario_state.get(token_id)}" }
end

step 'Add user <user> to role <role> using access token <token_id> - Using roles API' do |user, role, token_id|
  etag = get_role(role, token_id).headers[:etag]
  payload = %({
      "name": "#{role}",
      "type": "gocd",
      "attributes": {
        "users": ["#{user}"]
      }
    }
  )
  RestClient.put http_url("/api/admin/security/roles/#{role}"), payload,
                 {content_type: :json, if_match: etag, accept: ROLES_API_VERION, Authorization: "Bearer #{scenario_state.get(token_id)}"}
end

def get_role(role, token_id)
  RestClient.get http_url("/api/admin/security/roles/#{role}"),
                 {accept: ROLES_API_VERION, Authorization: "Bearer #{scenario_state.get(token_id)}"}
end
