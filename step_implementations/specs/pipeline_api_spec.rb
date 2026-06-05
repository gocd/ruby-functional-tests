##########################################################################
# Copyright 2022 Thoughtworks, Inc.
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

require_relative '../../lib/helpers/go_url_helper.rb'

PIPELINE_CONFIG_API_VERSION = 'application/vnd.go.cd+json'

step 'Verify pipeline <pipeline> is locked and not schedulable - Using api' do |pipeline|
  begin
    response = Helpers::HTTP.raising.get http_url("/api/pipelines/#{scenario_state.get(pipeline)}/status"), nil, { accept: 'application/vnd.go.cd+json' }.merge(basic_configuration.header)
    assert_true JSON.parse(response.body)['locked']
    assert_false JSON.parse(response.body)['schedulable']
  rescue Faraday::ClientError, Faraday::ServerError => err
    raise "Pipeline Status call failed with response code #{err.response.status} and the response body - #{err.response.body}"
  end
end

step 'Trigger pipeline <pipeline> and verify response code <code> - Using api' do |pipeline, response_code|
  response = Helpers::HTTP.quiet.post http_url("/api/pipelines/#{scenario_state.get(pipeline)}/schedule"),
                                      {content_type: 'application/json', accept: PIPELINE_CONFIG_API_VERSION}.merge(basic_configuration.header)
  assert_equal response.status, response_code.to_i
end

step 'Verify pipeline <pipeline> is not locked and is schedulable - Using api' do |pipeline|
  begin
    response = Helpers::HTTP.raising.get http_url("/api/pipelines/#{scenario_state.get(pipeline)}/status"), nil, { accept: 'application/vnd.go.cd+json' }.merge(basic_configuration.header)
    assert_false JSON.parse(response.body)['locked']
    assert_true JSON.parse(response.body)['schedulable']
  rescue Faraday::ClientError, Faraday::ServerError => err
    raise "Pipeline Status call failed with response code #{err.response.status} and the response body - #{err.response.body}"
  end
end

step 'Trigger stage <stage> run <run>' do |stage, run|
  begin
    response = Helpers::HTTP.raising.post http_url("/api/stages/#{scenario_state.self_pipeline}/#{run}/#{stage}/run"), '', { accept: 'application/vnd.go.cd+json', X_GoCD_Confirm: 'true'}.merge(basic_configuration.header)
    assert_equal response.status, 202
  rescue Faraday::ClientError, Faraday::ServerError => err
    raise "Trigger stage call failed with response code #{err.response.status} and the response body - #{err.response.body}"
  end
  new_pipeline_dashboard_page.wait_for_expected_stage_state(scenario_state.self_pipeline, stage, 'building')
end

step 'Cancel stage <stage> counter <counter> of pipeline <pipeline> instance <instance>' do |stage, counter, pipeline, instance|
  begin
    response = Helpers::HTTP.raising.post http_url("/api/stages/#{scenario_state.get(pipeline)}/#{instance}/#{stage}/#{counter}/cancel"), '',
                                          {accept: 'application/vnd.go.cd+json', 'X-GoCD-Confirm' => 'true'}.merge(basic_configuration.header)

    assert_equal response.status, 200
  rescue Faraday::ClientError, Faraday::ServerError => err
    raise "Cancel stage call failed with response code #{err.response.status} and the response body - #{err.response.body}"
  end
end

step 'Verify can unlock <pipeline>' do |pipeline|
  response = Helpers::HTTP.raising.post http_url("/api/pipelines/#{scenario_state.get(pipeline)}/unlock"), '',
                                        {content_type: 'application/json', accept: 'application/vnd.go.cd+json', 'X-GoCD-Confirm' => 'true'}.merge(basic_configuration.header)

  assert_includes JSON.parse(response.body).to_s, "Pipeline lock released for #{scenario_state.get(pipeline)}"
end

step 'Verify unauthorized to unlock <pipeline>' do |pipeline|
  response = Helpers::HTTP.quiet.post http_url("/api/pipelines/#{scenario_state.get(pipeline)}/unlock"), '',
                                      {content_type: 'application/json', accept: 'application/vnd.go.cd+json', 'X-GoCD-Confirm' => 'true'}.merge(basic_configuration.header)
  assert_includes JSON.parse(response.body).to_s, 'You are not authorized to perform this action'
end

