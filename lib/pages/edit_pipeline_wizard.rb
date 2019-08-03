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
  class EditPipelineWizard < AppBase


    # pipeline materials
    element :material_type, '#material_type_options'
    element :pipeline_material, '#material_pipelineStageName'
    element :next_to_materials, '#next_to_materials'
    element :material_url, "input[name='material[url]']"
    
    element :check_connection, "button[value='CHECK CONNECTION']"

    # Stage details
    element :stage_name, "input[name='pipeline_group[pipeline][stage][name]']"
    element :trigger_type_auto, '#auto'
    element :trigger_type_manual, '#manual'
    element :add_new_job, 'a.add_link'
    element :add_new_stage, 'a.add_link'
    element :stage_on_popup, "input[name='stage[name]']"

    #jobs
    element :job_name, "input[name='pipeline_group[pipeline][stage][jobs][][name]']"
    element :task_type, '#job_task_options'
    element :finish, "button[value='Finish']"





    ##task-details
    element :exec_tas_command, '.exec-task-command'

    def set_task_field(task_name, field, value)
      page.find("#pipeline_group_pipeline_stage_jobs__tasks_#{task_name}_#{field}").set value
    end

    def add_new_task(task)
      page.find('#job_task_options').find(:option, task).select_option
    end

    def get_pipeline_stages()
      stages=[]
      page.all('a.stage_name_link').each{|stage|
        stages.push(stage.text)}
      stages
    end



    def verify_reset_button_exist?
       page.has_css?('.reset_button')
    end

    def open_tab(tab)
      page.find('a',text:tab).click
    end

    def select_tracking_tool tool
      page.find("input[title='#{tool.capitalize}']").click
    end

    def select_stage stage
      page.find('.stage_name_link',text:stage).click
    end


    def unpause_pipeline
      page.find("button[title='Unpause']").click
    end

    def select_approval_type type
      page.find("#{type}").click
    end

    def connection_ok?
      page.has_css?('.ok_message')
    end

    def set_polling_off (material_type)
      page.find("#pipeline_group_pipeline_materials_#{material_type}Material_autoUpdate").click
    end

    def git_error_message_present?(error_message,material_type)
      page.find("#vcsconnection-message_#{material_type}").text.include? error_message
    end

    def set_username(material_type,username)
      page.find(".#{material_type}_username").set username
    end

    def set_password(material_type,password)
      page.find(".#{material_type}_password").set password
    end

    def set_branch(branch,material_type)
      page.find(".#{material_type}_branch").set branch
    end

  end
end
