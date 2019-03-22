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
  job_details_page.console_has_message?(message)
end

step 'Verify console has environment variable <variable> set to value <count>' do |variable, count|
  begin
    job_details_page.console_has_message?("setting environment variable '#{variable}' to value '#{count}'")
  rescue StandardError => e
    job_details_page.console_has_message?("overriding environment variable '#{variable}' with value '#{count}'")
  end
end

step "Verify console shows <rev> commit for material <material> for <pipeline>" do |rev,material,pipeline|
  revision=Context::GitMaterials.new(basic_configuration.material_url_for(scenario_state.get(pipeline))).nth_revision rev.delete('^0-9').to_i
  begin
    job_details_page.console_has_message?("setting environment variable 'GO_REVISION_#{material.upcase}' to value '#{revision}'")
  rescue StandardError => e
    job_details_page.console_has_message?("overriding environment variable 'GO_REVISION_#{material.upcase}' with value '#{revision}'")
  end
end

step 'Verify console log contains pipeline <pipeline> with <message>' do |pipeline, message|
  assert_true job_details_page.console_content.include? "#{scenario_state.get(pipeline)}/#{message}"
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

step 'Verify rerun button is enabled' do
  job_details_page.rerun_button_is_enabled?
end

step 'Verify rerun button is disabled' do
  assert_false job_details_page.rerun_button_is_disabled?
end

step 'Rerun <jobs> jobs' do |jobs|
  jobs.split(',').each do |job|
    job_details_page.select_jobs(job)
  end
  job_details_page.rerun_seleced.click
end

step 'Verify looking at <stage> having counter <counter>' do |stage, counter|
  assert_true stage_details_page.current_path.include? "#{stage}/#{counter}"
end

step 'Verify job <job> has state <state> and result <status>' do |job, state, status|
  job_details_page.job_has_state?(job, state)
  job_details_page.job_has_status?(job, status)
end

step 'Verify breadcrumb contains stage run <stage>' do |stage|
  assert_equal stage, job_details_page.breadcrumb_stage.text
end

step 'Verify displaying job <value>' do |value|
  assert_true job_details_page.job_has_current_value?(value)
end

step 'Verify historical job <value> is not a copy' do |value|
  assert_false job_details_page.job_is_not_copied_job?(value)
end

step 'Verify properties tab shows value <value> for property <property>' do |value, property|
  assert_equal value, job_details_page.get_value_of_property(property)
end

step 'Remove job <job> from stage <stage> in pipeline <pipeline>' do |job, stage, pipeline|
  basic_configuration.remove_job_from_stage(job, stage, pipeline)
end

step 'Verify rerun failed with cause <message>' do |message|
  assert_equal message, job_details_page.job_rerun_failed_message(message)
end

step 'Set run instance count to <count> for job <job> in pipeline <pipeline>' do |count, job, pipeline|
  basic_configuration.set_run_instance_count_for_job(count, job, pipeline)
end

step 'Verify breadcrumb contains pipeline <pipeline>' do |pipeline|
  assert_equal scenario_state.get(pipeline), job_details_page.breadcrumb_pipeline.text
end

step 'Verify breadcrumb contains pipeline label <label>' do |label|
  assert_equal label, job_details_page.breadcrumb_pipeline_label.text
end

step 'Verify breadcrumb contains link to pipeline <pipeline> settings page' do |pipeline|
  assert_true job_details_page.breadcrumb_contains_link_to_pipeline?(scenario_state.get(pipeline))
end

step 'Click on stage bread crumb' do |_stage|
  job_details_page.breadcrumb_stage.click
end

step 'Verify that <stage> stage is displayed' do |stage|
  stage = new_pipeline_dashboard_page.sanitize_message(stage)
  assert_true stage_details_page.current_path.include? stage
end

step 'Verify breadcrumb contains link to value stream map on pipeline label <label> for pipeline <pipeline> for counter <counter>' do |label, pipeline, counter|
  assert_true job_details_page.vsm_link_exist?(pipeline, label, counter)
end

step 'Click on pipeline bread crumb' do |_pipeline|
  job_details_page.breadcrumb_stage.click
end

