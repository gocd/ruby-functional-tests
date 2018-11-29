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
          scenario_state.put('api_response', err.response)
          raise "Patch agents info call failed with response code #{err.response.code} and the response body - #{err.response.body}"
    end
  end
end

step 'Verify <label_count> instances of <pipeline_name> <stage_name> <job_name> <status> - Using Agents Api' do |label_count, _pipeline_name, stage_name,job_name, status|
  offset = 0
  agent_count=1     # for this use case keeping it one. If this step is reused later, this can be made configurable
  while (label_count.to_i - offset) > 0
  pipeline_counter = label_count.to_i - offset
  current_pageSize = label_count.to_i - offset > 10 ? 10 : label_count.to_i - offset
  hit_agent_history_API_and_verify_response(scenario_state.self_pipeline, stage_name, status, pipeline_counter, label_count.to_i, offset, current_pageSize,agent_count,job_name)
  offset += 10
  end
end

step 'Verify last job <pipeline_name> <stage_name> <job_name> <status> - Using Agents Api' do |pipeline_name, stage_name,job_name, status|
  agent_count=1
  idle_agents = JSON.parse(all_agents_info.body)['_embedded']['agents'].select do |agents|
    agents['agent_state'] == 'Idle'
  end
  idle_agents[0..agent_count.to_i-1].each do |agent|
    begin
      apiEndPoint = "/api/agents/#{agent['uuid']}/job_run_history"
      response = RestClient.get http_url(apiEndPoint), basic_configuration.header
      assert_true (JSON.parse(response.body)['jobs'].first['pipeline_name'] == scenario_state.self_pipeline)
      assert_true (JSON.parse(response.body)['jobs'].first['result'] == status)
      assert_true (JSON.parse(response.body)['jobs'].first['stage_name'] == stage_name)
      assert_true (JSON.parse(response.body)['jobs'].first['name'] == job_name)
      assert_true (JSON.parse(response.body)['jobs'].first['stage_counter'].to_i == 1)
    rescue RestClient::ExceptionWithResponse => err
    p "Pipeline Status call failed with response code #{err.response.code} and the response body - #{err.response.body}"
    end
  end

end

def all_agents_info
  response = RestClient.get http_url('/api/agents'),
                            { accept: GoConstants::AGENTS_API_VERSION }.merge(basic_configuration.header)
  response
rescue RestClient::ExceptionWithResponse => err
  scenario_state.put('api_response', err.response)
  raise "Get all agents info call failed with response code #{err.response.code} and the response body - #{err.response.body}"
end

def hit_agent_history_API_and_verify_response(pipeline_name, stage_name, status, pipeline_counter, count, offset, current_pageSize,agent_count,job_name)
  idle_agents = JSON.parse(all_agents_info.body)['_embedded']['agents'].select do |agents|
    agents['agent_state'] == 'Idle'
  end
  idle_agents[0..agent_count.to_i-1].each do |agent|
    begin
      apiEndPoint = "/api/agents/#{agent['uuid']}/job_run_history" + (offset == 0 ? '' : '/' + offset.to_s)
      response = RestClient.get http_url(apiEndPoint), basic_configuration.header
      assert_true (JSON.parse(response.body)['pagination']['offset'] == offset)
      assert_true (JSON.parse(response.body)['pagination']['total'] == count)
      assert_true (JSON.parse(response.body)['pagination']['page_size'] == 10)
      assert_true (JSON.parse(response.body)['jobs'].size == current_pageSize)
      JSON.parse(response.body)['jobs'].map do |job|
        assert_true (job['pipeline_name'] == pipeline_name)
        assert_true (job['result'] == status)
        assert_true (job['stage_name'] == stage_name)
        assert_true (job['name'] == job_name)
        assert_true (job['stage_counter'].to_i == 1)
      end
    rescue RestClient::ExceptionWithResponse => err
    p "Pipeline Status call failed with response code #{err.response.code} and the response body - #{err.response.body}"
    end
  end
end