step 'Verify unlocking <pipeline> is not acceptable because <message>' do |pipeline, message|
  response = Helpers::HTTP.quiet.post http_url("/api/pipelines/#{scenario_state.get(pipeline)}/unlock"), '',
                                      {content_type: 'application/json', accept: 'application/vnd.go.cd+json', 'X-GoCD-Confirm' => 'true'}.merge(basic_configuration.header)
  assert_equal response.status, 409
  assert_includes JSON.parse(response.body).to_s, message
end

step 'Verify unlocking <pipeline> fails as pipeline is not found' do |pipeline|
  response = Helpers::HTTP.quiet.post http_url("/api/pipelines/#{pipeline}/unlock"), '',
                                      {content_type: 'application/json', accept: 'application/vnd.go.cd+json', "X-GoCD-Confirm" => 'true'}.merge(basic_configuration.header)
  assert_equal response.status, 404
end

step 'Delete pipeline <pipeline> - Configure cruise using api' do |pipeline|
  begin
    response = Helpers::HTTP.raising.delete http_url("/api/admin/pipelines/#{scenario_state.get(pipeline)}"), nil,
                                            {content_type: 'application/json', accept: 'application/vnd.go.cd+json'}.merge(basic_configuration.header)
    assert_equal response.status, 200
  rescue Faraday::ClientError, Faraday::ServerError => err
    raise "Delete Pipeline call failed with response code #{err.response.status} and the response body - #{err.response.body}"
  end
end

step 'Verify unauthorized to unlock <pipeline> using access token <token_id>' do |pipeline, token_id|
  response = Helpers::HTTP.quiet.post http_url("/api/pipelines/#{scenario_state.get(pipeline)}/unlock"), '',
                                      {content_type: 'application/json', accept: 'application/vnd.go.cd+json', 'X-GoCD-Confirm' => 'true', Authorization: "Bearer #{scenario_state.get(token_id)}"}
  assert_includes JSON.parse(response.body).to_s, 'You are not authorized to perform this action'
end

step 'Verify can unlock <pipeline> using access token <token_id>' do |pipeline, token_id|
  response =  Helpers::HTTP.raising.post http_url("/api/pipelines/#{scenario_state.get(pipeline)}/unlock"), '',
                                         {content_type: 'application/json', accept: 'application/vnd.go.cd+json', 'X-GoCD-Confirm' => 'true', Authorization: "Bearer #{scenario_state.get(token_id)}"}
  assert_includes JSON.parse(response.body).to_s, "Pipeline lock released for #{scenario_state.get(pipeline)}"
end

step 'Attempt to get scheduled list of jobs should return with status <return_code>' do |return_code|
  response = Helpers::HTTP.quiet.get(http_url("/api/feed/jobs/scheduled.xml"), nil, basic_configuration.header)
  assert_equal response.status, return_code.to_i, "Expected: #{return_code}, Actual: #{response.status}"
end

