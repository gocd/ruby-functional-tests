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
    element :reset_button, '.reset_button'

    # pipeline materials
    element :material_type, '#material_type_options'
    element :pipeline_material, '#material_pipelineStageName'
    element :branch_name, '.branch'
    element :next_to_materials, '#next_to_materials'
    element :material_url, "input[name='material[url]']"

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
    element :job_name_on_popup, '#job_name'
    element :command_on_popup, "input[name='job[tasks][exec][command]']"
    element :resources_on_popup, '#job_resources'
    element :job_name_popup, "input[name='stage[jobs][][name]']"
    element :command_on_stage_popup, "input[name='stage[jobs][][tasks][exec][command]']"

    #mingle project management
    element :mingle_URL, '#pipeline_mingleConfig_baseUrl'
    element :mingle_identifier, '#pipeline_mingleConfig_projectIdentifier'
    element :mingle_mqa, '#pipeline_mingleConfig_mqlCriteria_mql'







    def set_task_field(task_name, field, value)
      page.find("#pipeline_group_pipeline_stage_jobs__tasks_#{task_name}_#{field}").set value
    end

    def add_new_task(task)
      page.find('#job_task_options').find(:option, task).select_option
    end

    def set_material_url_for(material, url)
      page.find(".#{material}_url").set(url)
    end

    def get_pipeline_stages()
      stages=[]
      page.all('a.stage_name_link').each{|stage|
        stages.push(stage.text)}
      stages
    end

    def can_move_stage?stage,direction
      page.find(".stage_#{stage}").has_css?(".promote_#{direction}")
    end

    def move_stage stage,direction
      page.find(".stage_#{stage}").find("button[title='Move #{direction.capitalize}']").click
    end

    def stage_has_approval_type?stage,type
      page.find(".stage_#{stage}").has_css?(".approval_type",text:type)
    end

    def stage_has_jobs?stage,jobs
      page.find(".stage_#{stage}").has_css?(".number_of_jobs",text:jobs)
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
      page.find('a',text:stage).click
    end


    def unpause_pipeline
      page.find("button[title='Unpause']").click
    end

    def select_approval_type type
      page.find("#{type}").click
    end

  end
end
