##########################################################################
# Copyright 2016 ThoughtWorks, Inc.
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

USAGE_DATA_API_VERSION = 'application/vnd.go.cd.v1+json'.freeze

step 'On Data Sharing SPA' do |_count|
  data_sharing_spa_page.load
end

step 'Toggle data sharing' do
  data_sharing_spa_page.toggle_data_sharing
end

step 'Save the permissions' do
  data_sharing_spa_page.save
end

step 'Reset the permissions' do
  data_sharing_spa_page.reset
end

step 'Verify data that will be shared is visible' do
  begin
    response = RestClient.get http_url("/api/internal/data_sharing/usagedata"), { accept: USAGE_DATA_API_VERSION }.merge(basic_configuration.header)
  rescue RestClient::ExceptionWithResponse => err
    raise "Failed to get the data sharing usagedata information. Returned response code - #{err.response.code}"
  end

  verify_usage_data_displayed_info(response, data_sharing_spa_page.get_data_that_will_be_shared)
end

step 'Verify data sharing permissions are updated by <user> user' do |user|
  msg ="#{user} changed the data sharing permission"
  assert_true data_sharing_spa_page.get_updated_by_message.include? msg
end

step 'Verify data sharing consent is <isAllowed>' do |isAllowed|
  if isAllowed.eql? 'allowed'
    assert_equal true, data_sharing_spa_page.is_data_sharing_allowed, "Expected data sharing consent to be allowed"
  else
    assert_equal false, data_sharing_spa_page.is_data_sharing_allowed, "Expected data sharing consent to be not allowed"
  end
end

def verify_usage_data_displayed_info(response, displayed_info)
   response_body = response.body
   expected = JSON.parse(response_body)['_embedded']
   actual = JSON.parse(displayed_info)

   assert_equal expected, actual, "Expected data being shared to be visible. Original_Data: #{expected}. Displayed_Data: #{actual}"
end
