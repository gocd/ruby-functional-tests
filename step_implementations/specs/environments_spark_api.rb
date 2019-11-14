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

require_relative '../../lib/helpers/go_url_helper.rb'

ENVIRONMENT_API_VERSION = 'application/vnd.go.cd+json'.freeze

step 'Create environment <name>' do |name|
  assert_true create_environment(name).code == 200
end

step 'Create environment <name> should return forbidden' do |name|
  begin
    create_environment(name)
    raise 'Expected create environment to fail'
  rescue RestClient::ExceptionWithResponse => e
    raise 'Response Code is not 403' unless e.response.code == 403
  end
end

step 'Update environment <environment> to add pipeline <pipeline>' do |environment, pipeline|
  assert_true update_environment(environment,  name: scenario_state.get(pipeline)).code == 200
end

step 'Update environment <environment> to add secure environment variable <var> with value as <identifier>' do |environment, var, identifier|
  assert_true update_environment(environment,  nil, nil, name: var, encrypted_value: scenario_state.get(identifier), secure: true).code == 200
end

step 'Update environment <environment> to add environment variable <var> with value as <val>' do |environment, var, val|
  assert_true update_environment(environment,  nil, nil, name: var, value: val, secure: false).code == 200
end

step 'Get environment <name> should return entity <entity> with <values>' do |name, entity, values|
  JSON.parse(get_environment(name).body)[entity].each do |e|
    h = change_to_hash(values)
    h.each do |key, value|
      assert_true e.key?(key), "Environments API response do not have expected values. Expected: key to be rpesent: #{key}"
      expected_value = scenario_state.get(value).nil? ? value : scenario_state.get(value)
      assert_true e[key].eql?(expected_value), "Environments API response do not have expected values. Expected: #{key} => #{expected_value}"
    end
  end
end

step 'Get environment <name> should return success' do |name|
  assert_true get_environment(name).code == 200
end

step 'Get environment <name> should return forbidden' do |name|
  begin
    get_environment(name)
    raise 'Expected get environment to fail'
  rescue RestClient::ExceptionWithResponse => e
    raise 'Response Code is not 403' unless e.response.code == 403
  end
end

step 'Update environment <name> should return success' do |name|
  assert_true update_environment(name).code == 200
end

step 'Update environment <name> should return forbidden' do |name|
  begin
    update_environment(name)
    raise 'Expected update environment to fail'
  rescue RestClient::ExceptionWithResponse => e
    raise 'Response Code is not 403' unless e.response.code == 403
  end
end

step 'Delete environment <name> should return success' do |name|
  assert_true delete_environment(name).code == 200
end

step 'Delete environment <name> should return forbidden' do |name|
  begin
    delete_environment(name)
    raise 'Expected delete environment to fail'
  rescue RestClient::ExceptionWithResponse => e
    raise 'Response Code is not 403' unless e.response.code == 403
  end
end

step 'Get all environments should have <envs>' do |envs|
  actual = JSON.parse(get_all_environments.body)['_embedded']['environments'].map { |env| env['name'] }.sort
  expected = envs.split(/[\s,]+/).map{|exp| scenario_state.get(exp).nil? ? exp : scenario_state.get(exp)}.sort
  assert_true (expected - actual).empty?, "Assertion failed. Expected: #{expected}, Actual: #{actual}"
end

private

def change_to_hash(str, arr_sep = ',', key_sep = ':')
  array = str.split(arr_sep)
  hash = {}

  array.each do |e|
    key_value = e.split(key_sep)
    value = key_value[1].strip
    hash[key_value[0].strip] = scenario_state.get(value).nil? ? value : scenario_state.get(value)
  end

  hash
end

def create_environment(name, pipelines = nil, agents = nil, environment_variables = nil)
  RestClient.post http_url('/api/admin/environments'), request_body(name, pipelines, agents, environment_variables),
                  { content_type: :json, accept: ENVIRONMENT_API_VERSION }
    .merge(basic_configuration.header)
end

def get_environment(name)
  RestClient.get http_url("/api/admin/environments/#{name}"),
                 { accept: ENVIRONMENT_API_VERSION }.merge(basic_configuration.header)
end

def get_all_environments
  RestClient.get http_url('/api/admin/environments'),
                 { accept: ENVIRONMENT_API_VERSION }.merge(basic_configuration.header)
end

def update_environment(name, pipelines = nil, agents = nil, environment_variables = nil)
  etag = get_environment(name).headers[:etag]
  RestClient.put http_url("/api/admin/environments/#{name}"), request_body(name, pipelines, agents, environment_variables),
                 { content_type: :json, accept: ENVIRONMENT_API_VERSION, if_match: etag }
    .merge(basic_configuration.header)
end

def delete_environment(name)
  RestClient.delete http_url("/api/admin/environments/#{name}"),
                    { content_type: :json, accept: ENVIRONMENT_API_VERSION}.merge(basic_configuration.header)
end

def request_body(name, pipelines = nil, agents = nil, environment_variables = nil)
  tmp = { name: name }
  tmp[:pipelines] = [pipelines] unless pipelines.nil?
  tmp[:agents] = [agents] unless agents.nil?
  tmp[:environment_variables] = [environment_variables] unless environment_variables.nil?
  JSON.generate(tmp)
end
