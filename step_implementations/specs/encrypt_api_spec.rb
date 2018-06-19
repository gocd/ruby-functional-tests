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

include Helpers::GoUrlHelper

ENCRYPT_API_VERSION = 'application/vnd.go.cd.v1+json'.freeze

step 'Encrypt value <value> and store encrypted value as <identifier>' do |value, identifier|
  begin
    scenario_state.store identifier, JSON.parse(encrypt(value).body)['encrypted_value']
  rescue RestClient::ExceptionWithResponse => err
    scenario_state.store 'api_response', err.response
  end
end

step 'Verify encrypted values <identifier0> and <identifier1> are not same' do |identifier0, identifier1|
  assert_false scenario_state.retrive(identifier0).eql? scenario_state.retrive(identifier1)
end


step 'Encrypt value <value>' do |value, identifier|
  begin
    encrypt(value)
  rescue RestClient::ExceptionWithResponse => err
    scenario_state.store 'api_response', err.response
  end
end

private

def encrypt value
  RestClient.post http_url('/api/admin/encrypt'), %({"value": "#{value}"}),
                               { content_type: :json, accept: ENCRYPT_API_VERSION }.merge(basic_configuration.header)
end