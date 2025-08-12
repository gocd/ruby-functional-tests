##########################################################################
# Copyright 2022 Thoughtworks, Inc.
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

step 'On Elastic profiles page' do
  elastic_profiles_page.load
end

step 'Add new cluster profile' do |plugin_id|
  elastic_profiles_page.add_new_cluster_profile.click
end

step 'Set cluster profile name as <cluster_profile_id>' do |cluster_profile_id|
  elastic_profiles_page.wizard_cluster_profile_id.set(cluster_profile_id, rapid: false)
end

step 'Set plugin id as <plugin_id>' do |plugin_id|
  elastic_profiles_page.plugin_id.select plugin_id
end

step 'Set GoServer URL as <go_server_url> for cluster profile' do |go_server_url|
  elastic_profiles_page.go_server_url.set(app_base_page.interpolate_from_scenario_state(go_server_url), rapid: false)
end

step 'Set auto register timeout as <auto_register_timeout> for cluster profile' do |auto_register_timeout|
  elastic_profiles_page.auto_register_timeout.set(auto_register_timeout, rapid: false)
end

step 'Set max docker containers as <max_docker_containers>' do |max_docker_containers|
  elastic_profiles_page.max_docker_containers.set(max_docker_containers, rapid: false)
end

step 'Set environment variable as <env_variable>' do |env_variable|
  elastic_profiles_page.env_variable.set(env_variable, rapid: false)
end

step 'Set docker URI as <docker_uri> for cluster profile' do |docker_uri|
  elastic_profiles_page.docker_uri.set(docker_uri, rapid: false)
end

step 'Expand cluster profile <id>' do |id|
  elastic_profiles_page.expand_cluster_profile_header(id)
end

step 'Save cluster profile' do
  elastic_profiles_page.save_cluster_profile_and_exit
end

step 'Add new Elastic agent profile for cluster id <cluster_profile_id>' do |cluster_profile_id|
  elastic_profiles_page.add_elastic_agent_profile(cluster_profile_id)
end

step 'Set agent profile name as <elastic_agent_profile_name>' do |elastic_agent_profile_name|
  elastic_profiles_page.wizard_elastic_agent_profile_id.set(elastic_agent_profile_name, rapid: false)
end

step 'Go back to Cluster Profiles step on the wizard' do
  elastic_profiles_page.click_previous_button_on_wizard
end

step 'Go forward to Elastic Profiles step on the wizard' do
  elastic_profiles_page.click_next_button_on_wizard
end

step 'Check cluster id is selected as <cluster_profile_id> with plugin <plugin_name>' do |cluster_profile_id, plugin_name|
  assert_true elastic_profiles_page.has_selected_cluster_profile_id?(cluster_profile_id, plugin_name)
end

step 'Set docker image as <image>' do |image|
  elastic_profiles_page.image.set(image, rapid: false)
end

step 'Save elastic agent profile' do
  elastic_profiles_page.save_elastic_agent_profile
end

step 'Edit cluster profile <cluster_profile_id>' do |cluster_profile_id|
  elastic_profiles_page.edit_cluster_profile(cluster_profile_id)
end

step 'Verify <field> for <cluster_profile> as <value> - Using cluster profile API' do |field, cluster_profile, value|
  begin
    response = RestClient.get http_url("/api/admin/elastic/cluster_profiles/#{cluster_profile}"), { accept: 'application/vnd.go.cd+json' }.merge(basic_configuration.header)
    expected_property = JSON.parse(response.body)['properties'].select{|property| property['key'].eql? field}
    assert_true expected_property.first['value'].eql? value
  rescue RestClient::ExceptionWithResponse => err
    p "Failed to get the cluster profile #{cluster_profile}. Returned response code - #{err.response.code}"
    return err.response.code
  end
end

step 'Delete cluster profile <cluster_profile_id> should fail with error <display_message>' do |cluster_profile_id, display_message|
  elastic_profiles_page.delete_cluster_profile(cluster_profile_id)
  elastic_profiles_page.click_confirm_delete
  assert_true elastic_profiles_page.banner_message.eql? display_message
end

step 'Clone cluster profile <cluster_profile_id> by name <new_cluster_profile_id>' do |cluster_profile_id, new_cluster_profile_id|
  elastic_profiles_page.clone_cluster_profile(cluster_profile_id)
  elastic_profiles_page.modal_cluster_profile_id.set(new_cluster_profile_id, rapid: false)
  elastic_profiles_page.save_cluster_profile
end

step 'Clusters <cluster_profiles> should be listed on the SPA' do |cluster_profiles|
  cluster_profiles.split(',').each do |cluster_profile|
    assert_true elastic_profiles_page.cluster_profiles_exists?(cluster_profile.strip)
  end
end

step 'Edit elastic agent profile <elastic_agent_profile_id> of cluster profile <cluster_profile_id>' do |elastic_agent_profile_id, cluster_profile_id|
  elastic_profiles_page.edit_elastic_agent_profile(cluster_profile_id, elastic_agent_profile_id)
end

step 'Select cluster as <cluster_profile_id>' do |cluster_profile_id|
  elastic_profiles_page.selected_cluster_profile_id.select cluster_profile_id
end

step 'Select Configuration properties for kubernetes cluster' do |_tmp|
	elastic_profiles_page.k8s_config_properties.click
end

step 'Verify error message for create cluster profile <err>' do |err|
	assert_true elastic_profiles_page.error_message.include? err
end
