##########################################################################
# Copyright 2019 ThoughtWorks, Inc.
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

PIPELINE_API_VERSION = 'application/vnd.go.cd.v7+json'.freeze

step 'Update pipeline <pipeline> stage <stage_name> job <job_name> with elastic profile id <ea_profile> - Using pipeline config API' do |pipeline, stage_name, job_name, ea_profile|
  response = get_pipeline(scenario_state.get(pipeline))
  res = JSON.parse(response.body)
  stage = res['stages'].select { |stage| stage['name'].eql? stage_name }
  job = stage[0]['jobs'].select { |job| job['name'].eql? 'defaultJob' }
  job[0]['elastic_profile_id'] = ea_profile
  stage[0]['jobs'] = job
  res['stages'] = stage
  update_pipeline(scenario_state.get(pipeline), res.to_json, response.headers[:etag])
end

def get_pipeline(pipeline)
  RestClient.get http_url("/api/admin/pipelines/#{pipeline}"), { accept: PIPELINE_API_VERSION }.merge(basic_configuration.header)
end

def update_pipeline(name, req_body, etag)
  RestClient.put http_url("/api/admin/pipelines/#{name}"), req_body,
                 { content_type: :json, if_match: etag, accept: PIPELINE_API_VERSION }.merge(basic_configuration.header)
end
