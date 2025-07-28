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

AGENTS_API_VERSION = 'application/vnd.go.cd+json'.freeze
AGENT_JOB_HISTORY_VERSION = 'application/vnd.go.cd+json'.freeze

step 'Add environment <env> to any <count> Idle agents - Using Agents API' do |_environment, _count|
  agents_with_state('Idle')[0.._count.to_i - 1].each do |agent|
    begin
      patch_agent(agent['uuid'], "{\"environments\": [\"#{_environment}\"]}")
    rescue RestClient::ExceptionWithResponse => err
      scenario_state.put('api_response', err.response)
      raise "Patch agents info call failed with response code #{err.response.code} and the response body - #{err.response.body}"
    end
  end
end

step 'Add environment <env> to all Idle agents - Using Agents API' do |_environment, _count|
  agents_with_state('Idle').each do |agent|
    begin
      patch_agent(agent['uuid'], "{\"environments\": [\"#{_environment}\"]}")
    rescue RestClient::ExceptionWithResponse => err
      scenario_state.put('api_response', err.response)
      raise "Patch agents info call failed with response code #{err.response.code} and the response body - #{err.response.body}"
    end
  end
end

step 'Verify <label_count> instances of <pipeline_name> <stage_name> <job_name> <status> - Using Agents Api' do |label_count, _pipeline_name, stage_name, job_name, status|
  offset = 0
  while (label_count.to_i - offset) > 0
    pipeline_counter = label_count.to_i - offset
    current_page_size = pipeline_counter > 10 ? 10 : pipeline_counter
    hit_agent_history_api_and_verify_response(scenario_state.self_pipeline, stage_name, status, pipeline_counter, label_count.to_i, offset, current_page_size, job_name)
    offset += 10
  end
end

step 'Verify any operation on agents return code <code> - Using Agents Api' do |expected_code|
  actual_code = patch_agent(agents_with_state('Idle')[0]['uuid'], "{\"agent_config_state\": [\"Disabled\"]}").code
  assert_true actual_code.eql?(expected_code.to_i), "Response code not expected. Actual code : #{actual_code}"
end

step 'Verify last job <pipeline_name> <stage_name> <job_name> <status> - Using Agents Api' do |_pipeline_name, stage_name, job_name, status|
  agents_with_state('Idle').each do |agent|
    api_end_point = http_url("/api/agents/#{agent['uuid']}/job_run_history")
    begin
      response = RestClient.get api_end_point, { accept: AGENT_JOB_HISTORY_VERSION }.merge(basic_configuration.header)
      response_json = JSON.parse(response.body)
      assert_true response_json['jobs'].first['pipeline_name'] == scenario_state.self_pipeline
      assert_true response_json['jobs'].first['result'] == status
      assert_true response_json['jobs'].first['stage_name'] == stage_name
      assert_true response_json['jobs'].first['job_name'] == job_name
      assert_true response_json['jobs'].first['stage_counter'].to_i == 1
    rescue RestClient::ExceptionWithResponse => err
      raise "Pipeline Status call to #{api_end_point} failed with response code #{err.response.code} and the response body - #{err.response.body}"
    end
  end
end

step 'Verify there are <num> agents with state <state>' do |num,state|
  assert_equal agents_with_state(state).map.size,num.to_i
end

step 'With <count> live agents - teardown' do |count|
  go_agents.destroy_agents count
  delete_all_agents
end

def all_agents_info
  RestClient.get http_url('/api/agents'),
                            {accept: AGENTS_API_VERSION}.merge(basic_configuration.header) do |response, _request, _result|
    response
  end
end

def delete_all_agents
  all_agents = JSON.parse(all_agents_info.body)['_embedded']['agents']
  all_agents.map! do |agents|
    agents['uuid']
  end
  bulk_update_agent(%({"uuids": #{all_agents}, "agent_config_state" : "disabled"}))
  RestClient::Request.execute(method: :delete, url: http_url("/api/agents"),
    payload: %({"uuids": #{all_agents}}), headers: { accept: AGENTS_API_VERSION, content_type: :json }
    .merge(basic_configuration.header)) do |response, _request, _result|
    response
  end
end

def patch_agent(agent_uuid, patch_request)
  RestClient.patch http_url("/api/agents/#{agent_uuid}"),
                                  patch_request,
                                  { accept: AGENTS_API_VERSION, content_type: :json }
                                  .merge(basic_configuration.header) do |response, _request, _result|
    response
  end
end

def bulk_update_agent(patch_request)
  RestClient.patch http_url("/api/agents"),
                                  patch_request,
                                  { accept: AGENTS_API_VERSION, content_type: :json }
                                  .merge(basic_configuration.header) do |response, _request, _result|
    response
  end
end

def agents_with_state(state)
  JSON.parse(all_agents_info.body)['_embedded']['agents'].select do |agents|
    agents['agent_state'] == state
  end
end

def hit_agent_history_api_and_verify_response(pipeline_name, stage_name, status, _pipeline_counter, count, offset, current_page_size, job_name)
  agents_with_state('Idle').each do |agent|
    begin
      api_end_point = "/api/agents/#{agent['uuid']}/job_run_history?page_size=10" + (offset == 0 ? '' : '&offset=' + offset.to_s)
      response      = RestClient.get http_url(api_end_point), {accept: AGENT_JOB_HISTORY_VERSION}.merge(basic_configuration.header)
      response_json = JSON.parse(response.body)
      actual_offset = response_json['pagination']['offset']
      actual_total  = response_json['pagination']['total']
      page_size     = response_json['pagination']['page_size']
      jobs_size     = response_json['jobs'].size
      assert_true actual_offset == offset, "Expected: #{offset} Actual: #{actual_offset}"
      assert_true actual_total == count, "Expected: #{count} Actual: #{actual_total}"
      assert_true page_size == 10
      assert_true jobs_size == current_page_size, "Expected: #{current_page_size} Actual: #{jobs_size}"
      response_json['jobs'].map do |job|
        assert_true job['pipeline_name'] == pipeline_name
        assert_true job['result'] == status
        assert_true job['stage_name'] == stage_name
        assert_true job['job_name'] == job_name
        assert_true job['stage_counter'].to_i == 1
      end
    rescue RestClient::ExceptionWithResponse => err
      raise "Pipeline Status call failed with response code #{err.response.code} and the response body - #{err.response.body}"
    end
  end
end
