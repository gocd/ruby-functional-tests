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

  step 'Verify option  <option> is selected' do |option|
  assert_true  stage_settings_page.option_is_selected?option
  end  

  step 'Verify that the message <message> shows up - Already On Edit Stage Page' do |message|
    assert_true stage_settings_page.has_message?(message)
  end 

  step 'Select <option>' do |option|
     stage_settings_page.selecct_permission_option(option)
  end  

  step 'Set <user> as user name - On Permission tab' do |user|
    stage_settings_page.set_permission_user user
  end

  step 'Set <role> as role name - On Permission tab' do |role|
    stage_settings_page.set_permission_role role
  end

  step 'Verify that user <user> is inheritted' do |user|
    assert_true stage_settings_page.inherited_users.include?user
  end 
  step 'Verify that role <user> is inheritted' do |user|
    assert_true stage_settings_page.inherited_roles.include?user
  end 

  step 'Verify that user <user> is already added - On Permission tab' do |user|
    assert_true stage_settings_page.specified_users.include?user
  end 

  step 'Verify that role <role> is already added - On Permission tab' do |role|
    assert_true stage_settings_page.specified_roles.include?role
  end 

  step 'Verify message <message> shows up - On Permission tab' do |message|
    assert_true stage_settings_page.has_message?message
  end

  step 'Verify auto aproval type is selected' do ||
    assert_true stage_settings_page.auto_selected?
  end

  step 'Change approval type to <type>' do |type|
    stage_settings_page.set_approval_type type
  end

  step 'Open tab <tab> - On Template Page' do |tab|
    stage_settings_page.open_tab
  end
