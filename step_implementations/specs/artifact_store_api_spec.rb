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
require_relative '../../lib/helpers/go_url_helper.rb'

ARTIFACT_STORE_API_VERSION = 'application/vnd.go.cd+json'.freeze

step 'Create artifact store <artifact_store_id>' do |artifact_store_id|
  begin
    response = create(artifact_store_id)
    scenario_state.put 'api_response', response
  rescue RestClient::ExceptionWithResponse => err
    p "Create artifact store call failed with response code #{err.response.code} and the response body - #{err.response.body}"
    scenario_state.put 'api_response', err.response
  end
end

step 'Get artifact store <artifact_store_id>' do |artifact_store|
  begin
    response = get artifact_store
  rescue RestClient::ExceptionWithResponse => err
    raise "Failed to get the artifact store #{artifact_store}. Returned response code - #{err.response.code}"
  end
  assert_true JSON.parse(response.body)['id'] == artifact_store
end

step 'Get all artifact stores should return <artifact_store_ids>' do |list|
  begin
    response = RestClient.get http_url('/api/admin/artifact_stores'), {accept: ARTIFACT_STORE_API_VERSION}.merge(basic_configuration.header)
  rescue RestClient::ExceptionWithResponse => err
    raise "Failed to get all artifact stores. Returned response code - #{err.response.code}"
  end
  assert_true JSON.parse(response.body)['_embedded']['artifact_stores'].map {|t| t['id']}.sort == list.split(/[\s,]+/).sort
end

step 'Update artifact store <artifact_store_id>' do |artifact_store_id|
  begin
    update_response = update(artifact_store_id)
    scenario_state.put 'api_response', update_response
  rescue RestClient::ExceptionWithResponse => err
    p "Update artifact store call failed with response code #{err.response.code} and response body - #{err.response.body}"
    scenario_state.put 'api_response', err.response
  end
end

step 'Delete artifact store <artifact_store_id>' do |artifact_store_id|
  begin
    delete_response = delete(artifact_store_id)
    scenario_state.put 'api_response', delete_response
  rescue RestClient::ExceptionWithResponse => err
    p "Update artifact store call failed with response code #{err.response.code} and response body - #{err.response.body}"
    scenario_state.put 'api_response', err.response
  end
end

step 'Try to create artifact store <artifact_store_id>' do |artifact_store_id|
  try_api_call(method(:create), artifact_store_id)
end

step 'Try to get artifact store <artifact_store_id>' do |artifact_store_id|
  try_api_call(method(:get), artifact_store_id)
end

step 'Try to get all artifact stores' do
  try_api_call(method(:get_all))
end

step 'Try to update artifact store <artifact_store_id>' do |artifact_store_id|
  try_api_call(method(:update), artifact_store_id)
end

step 'Try to delete artifact store <artifact_store_id>' do |artifact_store_id|
  try_api_call(method(:delete), artifact_store_id)
end


private

def try_api_call(func, arg = nil)
  begin
    if arg
      response = func.call(arg)
    else
      response = func.call
    end
    scenario_state.put 'api_response', response
  rescue RestClient::ExceptionWithResponse => err
    scenario_state.put 'api_response', err.response
  end
end

def get(artifact_store_id)
  RestClient.get http_url("/api/admin/artifact_stores/#{artifact_store_id}"), {accept: ARTIFACT_STORE_API_VERSION}.merge(basic_configuration.header)
end

def get_all
  RestClient.get http_url('/api/admin/artifact_stores'), {accept: ARTIFACT_STORE_API_VERSION}.merge(basic_configuration.header)
end

def create(artifact_store_id)
  tmp = {
      :id => artifact_store_id.to_s,
      :plugin_id => "cd.go.artifact.docker.registry",
      :properties => [
          {
              key: "RegistryType",
              value: "other"
          },
          {
              key: "RegistryURL",
              value: "http://example.com"
          },
          {
              key: "Username",
              value: "username"
          },
          {
              key: "Password",
              value: "passw0rd"
          }
      ]
  }
  RestClient.post http_url('/api/admin/artifact_stores'), JSON.generate(tmp),
                  {content_type: :json, accept: ARTIFACT_STORE_API_VERSION}.merge(basic_configuration.header)
end

def update(artifact_store_id)
  tmp = {
      :id => artifact_store_id.to_s,
      :plugin_id => "cd.go.artifact.docker.registry",
      :properties => [
        {
          key: "RegistryType",
          value: "other"
      },
      {
          key: "RegistryURL",
          value: "http://example.com/updated"
      },
      {
          key: "Username",
          value: "username-new"
      },
      {
          key: "Password",
          value: "passw0rd"
      }
      ]
  }
  response = RestClient.get http_url("/api/admin/artifact_stores/#{artifact_store_id}"), {accept: ARTIFACT_STORE_API_VERSION}.merge(basic_configuration.header)

  RestClient.put http_url("/api/admin/artifact_stores/#{artifact_store_id}"), JSON.generate(tmp),
                 {content_type: :json, if_match: response.headers[:etag], accept: ARTIFACT_STORE_API_VERSION}.merge(basic_configuration.header)
end

def delete(artifact_store_id)
  response = RestClient.get http_url("/api/admin/artifact_stores/#{artifact_store_id}"), {accept: ARTIFACT_STORE_API_VERSION}.merge(basic_configuration.header)

  RestClient.delete http_url("/api/admin/artifact_stores/#{artifact_store_id}"),
                 {content_type: :json, if_match: response.headers[:etag], accept: ARTIFACT_STORE_API_VERSION}.merge(basic_configuration.header)
end
