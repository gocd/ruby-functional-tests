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

NOTIFICATION_FILTER_VERSION = 'application/vnd.go.cd+json'.freeze
step 'Create notification filter for pipeline <pipeline> stage <stage> event <event> and match commit <match_commit>' do |pipeline, stage, event, match_commit|
	payload = {
		"pipeline": scenario_state.get(pipeline),
		"stage": stage,
		"event": event,
		"match_commits": match_commit.casecmp('true') ? true : false
	  }
	begin
		response = RestClient.post http_url('/api/notification_filters'), payload.to_json,
			{ content_type: :json, accept: NOTIFICATION_FILTER_VERSION }.merge(basic_configuration.header)
		scenario_state.put 'api_response', response
	rescue RestClient::ExceptionWithResponse => err
		scenario_state.put 'api_response', err.response
	end
end

step 'Get notification filter <id>' do |id|
	get_filter(id)
end

step 'Verify notification filter is set for pipeline <pipeline> stage <stage> event <event> and match commit <match_commit>' do |pipeline, stage, event, match_commit|
	response  = JSON.parse(scenario_state.get('api_response').body)
	assert_equal response['pipeline'], scenario_state.get(pipeline)
	assert_equal response['stage'], stage
	assert_equal response['event'], event
	assert_equal response['match_commits'], match_commit.casecmp('true') ? true : false
end

step 'List all notification filter should show <idss_list> filters' do |idss_list|
	expected_filters  = idss_list.split(/[\s,]+/).map {|id| id.to_i}
	actual_filters = JSON.parse(list_all_filters.body)['_embedded']['filters'].map {|filters| filters['id']}
	assert_equal actual_filters.sort, expected_filters.sort, "Response did not have expected list of filters. Actual Filters #{actual_filters}"
end

step 'Update notification filter <id> by changing the <param> to <value>' do |id, param, value|
	hash = JSON.parse(get_filter(id).body)
	hash[param] = value
	begin
		RestClient.patch http_url("/api/notification_filters/#{id}"), hash.to_json,
			{ content_type: :json, accept: NOTIFICATION_FILTER_VERSION }.merge(basic_configuration.header)
	rescue RestClient::ExceptionWithResponse => err
		raise "Update notification filter failed with response #{err.response}"
	end
end


def get_filter(id)
	RestClient.get http_url("/api/notification_filters/#{id}"), { accept: NOTIFICATION_FILTER_VERSION }.merge(basic_configuration.header)   do |response, _request, _result|
		scenario_state.put 'api_response', response
		response
	end
end

def list_all_filters
	RestClient.get http_url("/api/notification_filters"), { accept: NOTIFICATION_FILTER_VERSION }.merge(basic_configuration.header)  do |response, _request, _result|
		raise "Failed to list all Notification Filters. Returned response code - #{err.response.code}" unless response.code == 200
		scenario_state.put 'api_response', response
		response
	end
end

step 'Delete notification filter <id>' do |id|
	RestClient.delete http_url("/api/notification_filters/#{id}"), { accept: NOTIFICATION_FILTER_VERSION }.merge(basic_configuration.header)  do |response, _request, _result|
		raise "Failed to delete Notification Filter #{id}. Returned response code - #{response.code}" unless response.code == 200
		scenario_state.put 'api_response', response
	end
end
