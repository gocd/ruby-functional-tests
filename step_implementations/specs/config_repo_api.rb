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

CONFIG_REPO_API_VERSION = 'application/vnd.go.cd+json'.freeze
CONFIG_REPO_BASE_URL    = '/api/admin/config_repos'.freeze

step 'Create config repo <id>' do |id|
  assert_true create_config_repo(id).code == 200
end

step 'Create config repo <id> should return forbidden' do |id|
  begin
    create_config_repo(id)
    raise 'Expected create config_repo to fail'
  rescue RestClient::ExceptionWithResponse => e
    raise 'Response Code is not 403' unless e.response.code == 403
  end
end

step 'Get config repo <id> should return success' do |id|
  assert_true get_config_repo(id).code == 200
end

step 'Get config repo <id> should return forbidden' do |id|
  begin
    get_config_repo(id)
    raise 'Expected get config_repo to fail'
  rescue RestClient::ExceptionWithResponse => e
    raise 'Response Code is not 403' unless e.response.code == 403
  end
end

step 'Get all config repos should have <repos>' do |repos|
  actual   = JSON.parse(get_all_config_repos.body)['_embedded']['config_repos'].map {|cr| cr['id']}.sort
  expected = repos.split(/[\s,]+/).map {|exp| scenario_state.get(exp).nil? ? exp : scenario_state.get(exp)}.sort
  assert_true (expected - actual).empty?, "Assertion failed. Expected: #{expected}, Actual: #{actual}"
end

step 'Get all config repos should not have <repos>' do |repos|
  actual   = JSON.parse(get_all_config_repos.body)['_embedded']['config_repos'].map {|cr| cr['id']}.sort
  expected = repos.split(/[\s,]+/).map {|exp| scenario_state.get(exp).nil? ? exp : scenario_state.get(exp)}.sort
  assert_true actual.none? {|n| expected.include?(n)}, "Assertion failed. Expected: #{expected} not to be in: #{actual}"
end

step 'Update config repo <id> should return success' do |id|
  assert_true update_config_repo(id).code == 200
end

step 'Update config repo <id> should return forbidden' do |id|
  begin
    update_config_repo(id)
    raise 'Expected update config repo to fail'
  rescue RestClient::ExceptionWithResponse => e
    raise 'Response Code is not 403' unless e.response.code == 403
  end
end

step 'Delete config repo <id> should return success' do |id|
  assert_true delete_config_repo(id).code == 200
end

step 'Delete config repo <id> should return forbidden' do |id|
  begin
    delete_config_repo(id)
    raise 'Expected delete config repo to fail'
  rescue RestClient::ExceptionWithResponse => e
    raise 'Response Code is not 403' unless e.response.code == 403
  end
end

step 'Get status of config repo <id> should return success' do |id|
  response = get_status(id)
	assert_equal response.code, 200, "Failed to get config repo status. Response code #{response.code}, body #{response.body}"
end

step 'Get definition of config repo <id> should return success' do |id|
	response = get_definitions(id)
	assert_equal response.code, 200, "Failed to get config repo defenition. Response code #{response.code}, body #{response.body}"
end

step 'Trigger update of config repo <id> should return success' do |id|
	response = trigger_update(id)
	assert_equal response.code, 201, "Failed to trigger update. Response code #{response.code}, body #{response.body}"
end

step 'Create config repo <id> with rules <rules>' do |id, rules|
  assert_true create_config_repo_with_rules(id, rules).code == 200
end

step 'Get config repo <id> should contain rules <rules>' do |id, rules|
  result = get_config_repo(id)
  assert_true result.code == 200
  actual   = JSON.parse(result)["rules"]
  expected = extract_rules(rules).map {|item| item.transform_keys(&:to_s)}
  assert_true difference(expected, actual).empty?, "Assertion failed. Expected: #{expected}, Actual: #{actual}"
end

step 'Update config repo <id> with rules <rules>' do |id, rules|
  assert_true update_config_repo_with_rules(id, rules).code == 200
