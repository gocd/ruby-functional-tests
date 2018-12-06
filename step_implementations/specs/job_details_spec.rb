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
step 'On Job details page of pipeline <pipeline_name> counter <counter> stage <stage_name> counter <counter> job <job_name>' do |pipeline_name, pipeline_counter, stage_name, stage_counter, job_name|
  job_details_page.load(pipeline_name: scenario_state.get(pipeline_name), pipeline_counter: pipeline_counter, stage_name: stage_name, stage_counter: stage_counter, job_name: job_name)
end

step 'Open <tab_id> tab - On Job details page' do |tab_id|
  job_details_page.on_tab(tab_id)
end

step 'Verify console log contains message <message>' do |message|
  assert_true job_details_page.console_content.include? message
end

step 'Verify console log does not contains message <message>' do |message|
  assert_false job_details_page.console_content.include? message
end

step 'Store the job completed time stamp' do
  job_url = job_details_page.current_path.match(/\/detail.*/)[0].downcase
  scenario_state.put job_url, job_details_page.job_completed_time.text
end

step 'Verify the job completed time stamp for job <job> of stage <stage> of pipeline <pipeline> with label <label> is Different for stage counter <counter1> and stage counter <counter2>' do |job, stage, pipeline, label, counter1, counter2|
  rerun1 = "/detail/#{scenario_state.get(pipeline)}/#{label}/#{stage}/#{counter1}/#{job}"
  rerun2 = "/detail/#{scenario_state.get(pipeline)}/#{label}/#{stage}/#{counter2}/#{job}"
  stagererun1 = scenario_state.get rerun1.downcase
  stagererun2 = scenario_state.get rerun2.downcase
  assert_not_equal stagererun1, stagererun2
end