step 'Verify console says that artifact <artifact_name> was fetched from <stage_locator> for path <path_from_ancestor> from <stage_job>' do |artifact_name, stage_locator, path_from_ancestor, stage_job|
  stage_locator = new_pipeline_dashboard_page.sanitize_message(stage_locator)
  path_from_ancestor = new_pipeline_dashboard_page.sanitize_message(path_from_ancestor)
  message_1 = "fetch artifact [#{artifact_name}] =&gt; [] from [#{path_from_ancestor}/#{stage_job}]"
  message_2 = "Fetching artifact [#{artifact_name}] from [#{stage_locator}]"
  job_details_page.console_has_message?(message_1)
  job_details_page.console_has_message?(message_2)
end

step 'Verify in console that artifact <artifact> was uploaded to <dest>' do |artifact, dest|
  job_details_page.console_has_message?("/#{artifact} to #{dest}")
end

step 'Verify artifacts tab contains file <file>' do |file|
  assert_true job_details_page.file_exist_in_artifacts_tab? file
end

step 'Verify artifacts tab does not contain file <file>' do |file|
  assert_false job_details_page.file_exist_in_artifacts_tab? file
end


step 'Verify artifacts tab contains file <file> in dir <dir>' do |file, dir|
  assert_true job_details_page.file_exist_in_dir_in_artifacts_tab? file, dir
end

step 'For pipeline <pipeline> label <pipeline_label> stage <stage> counter <counter> job <job>' do |pipeline, pipeline_label, stage, counter, job|
  scenario_state.put('locator', "#{scenario_state.get(pipeline)}/#{pipeline_label}/#{stage}/#{counter}/#{job}")
end

step 'Append <text> to artifact <artifact> and Verify return code is <code> - Using Artifact Api' do |text, artifact, code|
  File.open('test.txt', 'w') {|f|  f.write(text) }
  if code.to_i==200 || code.to_i==201
  RestClient.put http_url("/files/#{scenario_state.get('locator')}/#{artifact}"), { multipart: true, file: File.open("test.txt", 'rb') }, {content_type: :json,Confirm: 'true'}.merge(basic_configuration.header) do |res, req, tmp|
    assert_true res.body.eql? "File #{artifact} was appended successfully"
  end
  else
  RestClient.put http_url("/files/#{scenario_state.get('locator')}/#{artifact}"), { multipart: true, file: File.open("test.txt", 'rb') }, {content_type: :json,Confirm: 'true'}.merge(basic_configuration.header) do |res, req, tmp|
       assert_true res.code.to_i==code.to_i
  end
  end
end

step 'Create artifact <artifact> and Verify return code is <code> - Using Artifact Api' do |artifact, code|
  f = File.new(artifact, 'w')
  f = File.new(artifact, 'rb')
  payload = { multipart: true, file: f }
  RestClient.post http_url("/files/#{scenario_state.get('locator')}/#{artifact}"), payload,
                                { content_type: :json, Confirm: true }.merge(basic_configuration.header) do |res,req,err|
     assert_true res.code == code.to_i
  end
end

step 'Verify artifact <artifact> contains text <text>' do |artifact,text|
  job_details_page.click_artifact artifact
  assert_true job_details_page.artifact_contents.include? text
end


step 'Set value <prop_value_api_1> in property <prop_name_api_1> and Verify return code is <201> - Using Properties Api' do |value,property,code|
  url="/properties/#{scenario_state.get('locator')}/#{property}"
  payload = "value=#{value}"
  RestClient.post http_url("#{url}"), payload,
  { Confirm: 'true' }.merge(basic_configuration.header) do |res,req,tmp|
  assert_true res.code == code.to_i
  end
end

step 'Verify property <property> has value <value>' do |property,value|
  url="/properties/#{scenario_state.get('locator')}/#{property}"

  RestClient.get http_url("#{url}"),
  {Confirm: 'true' }.merge(basic_configuration.header) do |res,req,tmp|
  assert_true res.body.include?value
  end
end

step 'Verify property <prop_name_api_6> does not exist' do |property|
  url="/properties/#{scenario_state.get('locator')}/#{property}"
  RestClient.get http_url("#{url}"),
  {Confirm: 'true' }.merge(basic_configuration.header) do |res,req,tmp|
  assert_true res.body.include?"Property '#{property}' not found."
  end
end


step 'Verify property <property> exist' do |property|
 assert_true job_details_page.property_exists?property
end
