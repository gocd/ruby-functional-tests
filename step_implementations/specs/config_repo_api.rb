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

private

def get_all_config_repos
  RestClient.get http_url(CONFIG_REPO_BASE_URL),
                 {accept: CONFIG_REPO_API_VERSION}
                     .merge(basic_configuration.header)
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

def request_body_for_repo(id, plugin_id = 'json.config.plugin', material = Context::GitMaterials.new, configuration = [])
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
      :configuration => configuration
  }
  JSON.generate(tmp)
end
