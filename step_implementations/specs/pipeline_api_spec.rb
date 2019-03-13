##########################################################################
# Copyright 2016 ThoughtWorks, Inc.
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

require_relative '../../lib/helpers/go_url_helper.rb'

PIPELINE_CONFIG_API_VERSION = 'application/vnd.go.cd.v1+json'

step 'Verify pipeline <pipeline> is locked and not schedulable - Using api' do |pipeline|
  begin
    response = RestClient.get http_url("/api/pipelines/#{scenario_state.get(pipeline)}/status"), basic_configuration.header
    assert_true JSON.parse(response.body)['locked']
    assert_false JSON.parse(response.body)['schedulable']
  rescue RestClient::ExceptionWithResponse => err
    p "Pipeline Status call failed with response code #{err.response.code} and the response body - #{err.response.body}"
  end
end

step 'Trigger pipeline <pipeline> and verify response code <code> - Using api' do |pipeline, response_code|
  RestClient.post http_url("/api/pipelines/#{scenario_state.get(pipeline)}/schedule"),
                  { content_type: :json, accept: PIPELINE_CONFIG_API_VERSION }.merge(basic_configuration.header) do |response, _request, _result|
    assert_true response.code == response_code.to_i
  end
end


step 'Verify pipeline <pipeline> is not locked and is schedulable - Using api' do |pipeline|
  begin
    response = RestClient.get http_url("/api/pipelines/#{scenario_state.get(pipeline)}/status"), basic_configuration.header
    assert_false JSON.parse(response.body)['locked']
    assert_true JSON.parse(response.body)['schedulable']
  rescue RestClient::ExceptionWithResponse => err
    p "Pipeline Status call failed with response code #{err.response.code} and the response body - #{err.response.body}"
  end
end

step 'Trigger stage <stage> run <run>' do |stage, run|
  begin
    response = RestClient.post http_url("/run/#{scenario_state.self_pipeline}/#{run}/#{stage}"), '', basic_configuration.header
    assert_true response.code == 200
  rescue RestClient::ExceptionWithResponse => err
    p "Trigger stage call failed with response code #{err.response.code} and the response body - #{err.response.body}"
  end
  new_pipeline_dashboard_page.verify_pipeline_stage_state(scenario_state.self_pipeline, stage, 'building')
end

step 'Cancel stage <stage> of pipeline <pipeline>' do |stage, pipeline|
  begin
    response = RestClient.post http_url("/api/stages/#{scenario_state.get(pipeline)}/#{stage}/cancel"), '', basic_configuration.header
    assert_true response.code == 200
  rescue RestClient::ExceptionWithResponse => err
    p "Cancel stage call failed with response code #{err.response.code} and the response body - #{err.response.body}"
  end
end

step 'Schedule should return code <status_code>' do |status_code|
  payload=   "{\"environment_variables\": [],\"materials\": [],\"update_materials_before_scheduling\": true}"
  begin
    response = RestClient.post http_url("/api/pipelines/#{scenario_state.self_pipeline}/schedule"), payload,
        { content_type: :json, accept: 'application/vnd.go.cd.v1+json' }.merge(basic_configuration.header)
    assert_true response.code == status_code.to_i
  rescue RestClient::ExceptionWithResponse => err
    p "Schedule did not return #{status_code}"
  end
end

step 'Verify can unlock <pipeline>' do |pipeline|
 body= begin
    response = RestClient.post http_url("/api/pipelines/#{scenario_state.get(pipeline)}/unlock"),'',
        { content_type: :json, accept: 'application/vnd.go.cd.v1+json','X-GoCD-Confirm': 'true' }.merge(basic_configuration.header)
  rescue RestClient::ExceptionWithResponse => err
    p err.response.body
  end

  assert_true JSON.parse(body).to_s.include?"Pipeline lock released for #{scenario_state.get(pipeline)}"
end

step 'Verify unauthorized to unlock <pipeline>' do |pipeline|
  body=begin
    response = RestClient.post http_url("/api/pipelines/#{scenario_state.get(pipeline)}/unlock"),'',
        { content_type: :json, accept: 'application/vnd.go.cd.v1+json','X-GoCD-Confirm': 'true'}.merge(basic_configuration.header)
  rescue RestClient::ExceptionWithResponse => err
    p err.response.body
  end
  assert_true JSON.parse(body).to_s.include?'You are not authorized to perform this action'
end

step 'Verify unlocking <pipeline> is not acceptable because <message>' do |pipeline,message|
  body=begin
    response = RestClient.post http_url("/api/pipelines/#{scenario_state.get(pipeline)}/unlock"),'',
        { content_type: :json, accept: 'application/vnd.go.cd.v1+json','X-GoCD-Confirm': 'true' }.merge(basic_configuration.header)
  rescue RestClient::ExceptionWithResponse => err
    p err.response.body
  end
  assert_true JSON.parse(body).to_s.include?message
end

step 'Verify unlocking <pipeline> fails as pipeline is not found' do |pipeline|
  body=begin
    response = RestClient.post http_url("/api/pipelines/#{pipeline}/unlock"),'',
        { content_type: :json, accept: 'application/vnd.go.cd.v1+json','X-GoCD-Confirm': 'true' }.merge(basic_configuration.header)

  rescue RestClient::ExceptionWithResponse => err
    p err.response.body
  end
  assert_true JSON.parse(body).to_s.include?'resource you requested was not found'
end


step 'Delete pipeline <pipeline> - Configure cruise using api' do |pipeline|
  begin
    response =   RestClient.delete http_url("/api/admin/pipelines/#{scenario_state.get(pipeline)}"),
    { content_type: :json, accept: 'application/vnd.go.cd.v6+json' }.merge(basic_configuration.header)
    assert_true response.code == 200
  rescue RestClient::ExceptionWithResponse => err
    p "Delete Pipeline call failed with response code #{err.response.code} and the response body - #{err.response.body}"
  end

end

step 'Verify unauthorized to unlock <pipeline> using access token <token_id>' do |pipeline, token_id|
	body=begin
    response = RestClient.post http_url("/api/pipelines/#{scenario_state.get(pipeline)}/unlock"),'',
        { content_type: :json, accept: 'application/vnd.go.cd.v1+json','X-GoCD-Confirm': 'true', Authorization: "Bearer #{scenario_state.get(token_id)}"}
  rescue RestClient::ExceptionWithResponse => err
    p err.response.body
  end
  assert_true JSON.parse(body).to_s.include?'You are not authorized to perform this action'
end

step 'Verify can unlock <pipeline> using access token <token_id>' do |pipeline, token_id|
	body= begin
    response = RestClient.post http_url("/api/pipelines/#{scenario_state.get(pipeline)}/unlock"),'',
        { content_type: :json, accept: 'application/vnd.go.cd.v1+json','X-GoCD-Confirm': 'true', Authorization: "Bearer #{scenario_state.get(token_id)}"}
  rescue RestClient::ExceptionWithResponse => err
    p err.response.body
  end
  assert_true JSON.parse(body).to_s.include?"Pipeline lock released for #{scenario_state.get(pipeline)}"
end
