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

require_relative '../../lib/helpers/go_url_helper.rb'


PIPELINE_CONFIG_API_VERSION = 'application/vnd.go.cd+json'

step 'Verify pipeline <pipeline> is locked and not schedulable - Using api' do |pipeline|
  begin
    response = RestClient.get http_url("/api/pipelines/#{scenario_state.get(pipeline)}/status"), basic_configuration.header
    assert_true JSON.parse(response.body)['locked']
    assert_false JSON.parse(response.body)['schedulable']
  rescue RestClient::ExceptionWithResponse => err
    p "Pipeline Status call failed with response code #{err.response.code} and the response body - #{err.response.body}"
  end
end

step 'Trigger pipeline <pipeline> and verify response code <code> - Using api' do |pipeline, response_code|
  RestClient.post http_url("/api/pipelines/#{scenario_state.get(pipeline)}/schedule"),
                  { content_type: :json, accept: PIPELINE_CONFIG_API_VERSION }.merge(basic_configuration.header) do |response, _request, _result|
    assert_true response.code == response_code.to_i
  end
end


step 'Verify pipeline <pipeline> is not locked and is schedulable - Using api' do |pipeline|
  begin
    response = RestClient.get http_url("/api/pipelines/#{scenario_state.get(pipeline)}/status"), basic_configuration.header
    assert_false JSON.parse(response.body)['locked']
    assert_true JSON.parse(response.body)['schedulable']
  rescue RestClient::ExceptionWithResponse => err
    p "Pipeline Status call failed with response code #{err.response.code} and the response body - #{err.response.body}"
  end
end

step 'Trigger stage <stage> run <run>' do |stage, run|
  begin
    response = RestClient.post http_url("/api/stages/#{scenario_state.self_pipeline}/#{run}/#{stage}/run"), '', { accept: 'application/vnd.go.cd+json', X_GoCD_Confirm: 'true' }.merge(basic_configuration.header)
    assert_true response.code == 200
  rescue RestClient::ExceptionWithResponse => err
    p "Trigger stage call failed with response code #{err.response.code} and the response body - #{err.response.body}"
  end
  new_pipeline_dashboard_page.verify_pipeline_stage_state(scenario_state.self_pipeline, stage, 'building')
end

step 'Cancel stage <stage> of pipeline <pipeline>' do |stage, pipeline|
  begin
    response = RestClient.post http_url("/api/stages/#{scenario_state.get(pipeline)}/#{stage}/cancel"), '', basic_configuration.header
    assert_true response.code == 200
  rescue RestClient::ExceptionWithResponse => err
    p "Cancel stage call failed with response code #{err.response.code} and the response body - #{err.response.body}"
  end
end


step 'Verify can unlock <pipeline>' do |pipeline|
 body= begin
    response = RestClient.post http_url("/api/pipelines/#{scenario_state.get(pipeline)}/unlock"),'',
        { content_type: :json, accept: 'application/vnd.go.cd+json','X-GoCD-Confirm': 'true' }.merge(basic_configuration.header)
  rescue RestClient::ExceptionWithResponse => err
    p err.response.body
  end

  assert_true JSON.parse(body).to_s.include?"Pipeline lock released for #{scenario_state.get(pipeline)}"
end

step 'Verify unauthorized to unlock <pipeline>' do |pipeline|
  body=begin
    response = RestClient.post http_url("/api/pipelines/#{scenario_state.get(pipeline)}/unlock"),'',
        { content_type: :json, accept: 'application/vnd.go.cd+json','X-GoCD-Confirm': 'true'}.merge(basic_configuration.header)
  rescue RestClient::ExceptionWithResponse => err
    p err.response.body
  end
  assert_true JSON.parse(body).to_s.include?'You are not authorized to perform this action'
end

step 'Verify unlocking <pipeline> is not acceptable because <message>' do |pipeline,message|
  body=begin
    response = RestClient.post http_url("/api/pipelines/#{scenario_state.get(pipeline)}/unlock"),'',
        { content_type: :json, accept: 'application/vnd.go.cd+json','X-GoCD-Confirm': 'true' }.merge(basic_configuration.header)
    rescue RestClient::ExceptionWithResponse => err
     p err.response.body
   end
  assert_true JSON.parse(body).to_s.include?message
