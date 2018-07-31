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
  job_details_page.load(pipeline_name: scenario_state.actual_pipeline_name(pipeline_name), pipeline_counter: pipeline_counter, stage_name: stage_name, stage_counter: stage_counter, job_name: job_name)
end

step 'Open <tab_id> tab - On Job details page' do |tab_id|
  job_details_page.on_tab(tab_id)
end

step 'Verify console log contains message <message>' do |message|
  assert_true job_details_page.console_content.include? message
end

