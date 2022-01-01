##########################################################################
# Copyright 2022 ThoughtWorks, Inc.
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

step 'Create cluster profile <cluster_profile_id> for docker elastic agent plugin - Using Cluster profile API' do |cluster_profile_id|
  docker_cluster_profile_request = {
    id: cluster_profile_id.to_s,
    plugin_id: 'cd.go.contrib.elastic-agent.docker',
    properties: [
      {
        key: 'go_server_url',
        value: 'https://ci.example.com/go'
      },
      {
        key: 'max_docker_containers',
        value: '30'
      },
      {
        key: 'auto_register_timeout',
        value: '10'
      },
      {
        key: 'docker_uri',
        value: 'unix:///var/run/docker.sock'
      }
    ]
  }

  create_clusterProfile(docker_cluster_profile_request)
end

step 'Create cluster profile <cluster_profile_id> for kubernetes elastic agent plugin - Using Cluster profile API' do |cluster_profile_id|
  k8s_cluster_profile_request = {
    id: cluster_profile_id.to_s,
    plugin_id: 'cd.go.contrib.elasticagent.kubernetes',
    properties: [
      {
        key: 'go_server_url',
        value: 'https://ci.example.com/go'
      },
      {
        key: 'security_token',
        value: 'test'
      },
      {
        key: 'kubernetes_cluster_url',
        value: 'http://no-cluster'
      }
    ]
  }

  create_clusterProfile(k8s_cluster_profile_request)
end

def create_clusterProfile(req_body)
  RestClient.post http_url('/api/admin/elastic/cluster_profiles'), req_body.to_json, { content_type: :json, accept: 'application/vnd.go.cd+json' }.merge(basic_configuration.header)
rescue RestClient::ExceptionWithResponse => err
  raise "Create cluster profile call failed with response code #{err.response.code} and the response body - #{err.response.body}"
end

step 'Clone Elastic agent profile <elastic_agent_profile_id> of cluster <cluster_id> by name <new_elastic_agent_profile_id>' do |elastic_agent_profile_id, cluster_id, new_elastic_agent_profile_id|
  elastic_profiles_page.clone_elastic_agent_profile(cluster_id, elastic_agent_profile_id)
  elastic_profiles_page.modal_elastic_agent_profile_id.set new_elastic_agent_profile_id
  elastic_profiles_page.save_elastic_agent_profile_modal
end

step 'Verify elastic agent profiles <elastic_agent_profiles> listed' do |elastic_agent_profiles|
  elastic_agent_profiles.split(',').each do |elastic_agent_profile|
    assert_true elastic_profiles_page.elastic_agent_profile_exist?(elastic_agent_profile.strip)
  end
end

step 'Set maximum memory limit as <memory_limit>' do |memory_limit|
  elastic_profiles_page.max_memory.set memory_limit
end

step 'Elastic agent profile save should fail with message <failure_message>' do |failure_message|
  elastic_profiles_page.save_elastic_agent_profile
  assert_true elastic_profiles_page.has_css?('span', text: failure_message)
end

step 'Verify <field> is <value> for elastic agent profile <elastic_agent_profile> - Using elastic agent profile API' do |field, value, elastic_agent_profile|
  begin
    response = RestClient.get http_url("/api/elastic/profiles/#{elastic_agent_profile}"), { accept: 'application/vnd.go.cd+json' }.merge(basic_configuration.header)
    expected_property = JSON.parse(response.body)['properties'].select { |property| property['key'].eql? field }
    assert_true expected_property.first['value'].eql? value
  rescue RestClient::ExceptionWithResponse => err
    raise "Failed to get the elastic agent profile #{elastic_agent_profile}. Returned response code - #{err.response.code}"
  end
end

step 'Delete elastic agent profile <elastic_agent_profile_id> of cluster <cluster_profile_id>' do |elastic_agent_profile_id, cluster_profile_id|
  elastic_profiles_page.delete_elastic_agent_profile(cluster_profile_id, elastic_agent_profile_id)
  elastic_profiles_page.click_confirm_delete
end

step 'Verify <count> elastic agent profiles <elastic_agent_profiles> are only returned  - Using get all elastic agent profile API' do |_count, _elastic_agent_profiles|
  begin
    response = RestClient.get http_url("/api/elastic/profiles"), { accept: 'application/vnd.go.cd+json' }.merge(basic_configuration.header)
    actual = JSON.parse(response.body)['_embedded']['profiles'].collect{|profile| profile['id']}
    expected = _elastic_agent_profiles.split(',').collect(&:strip)
    assert_true (expected - actual).empty?
  rescue RestClient::ExceptionWithResponse => err
    raise "Failed to get all the elastic agent profiles. Returned response code - #{err.response.code}"
  end
end

step 'Verify elastic agent profile operation <operation> is <state> for <ep> under cluster profile <cp>' do |operation, state, ep, cp|
  if state.eql? 'disabled'
    assert_true elastic_profiles_page.elastic_profile_operation_disabled?(cp, ep, operation), "Elastic agent operation #{operation} is not #{state}"
  else
    assert_false elastic_profiles_page.elastic_profile_operation_disabled?(cp, ep, operation), "Elastic agent operation #{operation} is not #{state}"
  end
end

step 'Verify cluster profile operation <operation> is <state> for cluster profile <cp>' do |operation, state, cp|
  if state.eql? 'disabled'
    assert_true elastic_profiles_page.cluster_profile_operation_disabled?(cp, operation), "Cluster profile operation #{operation} is not #{state}"
  else
    assert_false elastic_profiles_page.cluster_profile_operation_disabled?(cp, operation), "Cluster profile operation #{operation} is not #{state}"
  end
end