end

step 'Verify unlocking <pipeline> fails as pipeline is not found' do |pipeline|
  RestClient.post http_url("/api/pipelines/#{pipeline}/unlock"),'',
        { content_type: :json, accept: 'application/vnd.go.cd+json', "X-GoCD-Confirm": 'true' }
        .merge(basic_configuration.header) do |response, _request, _result|
    assert_true response.code.eql? 404
  end
end


step 'Delete pipeline <pipeline> - Configure cruise using api' do |pipeline|
  begin
    response =   RestClient.delete http_url("/api/admin/pipelines/#{scenario_state.get(pipeline)}"),
    { content_type: :json, accept: 'application/vnd.go.cd+json' }.merge(basic_configuration.header)
    assert_true response.code == 200
  rescue RestClient::ExceptionWithResponse => err
    p "Delete Pipeline call failed with response code #{err.response.code} and the response body - #{err.response.body}"
  end

end

step 'Verify unauthorized to unlock <pipeline> using access token <token_id>' do |pipeline, token_id|
	body=begin
    response = RestClient.post http_url("/api/pipelines/#{scenario_state.get(pipeline)}/unlock"),'',
        { content_type: :json, accept: 'application/vnd.go.cd+json','X-GoCD-Confirm': 'true', Authorization: "Bearer #{scenario_state.get(token_id)}"}
  rescue RestClient::ExceptionWithResponse => err
    p err.response.body
  end
  assert_true JSON.parse(body).to_s.include?'You are not authorized to perform this action'
end

step 'Verify can unlock <pipeline> using access token <token_id>' do |pipeline, token_id|
	body= begin
    response = RestClient.post http_url("/api/pipelines/#{scenario_state.get(pipeline)}/unlock"),'',
        { content_type: :json, accept: 'application/vnd.go.cd+json','X-GoCD-Confirm': 'true', Authorization: "Bearer #{scenario_state.get(token_id)}"}
  rescue RestClient::ExceptionWithResponse => err
    p err.response.body
  end
  assert_true JSON.parse(body).to_s.include?"Pipeline lock released for #{scenario_state.get(pipeline)}"
end

step 'Attempt to get scheduled list of jobs should return with status <return_code>' do |return_code|
 RestClient.get http_url("/api/jobs/scheduled.xml"), basic_configuration.header do |response|
  assert_true response.code == return_code.to_i
 end
end