step 'Using latest revision of material of type <type> named <material> for pipeline <pipeline>' do |type, material, pipeline|
  if type == "git"
    revision             = Context::GitMaterials.new(basic_configuration.material_url_for(scenario_state.self_pipeline)).latest_revision
    current_material_url = basic_configuration.material_url(pipeline, type, material)
    new_pipeline_dashboard_page.set_fingerprint current_material_url
    payload = %({ "fingerprint": #{scenario_state.get('fingerprint')}, "revision": #{revision}})
    scenario_state.put('material_for_schedule', payload)
    scenario_state.put('update_materials_before_scheduling', false)
  end
end

step 'Using stage <stage> of upstream pipeline <pipeline> with counter <counter>' do |stage, pipeline, counter|
  current_material_url = "#{scenario_state.get(pipeline)}/#{counter}/#{stage}"
  new_pipeline_dashboard_page.set_fingerprint current_material_url
  scenario_state.put('revision', current_material_url)
  payload = %({ "fingerprint":"#{scenario_state.get('fingerprint')}", "revision":"#{scenario_state.get('revision')}"})
  scenario_state.put('material_for_schedule', payload)
  scenario_state.put('update_materials_before_scheduling', false)
end

step 'With variable <var> set to <value>' do |var, value|
  variable = {var => value}
  if scenario_state.get('variables').nil?
    scenario_state.put('variables', variable)
  else
    scenario_state.put('variables', scenario_state.get('variables').merge(variable))
  end
  scenario_state.put('update_materials_before_scheduling', true)
end

step 'Using <rev> revision of <material> of type <git> for pipeline <pipeline>' do |rev, material, type, pipeline|
  if rev.count("0-9") > 0
    rev                  = Context::GitMaterials.new(basic_configuration.material_url_for(scenario_state.self_pipeline)).nth_revision rev.delete('^0-9')
    current_material_url = basic_configuration.material_url(pipeline, type, material)
    new_pipeline_dashboard_page.set_fingerprint current_material_url
    scenario_state.put('revision', rev)
    payload = %({ "fingerprint": #{scenario_state.get('fingerprint')}, "revision": #{rev}})
    scenario_state.put('material_for_schedule', payload)
    scenario_state.put('update_materials_before_scheduling', true)
  else
    scenario_state.put('revision', rev)
    payload = %({ "revision": #{rev}})
    scenario_state.put('material_for_schedule', payload)
    scenario_state.put('update_materials_before_scheduling', false)
  end

end

step 'Schedule should return code <status_code>' do |status_code|
  var = ""
  scenario_state.get('variables').to_h.each do |key, value|
    var += ",{\"name\":\"#{key}\",\"value\":\"#{value}\"}"
  end

  var = ',' if var.nil?
  scenario_state.put('update_materials_before_scheduling', true) if scenario_state.get('update_materials_before_scheduling').nil?
  payload = %({
                  "environment_variables": [#{var.dup.sub!(',', '')}],
                  "materials": [ #{scenario_state.get('material_for_schedule')}],
                  "update_materials_before_scheduling": true
             })

  response = Helpers::HTTP.quiet.post http_url("/api/pipelines/#{scenario_state.self_pipeline}/schedule"),
                                      payload,
                                      {content_type: 'application/json', accept: 'application/vnd.go.cd+json'}.merge(basic_configuration.header)
  assert_equal response.status, status_code.to_i, "Expected: #{status_code}, Actual: #{response.status}"
  scenario_state.put('variables', nil)
  scenario_state.put('material_for_schedule', nil)
  scenario_state.put('update_materials_before_scheduling', true)
end

step 'Verify pipeline instance <pipeline> is not found' do |pipeline|
  response = Helpers::HTTP.quiet.get(http_url("/api/pipelines/#{scenario_state.get(pipeline)}/stages.xml"), nil, basic_configuration.header)
  assert_equal response.status.to_i, 400, "Expected: 400, Actual: #{response.status}"
end

step 'Verify shows first instance of <stage> of <pipeline>' do |stage, pipeline|
  response = Helpers::HTTP.raising.get(http_url("/api/feed/pipelines/#{scenario_state.get(pipeline)}/stages.xml"), nil, basic_configuration.header)
  assert_includes response.body.to_s, "#{scenario_state.get(pipeline)}(1) stage #{stage}(1) Passed"
  doc                       = Nokogiri::XML(response.body)
  pipeline_instance_element = doc.xpath("//xmlns:feed/xmlns:entry/xmlns:title[.=\"#{scenario_state.get(pipeline)}(1) stage #{stage}(1) Passed\"]")
  pipeline_link             = pipeline_instance_element.xpath("//xmlns:link[@rel='http://www.thoughtworks-studios.com/ns/relations/go/pipeline'][@type='application/vnd.go+xml']")
  scenario_state.put("#{scenario_state.get(pipeline)}", pipeline_link.attribute("href").value[/\/api.+/im])
end

step 'Verify loads <pipeline> instance with file <file>' do |pipeline, file|
  response = Helpers::HTTP.raising.get(http_url(scenario_state.get(scenario_state.get(pipeline))), nil, basic_configuration.header)
  doc = Nokogiri::XML(response.body)
  assert_equal file, doc.xpath("//file/@name").first.value
end

step 'Verify unauthorized to load <pipeline>' do |pipeline|
  response = Helpers::HTTP.quiet.get(http_url(scenario_state.get(scenario_state.get(pipeline))), nil, basic_configuration.header)
  assert_equal response.status.to_i, 401, "Expected: 401, Actual: #{response.status}"
end

step 'Verify fails to find <pipeline> with bad id' do |pipeline|
  response = Helpers::HTTP.quiet.get(http_url("/api/pipelines/#{scenario_state.get(pipeline)}/0.xml"), nil, basic_configuration.header)
  assert_equal response.status.to_i, 404
end