end

private

def get_all_config_repos
  RestClient.get http_url(CONFIG_REPO_BASE_URL),
                 {accept: CONFIG_REPO_API_VERSION}
                     .merge(basic_configuration.header)
end

def get_status(id)
  RestClient.get http_url("#{CONFIG_REPO_BASE_URL}/#{id}/status"),
                                    { accept: CONFIG_REPO_API_VERSION }
                                      .merge(basic_configuration.header)   do |response, _request, _result|
		response
  end
end

def get_definitions(id)
  RestClient.get http_url("#{CONFIG_REPO_BASE_URL}/#{id}/definitions"),
                                    { accept: CONFIG_REPO_API_VERSION }
                                      .merge(basic_configuration.header)   do |response, _request, _result|
		response
  end
end

def trigger_update(id)
  RestClient.post http_url("#{CONFIG_REPO_BASE_URL}/#{id}/trigger_update"), '',
                                    { accept: CONFIG_REPO_API_VERSION, 'X-GoCD-Confirm': true }
                                      .merge(basic_configuration.header)   do |response, _request, _result|
		response
  end
end

def get_config_repo(id)
  RestClient.get http_url("#{CONFIG_REPO_BASE_URL}/#{id}"),
                 {accept: CONFIG_REPO_API_VERSION}
                     .merge(basic_configuration.header)
end

def create_config_repo(id)
  RestClient.post http_url(CONFIG_REPO_BASE_URL),
                  request_body_for_repo(id),
                  {content_type: :json, accept: CONFIG_REPO_API_VERSION}
                      .merge(basic_configuration.header)
end

def create_config_repo_with_rules(id, rules)
  RestClient.post http_url(CONFIG_REPO_BASE_URL),
                  request_body_for_repo(id, 'json.config.plugin', Context::GitMaterials.new, [], extract_rules(rules)),
                  {content_type: :json, accept: CONFIG_REPO_API_VERSION}
                      .merge(basic_configuration.header)
end

def delete_config_repo(id)
  RestClient.delete http_url("#{CONFIG_REPO_BASE_URL}/#{id}"),
                    {accept: CONFIG_REPO_API_VERSION}
                        .merge(basic_configuration.header)
end

def update_config_repo(id)
  etag = get_config_repo(id).headers[:etag]
  RestClient.put http_url("#{CONFIG_REPO_BASE_URL}/#{id}"),
                 request_body_for_repo(id),
                 {content_type: :json, accept: CONFIG_REPO_API_VERSION, if_match: etag}
                     .merge(basic_configuration.header)
end

def update_config_repo_with_rules(id, rules)
  etag = get_config_repo(id).headers[:etag]
  RestClient.put http_url("#{CONFIG_REPO_BASE_URL}/#{id}"),
                 request_body_for_repo(id, 'json.config.plugin', Context::GitMaterials.new, [], extract_rules(rules)),
                 {content_type: :json, accept: CONFIG_REPO_API_VERSION, if_match: etag}
                     .merge(basic_configuration.header)
end

def request_body_for_repo(id, plugin_id = 'json.config.plugin', material = Context::GitMaterials.new, configuration = [], rules = [])
  tmp = {
      :id            => id,
      :plugin_id     => plugin_id,
      :material      => {
          :type       => "git",
          :attributes => {
              :url         => material.path,
              :branch      => "master",
              :auto_update => true
          }
      },
      :configuration => configuration,
      :rules         => rules
  }
  JSON.generate(tmp)
end

def extract_rules(rules)
  rules.split(',').collect(&:strip).collect do |rule|
    rule_entities = rule.split(':').collect(&:strip)
    {directive: (rule_entities[0]).to_s, action: 'refer', type: (rule_entities[1]).to_s, resource: (rule_entities[2]).to_s}
  end
end

def difference(arr1, arr2)
  (arr1 + arr2) - (arr1 & arr2)
end
