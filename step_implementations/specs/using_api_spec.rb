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

PIPELINE_STATUS_VERSION = 'application/vnd.go.cd+json'.freeze

step 'Trigger the pipeline <counter> times - Using API' do |counter|
  (0...counter.to_i).each do |number|
    label_count = number + 1
    unless new_pipeline_dashboard_page.can_operate_using_api?
      raise "Could not trigger/operate/schedule the pipeline using the API."
    end
    new_pipeline_dashboard_page.wait_for_expected_stage_state_at_label scenario_state.self_pipeline, "defaultStage", "passed", label_count
    begin
      response = RestClient.get http_url("/api/pipelines/#{scenario_state.self_pipeline}/#{label_count}"), {accept: PIPELINE_STATUS_VERSION}.merge(basic_configuration.header)
      assert_true(response.code == 200)
    rescue RestClient::ExceptionWithResponse => err
      raise "Pipeline Instance call failed with response code #{err.response.code} and the response body - #{err.response.body}"
    end
  end
end

step 'Verify <label_count> instance of <pipeline_name> <stage_name> <job_name> <status> - Using Pipeline Instance API' do |label_count, _pipeline_name, stage_name, _job_name, status|
  begin
    response = RestClient.get http_url("/api/pipelines/#{scenario_state.self_pipeline}/#{label_count}"), {accept: PIPELINE_STATUS_VERSION}.merge(basic_configuration.header)
    instance = JSON.parse(response.body)
    assert_true(instance['name'] == scenario_state.self_pipeline)
    assert_true(instance['counter'] == label_count.to_i)
    assert_true(instance['stages'].first['name'] == stage_name)
    assert_true(instance['stages'].first['result'] == status)
    assert_true(instance['stages'].first['counter'].to_i == 1)
  rescue RestClient::ExceptionWithResponse => err
    raise "Pipeline Instance call failed with response code #{err.response.code} and the response body - #{err.response.body}"
  end
end

step 'Verify <label_count> instance of <pipeline_name> <stage_name> <job_name> <status> - Using Stage Api' do |label_count, _pipeline_name, stage_name, _job_name, status|
  begin
    response = RestClient.get http_url("/api/stages/#{scenario_state.self_pipeline}/#{label_count}/#{stage_name}/1"), {accept: PIPELINE_STATUS_VERSION}.merge(basic_configuration.header)
    instance = JSON.parse(response.body)
    assert_true(instance['name'] == stage_name)
    assert_true(instance['counter'] == 1)
    assert_true(instance['pipeline_name'] == scenario_state.self_pipeline)
    assert_true(instance['result'] == status)
    assert_true(instance['pipeline_counter'] == label_count.to_i)
  rescue RestClient::ExceptionWithResponse => err
    raise "Pipeline Instance call failed with response code #{err.response.code} and the response body - #{err.response.body}"
  end
end

step 'Verify <label_count> instances of <pipeline_name> <stage_name> <job_name> <status> - Using Pipeline History API' do |label_count, _pipeline_name, stage_name, _job_name, status|
  offset = 0
  api_endpoint = http_url("/api/pipelines/#{scenario_state.self_pipeline}/history")
  while api_endpoint
    current_page_size = label_count.to_i - offset > 10 ? 10 : label_count.to_i - offset
    api_endpoint = hit_pipeline_history_api_and_verify_response(scenario_state.self_pipeline, stage_name, status, api_endpoint, current_page_size)
    offset += 10
  end
end

step 'Verify <label_count> instances of <pipeline_name> <stage_name> <job_name> <status> - Using Stage Api' do |label_count, _pipeline_name, stage_name, _job_name, status|
  offset = 0
  api_endpoint = http_url("/api/stages/#{scenario_state.self_pipeline}/#{stage_name}/history")
  while api_endpoint
    current_page_size = label_count.to_i - offset > 10 ? 10 : label_count.to_i - offset
    api_endpoint = hit_stage_history_api_and_verify_response(scenario_state.self_pipeline, stage_name, status, api_endpoint, current_page_size)
    offset += 10
  end
end

step 'Verify <label_count> instances of <pipeline_name> <stage_name> <job_name> <status> - Using Job Api' do |label_count, _pipeline_name, stage_name, job_name, status|
  offset = 0
  api_endpoint = http_url("/api/jobs/#{scenario_state.self_pipeline}/#{stage_name}/#{job_name}/history")
  while api_endpoint
    current_page_size = label_count.to_i - offset > 10 ? 10 : label_count.to_i - offset
    api_endpoint = hit_job_history_api_and_verify_response(scenario_state.self_pipeline, stage_name, status, api_endpoint, current_page_size, job_name)
    offset += 10
  end
end

step 'Attempt to pause pipeline <pipeline_name> with cause <pause_cause> and should return with http status <response_code>' do |pipeline_name, pause_cause, response_code|
  pipeline_name = scenario_state.get(pipeline_name) || pipeline_name
  assert_true(response_code.to_i == pause_pipeline_using_api(pipeline_name, pause_cause))
end

