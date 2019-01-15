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
  class PipelineCreationWizard < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/pipeline/new{?group*}"

    # Pipeline name and group
    element :new_pipeline_name, '#pipeline_group_pipeline_name'
    element :pipeline_group, '#pipeline_group_group'
    element :next_to_settings, '#next_to_settings'

    # pipeline materials
    element :material_type, '#material_type_options'
    element :pipeline_material, '#material_pipelineStageName'
    element :next_to_materials, '#next_to_materials'

    # Stage details
    element :stage_name, "input[name='pipeline_group[pipeline][stage][name]']"
    element :trigger_type_auto, '#auto'
    element :trigger_type_manual, '#manual'
    element :add_new_job, 'a.add_link'
    
    #jobs
    element :job_name, "input[name='pipeline_group[pipeline][stage][jobs][][name]']"
    element :task_type, '#job_task_options'
    element :finish, "button[value='Finish']"
    element :job_name_on_popup, '#job_name'
    element :command_on_popup, "input[name='job[tasks][exec][command]']"
    element :resources_on_popup, '#job_resources'
    
    


    def set_task_field(task_name, field, value)
      page.find("#pipeline_group_pipeline_stage_jobs__tasks_#{task_name}_#{field}").set value
    end

    def add_new_task(task)
      page.find('#job_task_options').find(:option, task).select_option
    end  

    def set_material_url_for(material, url)
      page.find(".#{material}_url").set(url)
    end  

  end
end
