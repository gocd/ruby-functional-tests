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

step 'Create cluster profile <cluster_profile_id> for docker elastic agent plugin - Using Cluster profile API' do |cluster_profile_id|
    docker_cluster_profile_request = %({
        "id": "#{cluster_profile_id}",
        "plugin_id": "cd.go.contrib.elastic-agent.docker",
        "properties": [
          {
            "key": "GoServerUrl",
            "value": "https://ci.example.com/go"
          },
          {
            "key": "maxDockerContainers",
            "value": "30"
          },
          {
             "key": "autoRegisterTimeout",
             "value": "10"
          },
          {
             "key": "dockerUri",
             "value": "unix:///var/run/docker.sock"
          }
        ]
      })

    create_clusterProfile(docker_cluster_profile_request)
end

step 'Create cluster profile <cluster_profile_id> for kubernetes elastic agent plugin - Using Cluster profile API' do |cluster_profile_id|
  k8s_cluster_profile_request = %({
        "id": "#{cluster_profile_id}",
        "plugin_id": "cd.go.contrib.elasticagent.kubernetes",
        "properties": [
          {
            "key": "GoServerUrl",
            "value": "https://ci.example.com/go"
          }
        ]
      })

  create_clusterProfile(k8s_cluster_profile_request)
end

def create_clusterProfile(req_body)
  begin
    RestClient.post http_url("/api/admin/elastic/cluster_profiles"), req_body.to_json, { content_type: :json, accept: 'application/vnd.go.cd.v1+json' }.merge(basic_configuration.header)
  rescue RestClient::ExceptionWithResponse => err
    raise "Create cluster profile call failed with response code #{err.response.code} and the response body - #{err.response.body}"
  end
end

step 'Clone Elastic agent profile <elastic_agent_profile_id> by name <new_elastic_agent_profile_id>' do |elastic_agent_profile_id, new_elastic_agent_profile_id|
  elastic_agent_profiles_CRUD_operations_page.clone_elastic_agent_profile(elastic_agent_profile_id)
  elastic_agent_profiles_CRUD_operations_page.elastic_agent_profile_id.set new_elastic_agent_profile_id
  elastic_agent_profiles_CRUD_operations_page.save_elastic_agent_profile
end

step 'Verify elastic agent profiles <elastic_agent_profiles> listed' do |elastic_agent_profiles|
  elastic_agent_profiles.split(',').each do |elastic_agent_profile|
    assert_true elastic_agent_profiles_CRUD_operations_page.elastic_agent_profile_exists?(elastic_agent_profile.strip)
  end
end

step 'Set maximum memory limit as <memory_limit>' do |memory_limit|
  elastic_agent_profiles_CRUD_operations_page.max_memory.set memory_limit
end

step 'Elastic agent profile save should fail with message <failure_message>' do |failure_message|

end

step 'Verify <field> is <value> for elastic agent profile <elastic_agent_profile> - Using elastic agent profile API' do |field, value, elastic_agent_profile|
  begin
    response = RestClient.get http_url("/api/elastic/profiles/#{elastic_agent_profile}"), { accept: 'application/vnd.go.cd.v2+json' }.merge(basic_configuration.header)
    expected_property = JSON.parse(response.body)['properties'].select{|property| property['key'].eql? field}
    assert_true expected_property.first['value'].eql? value
  rescue RestClient::ExceptionWithResponse => err
    p "Failed to get the elastic agent profile #{elastic_agent_profile}. Returned response code - #{err.response.code}"
    return err.response.code
  end
end

step 'Delete elastic agent profile <elastic_agent_profile_id>' do |elastic_agent_profile_id|
  elastic_agent_profiles_CRUD_operations_page.delete_elastic_agent_profile(elastic_agent_profile_id)
  elastic_agent_profiles_CRUD_operations_page.click_confirm_delete
end

step 'Verify <count> elastic agent profiles <elastic_agent_profiles> are only returned  - Using get all elastic agent profile API' do |count, elastic_agent_profiles|
  p foo
end
