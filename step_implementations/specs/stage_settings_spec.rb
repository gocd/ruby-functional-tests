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
##########################################################################

step 'On Stage settings page of pipeline <pipeline_name> stage <stage_name>' do |pipeline_name, stage_name|
    stage_settings_page.load(pipeline_name: scenario_state.get(pipeline_name), stage_name: stage_name)
  end
  
  step 'Open <tab_id> tab - On Stage settings page' do |tab_id|
    stage_settings_page.on_tab(tab_id)
  end

  step 'Set stage as <stage> - On Stage settings page' do |stage|
    stage_settings_page.stage_name.set stage
  end

  step 'Verify that stage is named <stage_name>' do |stage_name|
    assert_true stage_settings_page.stage_name.value.include?stage_name
  end  
  
  step 'Verify job <job> with resources as <resources> and run on all as <run_on_all>' do |job,resources,run_on_all|
    assert_equal resources, stage_settings_page.job_resources(job)
    assert_equal run_on_all, stage_settings_page.run_on_all(job)
  end

  step 'Open job <job>' do |job|
    stage_settings_page.open_job job
  end  

  step 'Delete job <job>' do |job|
    stage_settings_page.delete_job job
  end

  step 'Verify <job> job is present' do |job|
    assert_true stage_settings_page.job_present?job
  end 
  
  step 'Verify <job> job is not present' do |job|
    assert_false stage_settings_page.job_present?job
  end 

