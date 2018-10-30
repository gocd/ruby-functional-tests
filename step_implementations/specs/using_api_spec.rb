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

step 'Trigger the pipeline <counter> times - Using API' do |counter|
  (0...counter.to_i).each do |number|
    new_pipeline_dashboard_page.can_operate_using_api?
    new_pipeline_dashboard_page.wait_till_pipeline_complete
    instance_count = number+1
    begin
        response = RestClient.get http_url("/api/pipelines/#{scenario_state.self_pipeline}/instance/#{instance_count}"), basic_configuration.header
        assert_true (response.code == 200)
    rescue RestClient::ExceptionWithResponse => err
        p "Pipeline Instance call failed with response code #{err.response.code} and the response body - #{err.response.body}"       
    end
  end
end

step 'Verify <label_count> instance of <pipeline_name> <stage_name> <job_name> <status> - Using Pipeline Instance API' do |label_count, _pipeline_name, stage_name, _job_name, status|
    begin
        response = RestClient.get http_url("/api/pipelines/#{scenario_state.self_pipeline}/instance/#{label_count}"), basic_configuration.header
        assert_true (JSON.parse(response.body)['name'] == scenario_state.self_pipeline)
        assert_true (JSON.parse(response.body)['counter'] == label_count.to_i)
        assert_true (JSON.parse(response.body)['stages'].first['name'] == stage_name)
        assert_true (JSON.parse(response.body)['stages'].first['result'] == status)
        assert_true (JSON.parse(response.body)['stages'].first['counter'].to_i == 1)
    rescue RestClient::ExceptionWithResponse => err
        p "Pipeline Instance call failed with response code #{err.response.code} and the response body - #{err.response.body}"       
    end
end

step 'Verify <label_count> instance of <pipeline_name> <stage_name> <job_name> <status> - Using Stage Api' do |label_count, _pipeline_name, stage_name,job_name, status|
    begin
        response = RestClient.get http_url("/api/stages/#{scenario_state.self_pipeline}/#{stage_name}/instance/#{label_count}/1"), basic_configuration.header
        assert_true (JSON.parse(response.body)['name'] == stage_name)
        assert_true (JSON.parse(response.body)['counter'] == 1)
        assert_true (JSON.parse(response.body)['pipeline_name'] == scenario_state.self_pipeline)
        assert_true (JSON.parse(response.body)['result'] == status)
        assert_true (JSON.parse(response.body)['pipeline_counter'] == label_count.to_i)
    rescue RestClient::ExceptionWithResponse => err
        p "Pipeline Instance call failed with response code #{err.response.code} and the response body - #{err.response.body}"       
    end
end

step 'Verify <label_count> instances of <pipeline_name> <stage_name> <job_name> <status> - Using Pipeline History API' do |label_count, _pipeline_name, stage_name, _job_name, status|
    offset = 0
    while (label_count.to_i - offset) > 0
    apiEndPoint = "/api/pipelines/#{scenario_state.self_pipeline}/history" + (offset == 0 ? '' : '/' + offset.to_s)
    pipeline_counter = label_count.to_i - offset
    current_pageSize = label_count.to_i - offset > 10 ? 10 : label_count.to_i - offset
    hit_pipeline_history_API_and_verify_response(scenario_state.self_pipeline, stage_name, status, apiEndPoint, pipeline_counter, label_count.to_i, offset, current_pageSize)
    offset += 10
    end
end

step 'Verify <label_count> instances of <pipeline_name> <stage_name> <job_name> <status> - Using Stage Api' do |label_count, _pipeline_name, stage_name, _job_name, status|
    offset = 0
    while (label_count.to_i - offset) > 0
    apiEndPoint = "/api/stages/#{scenario_state.self_pipeline}/#{stage_name}/history" + (offset == 0 ? '' : '/' + offset.to_s)
    pipeline_counter = label_count.to_i - offset
    current_pageSize = label_count.to_i - offset > 10 ? 10 : label_count.to_i - offset
    hit_stage_history_API_and_verify_response(scenario_state.self_pipeline, stage_name, status, apiEndPoint, pipeline_counter, label_count.to_i, offset, current_pageSize)
    offset += 10
    end
end

step 'Verify <label_count> instances of <pipeline_name> <stage_name> <job_name> <status> - Using Job Api' do |label_count, _pipeline_name, stage_name,job_name, status|
    offset = 0
    while (label_count.to_i - offset) > 0
    apiEndPoint = "/api/jobs/#{scenario_state.self_pipeline}/#{stage_name}/#{job_name}/history" + (offset == 0 ? '' : '/' + offset.to_s)
    pipeline_counter = label_count.to_i - offset
    current_pageSize = label_count.to_i - offset > 10 ? 10 : label_count.to_i - offset
    hit_job_history_API_and_verify_response(scenario_state.self_pipeline, stage_name, status, apiEndPoint, pipeline_counter, label_count.to_i, offset, current_pageSize, job_name)
    offset += 10
    end
end

def hit_pipeline_history_API_and_verify_response(pipeline_name, stage_name, status, apiEndPoint, pipeline_counter, count, offset, current_pageSize)
    response = RestClient.get http_url(apiEndPoint), basic_configuration.header
    assert_true (JSON.parse(response.body)['pagination']['offset'] == offset)
    assert_true (JSON.parse(response.body)['pagination']['total'] == count)
    assert_true (JSON.parse(response.body)['pagination']['page_size'] == 10)
    assert_true (JSON.parse(response.body)['pipelines'].size == current_pageSize)
    JSON.parse(response.body)['pipelines'].map do |pipeline|
      assert_true (pipeline['name'] == pipeline_name)
      assert_true (pipeline['stages'].first['result'] == status)
      assert_true (pipeline['stages'].first['name'] == stage_name)
      assert_true (pipeline['stages'].first['counter'].to_i == 1)
    end
  rescue RestClient::ExceptionWithResponse => err
    p "Pipeline Status call failed with response code #{err.response.code} and the response body - #{err.response.body}"
end

def hit_stage_history_API_and_verify_response(pipeline_name, stage_name, status, apiEndPoint, pipeline_counter, count, offset, current_pageSize)
    response = RestClient.get http_url(apiEndPoint), basic_configuration.header
    assert_true (JSON.parse(response.body)['pagination']['offset'] == offset)
    assert_true (JSON.parse(response.body)['pagination']['total'] == count)
    assert_true (JSON.parse(response.body)['pagination']['page_size'] == 10)
    assert_true (JSON.parse(response.body)['stages'].size == current_pageSize)
    JSON.parse(response.body)['stages'].map do |stage|
      assert_true (stage['pipeline_name'] == pipeline_name)
      assert_true (stage['result'] == status)
      assert_true (stage['name'] == stage_name)
      assert_true (stage['counter'].to_i == 1)
    end
  rescue RestClient::ExceptionWithResponse => err
    p "Pipeline Status call failed with response code #{err.response.code} and the response body - #{err.response.body}"
end

def hit_job_history_API_and_verify_response(pipeline_name, stage_name, status, apiEndPoint, pipeline_counter, count, offset, current_pageSize,job_name)
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


