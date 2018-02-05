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

step 'Add environment <env> to any <count> Idle agents - Using Agents API' do |_environment, _count|
  idle_agents = JSON.parse(all_agents_info.body)['_embedded']['agents'].select do |agents|
    agents['agent_state'] == 'Idle'
  end
  idle_agents[0.._count.to_i-1].each do |_agent|
    begin
          response = RestClient.patch http_url("/api/agents/#{_agent['uuid']}"),
                                      "{\"environments\": [\"#{_environment}\"]}",
                                      { accept: GoConstants::AGENTS_API_VERSION, content_type: :json }
                     .merge(basic_configuration.header)
        rescue RestClient::ExceptionWithResponse => err
          scenario_state.add_api_response err.response
          raise "Patch agents info call failed with response code #{err.response.code} and the response body - #{err.response.body}"
        end
  end
end

def all_agents_info
  response = RestClient.get http_url('/api/agents'),
                            { accept: GoConstants::AGENTS_API_VERSION }.merge(basic_configuration.header)
  response
rescue RestClient::ExceptionWithResponse => err
  scenario_state.add_api_response err.response
  raise "Get all agents info call failed with response code #{err.response.code} and the response body - #{err.response.body}"
end

