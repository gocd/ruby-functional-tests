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
step 'Get plugins info for plugin <plugin_id>' do |plugin_id|
  res = RestClient.get http_url("/api/admin/plugin_info/#{plugin_id}"),
                       { accept: GoConstants::PLUGIN_INFO_API_VERSION }.merge(basic_configuration.header)
  assert_true res.code == 200
  scenario_state.put 'plugins_info_response', res.body
end

step 'Plugin info response should have <entity> of <key> value <value>' do |entity, key, value|
  response = scenario_state.get 'plugins_info_response'
  assert_true JSON.parse(response)[entity].first[key].eql? value
end

step 'Plugin info response should have <entity> with <key>' do |entity, key|
  response = scenario_state.get 'plugins_info_response'
  assert_true JSON.parse(response)[entity].first.key?(key)
end

step 'Get all plugins info should return info for <plugins_count> valid plugins' do |plugins_count|
  res = RestClient.get http_url('/api/admin/plugin_info'),
                       { accept: GoConstants::PLUGIN_INFO_API_VERSION }.merge(basic_configuration.header)
  actual_size = JSON.parse(res.body)['_embedded']['plugin_info'].size
  assert_true (actual_size == plugins_count.to_i), "Actual number of plugins #{actual_size}"
end
