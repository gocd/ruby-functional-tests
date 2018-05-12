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

require 'representers/template'
include Representers
include Helpers::GoUrlHelper

TEMPLATE_API_VERSION = 'application/vnd.go.cd.v3+json'.freeze

step 'Create template <template>' do |template|
  tmp = Representers::Template.new(name: template.to_s,
                                   stages: [Stage.new(name: 'Stage1',
                                                      jobs: [Job.new(name: 'Job1',
                                                                     tasks: [Task.new(name: 'Task1', attributes: Attributes.new)])])])
  begin
    response = RestClient.post http_url('/api/admin/templates'), Representers::TemplateRepresenter.new(tmp).to_json,
                               { content_type: :json, accept: TEMPLATE_API_VERSION }.merge(basic_configuration.header)
    scenario_state.add_api_response response
  rescue RestClient::ExceptionWithResponse => err
    scenario_state.add_api_response err.response
  end
end

step 'Get template <template>' do |template|
  begin
    response = RestClient.get http_url("/api/admin/templates/#{template}"), { accept: TEMPLATE_API_VERSION }.merge(basic_configuration.header)
  rescue RestClient::ExceptionWithResponse => err
    raise "Failed to get the template #{tempalte}. Returned response code - #{err.response.code}"
  end
  assert_true JSON.parse(response.body)['name'] == template
end

step 'Get all templates should return templates <template-list>' do |list|
  begin
    response = RestClient.get http_url('/api/admin/templates'), { accept: TEMPLATE_API_VERSION }.merge(basic_configuration.header)
  rescue RestClient::ExceptionWithResponse => err
    raise "Failed to get all templates. Returned response code - #{err.response.code}"
  end
  assert_true JSON.parse(response.body)['_embedded']['templates'].map { |t| t['name'] }.sort == list.split(/[\s,]+/).sort
end

step 'Update template <template>' do |template|
  tmp = Representers::Template.new(name: template.to_s,
                                   stages: [Stage.new(name: 'updated-stage-name',
                                                      jobs: [Job.new(name: 'updated-job-name',
                                                                     tasks: [Task.new(name: 'updated-task-name', attributes: Attributes.new)])])])
  begin
    response = RestClient.get http_url("/api/admin/templates/#{template}"), { accept: TEMPLATE_API_VERSION }.merge(basic_configuration.header)
    update_response = RestClient.put http_url("/api/admin/templates/#{template}"), Representers::TemplateRepresenter.new(tmp).to_json,
                                     { content_type: :json, if_match: response.headers[:etag], accept: TEMPLATE_API_VERSION }.merge(basic_configuration.header)
    scenario_state.add_api_response update_response
  rescue RestClient::ExceptionWithResponse => err
    scenario_state.add_api_response err.response
  end
end

step 'Verify returned <response> response code' do |expected_code|
  assert_true scenario_state.api_response.code == expected_code.to_i
end
