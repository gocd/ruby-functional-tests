##########################################################################
# Copyright 2020 ThoughtWorks, Inc.
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

require 'json'

USAGE_DATA_API_VERSION = 'application/vnd.go.cd+json'.freeze
API_IDENTIFIER = "deprecated_api_list"

step 'Fetch deprecated api list' do
  scenario_state.put API_IDENTIFIER, APIBuilder.all_deprecated_apis.to_json
end

step 'Verify deprecated apis have deprecation headers' do
  deprecated_apis = JSON.parse(scenario_state.get API_IDENTIFIER)
  deprecated_apis.each(&method(:verify_deprecated_headers))
end

private

def make_api_call(api)
  begin
    response = RestClient.get http_url(api['path']), {accept: api['version']}.merge(basic_configuration.header)
  rescue => e
    response = e.response
  end

  response
end

def verify_deprecated_headers(api)
  return unless (api['method'] == 'get')

  puts "Requesting #{api['method']} #{api['path']} #{api['version']}"
  response = make_api_call(api)
  verify_deprecation_header_exists(api, response)
end

def verify_deprecation_header_exists(api, response)
  assert_equal response.headers[:x_gocd_api_deprecated_in], "v#{api['deprecation_info']['deprecated_in']}"
  assert_equal response.headers[:x_gocd_api_removal_in], "v#{api['deprecation_info']['removal_in']}"
end
