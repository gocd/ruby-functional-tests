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
    class StageSettingsPage < GeneralSettingsPage
      set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/pipelines{/pipeline_name}/stages{/stage_name}/settings"
      
      element :stage_name, "#stage_name"

     def job_resources(job)
        page.find('td a', text:job).ancestor('tr').find('td:nth-child(2)').text
     end 

     def run_on_all(job)
      page.find('td a', text:job).ancestor('tr').find('td:nth-child(3)').text
     end  
 
     def open_job(job)
       page.find('td a', text:job).click
     end  
 
     def delete_job(job)
      page.find('td a', text:job).ancestor('tr').find('td.remove').find('form span.icon_remove').click
      page.find("button[value='Proceed']").click
     end  
 
     def job_present?job
       page.has_css?('td a',text:job)
     end 

    end
end
  