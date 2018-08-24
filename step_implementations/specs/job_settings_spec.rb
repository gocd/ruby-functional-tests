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

step 'On Job settings page of pipeline <pipeline_name> stage <stage_name> job <job_name>' do |pipeline_name, stage_name, job_name|
  job_settings_page.load(pipeline_name: scenario_state.actual_pipeline_name(pipeline_name), stage_name: stage_name, job_name: job_name)
end

step 'Open <tab_id> tab - On Job settings page' do |tab_id|
  job_settings_page.on_tab(tab_id)
end

step 'Add artifact of type <type>' do |type|
  job_settings_page.publish_artifact_type.select type
  job_settings_page.add_artifact.click
end

step 'Start creating external artifact with values <key_value>' do |key_value|
  key_value.split(',').each do |field|
    publish_artifacts_view.fill_form(field)
  end
end

step 'Save external artifact with values <key_value>' do |key_value|
  key_value.split(',').each do |field|
    publish_artifacts_view.fill_form(field)
  end
  publish_artifacts_view.save_publish_artifacts.click
end

step 'Add task <task_name>' do |task|
  job_settings_page.add_new_task.click
  job_settings_page.add_new_task_of_type task
end

step 'Select artifact type <a_type> pipeline <p_name> stage <s_name> job <j_name> artifact id <a_id> path <path>' do |a_type, p_name, s_name, j_name, a_id, path|
  job_settings_page.external_artifact.click
  job_settings_page.task_pipeline.set scenario_state.actual_pipeline_name(p_name)
  job_settings_page.task_stage.set s_name
  job_settings_page.task_job.set j_name
  job_settings_page.task_artifactId.set a_id
  job_settings_page.task_configuration_path.set path
end

step 'Save task details' do
  job_settings_page.task_save.click
end

step 'Set target to <target> with working directory <working_directory>' do |target,working_directory|
  job_settings_page.configure_rake_task(target,working_directory)
end