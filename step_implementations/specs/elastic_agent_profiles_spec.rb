
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

step 'On Elastic agent profiles page' do
  elastic_agents_profiles_page.load
end

step 'Add new profile for plugin <plugin_id>' do |plugin_id|
  elastic_agents_profiles_page.add_new_profile.click
  elastic_agents_profiles_page.plugin_id.select plugin_id
end

step 'Set profile name as <profile_name>' do |profile_name|
  elastic_agents_profiles_page.input_profile_name.set profile_name
end

step 'Set image as <image>' do |image|
  elastic_agents_profiles_page.image.set image
end

step 'Save the elastic agent profile' do
  elastic_agents_profiles_page.finish_btn.click
end

step 'Verify profile <profile_name> listed' do |profile_name|
  assert_true elastic_agents_profiles_page.profile_displayed? profile_name
end

step 'Edit elastic agent profile <name>' do |name|
  elastic_agents_profiles_page.edit_profile name
end

step 'Update image as <image>' do |image|
  elastic_agents_profiles_page.image.set image
end

step 'Verify elastic profile <name> has key <key> value <expected_value> - Using elastic agent profiles API' do |name, key, expected_value|
  res = RestClient.get http_url("/api/elastic/profiles/#{name}"),
                       { accept: GoConstants::ELASTIC_AGENTS_PROFILE_API_VERSION }.merge(basic_configuration.header)
  actual_value = JSON.parse(res.body)['properties'].select { |property| property['key'].eql? key }.first['value']
  assert_true expected_value.eql?(actual_value), "Actual value is - #{actual_value}"
end