step 'Verify pipeline is paused with reason <pause_cause> by <paused_by> - Using API' do |pause_cause, user|
  begin
    response = RestClient.get(http_url("/api/pipelines/#{scenario_state.self_pipeline}/status"), {accept: PIPELINE_STATUS_VERSION}.merge(basic_configuration.header))
    status = JSON.parse(response.body)
    assert_true(status['paused_cause'] == pause_cause)
    assert_true(status['paused_by'] == user)
  rescue RestClient::ExceptionWithResponse => err
    raise "Pipeline API call failed with response code #{err.response.code} and the response body - #{err.response.body}"
  end
end

step 'Verify pipeline is unpaused - Using API' do
  begin
    response = RestClient.get(http_url("/api/pipelines/#{scenario_state.self_pipeline}/status"), {accept: PIPELINE_STATUS_VERSION}.merge(basic_configuration.header))
    assert_false JSON.parse(response.body)['paused']
  rescue RestClient::ExceptionWithResponse => err
    raise "Pipeline API call failed with response code #{err.response.code} and the response body - #{err.response.body}"
  end
end

step 'Attempt to unpause pipeline <pipeline_name> and should return with http status <response_code>' do |pipeline_name, response_code|
  pipeline_name = scenario_state.get(pipeline_name) || pipeline_name
  assert_true(response_code.to_i == unpause_pipeline_using_api(pipeline_name))
end

def hit_pipeline_history_api_and_verify_response(pipeline_name, stage_name, status, api_endpoint, current_page_size)
  response = RestClient.get api_endpoint, {accept: PIPELINE_STATUS_VERSION}.merge(basic_configuration.header)
  history = JSON.parse(response.body)
  assert_equal current_page_size, history['pipelines'].size
  history['pipelines'].map do |pipeline|
    assert_true(pipeline['name'] == pipeline_name)
    assert_true(pipeline['stages'].first['result'] == status)
    assert_true(pipeline['stages'].first['name'] == stage_name)
    assert_true(pipeline['stages'].first['counter'].to_i == 1)
  end
  history.dig('_links', 'next', 'href')
rescue RestClient::ExceptionWithResponse => err
  raise "Pipeline Status call failed to #{api_endpoint} with response code #{err.response.code} and the response body - #{err.response.body}"
end

def hit_stage_history_api_and_verify_response(pipeline_name, stage_name, status, api_endpoint, current_page_size)
  response = RestClient.get api_endpoint, {accept: PIPELINE_STATUS_VERSION}.merge(basic_configuration.header)
  history = JSON.parse(response.body)
  assert_equal current_page_size, history['stages'].size
  history['stages'].map do |stage|
    assert_true(stage['pipeline_name'] == pipeline_name)
    assert_true(stage['result'] == status)
    assert_true(stage['name'] == stage_name)
    assert_true(stage['counter'].to_i == 1)
  end
  history.dig('_links', 'next', 'href')
rescue RestClient::ExceptionWithResponse => err
  raise "Pipeline Status call failed to #{api_endpoint} with response code #{err.response.code} and the response body - #{err.response.body}"
end

def hit_job_history_api_and_verify_response(pipeline_name, stage_name, status, api_endpoint, current_page_size, job_name)
  response = RestClient.get api_endpoint, {accept: PIPELINE_STATUS_VERSION}.merge(basic_configuration.header)
  history = JSON.parse(response.body)
  assert_equal current_page_size, history['jobs'].size
  history['jobs'].map do |job|
    assert_true(job['pipeline_name'] == pipeline_name)
    assert_true(job['result'] == status)
    assert_true(job['stage_name'] == stage_name)
    assert_true(job['name'] == job_name)
    assert_true(job['stage_counter'].to_i == 1)
  end
  history.dig('_links', 'next', 'href')
rescue RestClient::ExceptionWithResponse => err
  raise "Pipeline Status call failed to #{api_endpoint} with response code #{err.response.code} and the response body - #{err.response.body}"
end

def pause_pipeline_using_api(pipeline_name, pause_cause)
  tmp = {
      pause_cause: pause_cause
  }
  begin
    response = RestClient.post http_url("/api/pipelines/#{pipeline_name}/pause"), JSON.generate(tmp),
                               {content_type: :json, accept: PIPELINE_STATUS_VERSION, X_GoCD_Confirm: 'true'}.merge(basic_configuration.header)
    return response.code
  rescue RestClient::ExceptionWithResponse => err
    p "Pause Pipeline API call failed with response code #{err.response.code} and the response body - #{err.response.body}"
    return err.response.code
  end
end

def unpause_pipeline_using_api(pipeline_name)
  response = RestClient.post http_url("/api/pipelines/#{pipeline_name}/unpause"), {},
                             {accept: PIPELINE_STATUS_VERSION, X_GoCD_Confirm: 'true'}.merge(basic_configuration.header)
  response.code
rescue RestClient::ExceptionWithResponse => err
  p "Unpause Pipeline API call failed with response code #{err.response.code} and the response body - #{err.response.body}"
  err.response.code
end
