##########################################################################
# Copyright 2018 ThoughtWorks, Inc.
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
#########################################################################

step 'Navigate to global analytics page' do |_tmp|
  global_analytics_page.load
end

step 'Verify pipeline <name> is shown on top of pipelines waiting longest for agents' do |pipeline_name|
	assert_true global_analytics_page.pipeline_with_highest_wait_time.casecmp(scenario_state.actual_pipeline_name(pipeline_name)).zero?
end

step 'Configure analytics plugin' do ||
	basic_configuration.create_plugin_settings(JSON.parse(File.read('resources/analytics_plugin_settings.json')))
end

step 'Drill down to job waiting and job duration graphs' do ||
	assert_true global_analytics_page.drilldown_to_job_with_highest_wait_time.casecmp('Jobs with the Highest Wait Time (Average over the last 7 days)').zero?
	assert_true global_analytics_page.drilldown_to_job_build_time.casecmp('Job Build Time').zero?
end

step 'Drill down to job which waited longest for the agent' do ||
	assert_true global_analytics_page.drilldown_to_job_waited_longest_for_agent.include?('Jobs with the Highest Wait Time on Agent')
end

step 'Visit pipeline tab - On Global analytics page' do ||
	global_analytics_page.visit_pipelines_tab
end

step 'Verify pipelines <pipelines> are listed' do |pipelines|
	pipelines.split(',').map(&:strip).each{|pipeline| 
		assert_true global_analytics_page.pipeline_listed pipeline
	}
end

step 'Selecting pipeline <pipeline> should show pipeline build analytics' do |pipeline|
	global_analytics_page.pipeline_build_time_visible_on_selection scenario_state.actual_pipeline_name(pipeline)
end