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

module Pages
  
  class PublishArtifactsView < AppBase

    elements :external_artifacts_form, '.dirtyform'
    elements :external_artifacts_id, '#job_artifactConfigs__id'
    elements :external_artifacts_store_id, '#job_artifactConfigs__storeId'
    elements :source, "input[name='job[artifactConfigs][][source]']"
    elements :destination, "input[name='job[artifactConfigs][][destination]']"
    elements :external_source, "input[name='job[artifactConfigs][][configuration][Source]']"
    elements :external_destination, "input[name='job[artifactConfigs][][configuration][Destination]']"
    element :save_publish_artifacts, "button[value='SAVE']"

    def fill_form(key_value)
      f = key_value.split(':', 2)
      external_artifacts_form[0].find(:xpath, instance_eval(f[0])[0].path).set("#{f[1].strip}")
    end

    def fill_form_with_index(key_value, index)
      f = key_value.split(':', 2)
      external_artifacts_form[0].find(:xpath, instance_eval(f[0])[index.to_i-1].path).set("#{f[1].strip}")
    end

    def verify_artifact_exist(pipeline,artifact,stage,job)
      @artifact_list=[]
       basic_configuration.get_config_from_server.xpath("//cruise/pipelines/pipeline[@name='#{pipeline}']/stage[@name='#{stage}']/jobs/job[@name='#{job}']/artifacts/artifact").each { 
        |art|  @artifact_list.push("#{art['type']}:#{art['src']}:#{art['dest']}") 
        }
        if @artifact_list.include?(artifact) 
          return true
        else 
          return false
        end  
     end
     
  end
  
end