step 'Using latest revision of material of type <type> named <material> for pipeline <pipeline>' do |type,material,pipeline|
if type=="git"
  revision = Context::GitMaterials.new(basic_configuration.material_url_for(scenario_state.self_pipeline)).latest_revision
  current_material_url=basic_configuration.material_url(pipeline,type,material)
  new_pipeline_dashboard_page.set_fingerprint current_material_url
  payload = %({ "fingerprint": #{scenario_state.get('fingerprint')}, "revision": #{revision}})
  scenario_state.put('material_for_schedule',payload)
  scenario_state.put('update_materials_before_scheduling',false)
end
end


step 'Using stage <stage> of upstream pipeline <pipeline> with counter <counter>' do |stage,pipeline,counter|
  current_material_url="#{scenario_state.get(pipeline)}/#{counter}/#{stage}"
  new_pipeline_dashboard_page.set_fingerprint current_material_url
  scenario_state.put('revision',current_material_url)
  payload = %({ "fingerprint":"#{scenario_state.get('fingerprint')}", "revision":"#{scenario_state.get('revision')}"})
  scenario_state.put('material_for_schedule',payload)
  scenario_state.put('update_materials_before_scheduling',false)
end

step 'With variable <var> set to <value>' do |var,value|
  variable={var=>value}
  if scenario_state.get('variables').nil?
    scenario_state.put('variables',variable)
  else
    scenario_state.put('variables',scenario_state.get('variables').merge(variable))
  end
  scenario_state.put('update_materials_before_scheduling',true)
end

step 'Using <rev> revision of <material> of type <git> for pipeline <pipeline>' do |rev,material,type,pipeline|
  current_material_url=""

    if rev.count("0-9")>0
      rev=Context::GitMaterials.new(basic_configuration.material_url_for(scenario_state.self_pipeline)).nth_revision rev.delete('^0-9')
      current_material_url=basic_configuration.material_url(pipeline,type,material)
      new_pipeline_dashboard_page.set_fingerprint current_material_url
      scenario_state.put('revision',rev)
      payload = %({ "fingerprint": #{scenario_state.get('fingerprint')}, "revision": #{rev}})
      scenario_state.put('material_for_schedule',payload)
      scenario_state.put('update_materials_before_scheduling',true)
    else
      scenario_state.put('revision',rev)
      payload = %({ "revision": #{rev}})
      scenario_state.put('material_for_schedule',payload)
      scenario_state.put('update_materials_before_scheduling',false)
    end

end

step 'Schedule should return code <status_code>' do |status_code|
  var=""
  scenario_state.get('variables').to_h.each do |key, value|
   var=var<<",{\"name\":\"#{key}\",\"value\":\"#{value}\"}"
  end

  var=',' if var.nil?
  scenario_state.put('update_materials_before_scheduling',true) if scenario_state.get('update_materials_before_scheduling').nil?
  payload = %({
                  "environment_variables": [#{var.sub!(',','')}],
                  "materials": [ #{scenario_state.get('material_for_schedule')}],
                  "update_materials_before_scheduling": true
             })

   RestClient.post http_url("/api/pipelines/#{scenario_state.self_pipeline}/schedule"), payload,
      { content_type: :json, accept: 'application/vnd.go.cd+json' }.merge(basic_configuration.header)do |response, _request, _result|
        assert_true response.code == status_code.to_i
      end
       scenario_state.put('variables',nil)
       scenario_state.put('material_for_schedule',nil)
       scenario_state.put('update_materials_before_scheduling',true)

end


step 'Verify pipeline instance <pipeline> is not found' do |pipeline|
  RestClient.get http_url("/api/pipelines/#{scenario_state.get(pipeline)}/stages.xml"), basic_configuration.header do |response|
    assert_true response.code.to_i == 400
   end
end

step 'Verify shows first instance of <stage> of <pipeline>' do |stage, pipeline|
  RestClient.get http_url("/api/pipelines/#{scenario_state.get(pipeline)}/stages.xml"), basic_configuration.header do |response|
    assert_true response.body.to_s.include? "#{scenario_state.get(pipeline)}(1) stage #{stage}(1) Passed"
    doc = Nokogiri::XML(response)
    pipeline_instance_element=doc.xpath("//xmlns:feed/xmlns:entry/xmlns:title[.=\"#{scenario_state.get(pipeline)}(1) stage #{stage}(1) Passed\"]")
    pipeline_link=pipeline_instance_element.xpath("//xmlns:link[@rel='http://www.thoughtworks-studios.com/ns/relations/go/pipeline'][@type='application/vnd.go+xml']")
    scenario_state.put("#{scenario_state.get(pipeline)}",pipeline_link.attribute("href").value[/\/api.+/im])
  end
end

step 'Verify loads <pipeline> instance with file <file>' do |pipeline,file|
  RestClient.get http_url(scenario_state.get(scenario_state.get(pipeline))), basic_configuration.header do |response|
   doc = Nokogiri::XML(response)

  assert_equal file, doc.xpath("//file/@name").first.value
  end
end

step 'Verify unauthorized to load <pipeline>' do |pipeline|
  RestClient.get http_url(scenario_state.get(scenario_state.get(pipeline))), basic_configuration.header do |response|
    assert_true response.code.to_i == 403
   end
end

step 'Verify fails to find <pipeline> with bad id' do |pipeline|
  RestClient.get http_url("/api/pipelines/#{scenario_state.get(pipeline)}/0.xml"), basic_configuration.header do |response|
    assert_true response.code.to_i == 404
   end
end
