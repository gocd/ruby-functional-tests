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
  class JobSettings < GeneralSettingsPage
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/pipelines{/pipeline_name}/stages{/stage_name}/job{/job_name}/tasks"

    element :add_new_task, '#add_new_task_dropdown_link'
    element :new_task_list, '#new_task_popup'
    element :external_artifact, "input[title='External']"
    element :task_pipeline, '#task_pipelineName'
    element :task_stage, '#task_stage'
    element :task_job, '#task_job'
    element :task_artifactId, '#task_artifactId'
    element :task_save, "button[value='SAVE']"
    element :publish_artifact_type, '#select_artifact_type'
    element :add_artifact, '#add_artifact'
    element :artifact_source, '.artifact_source'
    element :store_id, "input[name='job[artifactConfigs][][storeId]']"
    element :task_configuration_path, "input[name='task[configuration][Path]']"
    element :task_working_directory, "input[name='task[workingDirectory]']"
    element :task_target, "input[name='task[target]']"
    element :tasks_list, "table.tasks_list_table"
    element :task_build_file, "input[name='task[buildFile]']"


  load_validation { has_add_new_task? }

    def add_new_task_of_type(type)
      add_new_task.click
      add_new_task.click
      new_task_list.find('a', text: type).click
    end 

    def configure_rake_task(target,working_directory)
      task_target.set(target)
      task_working_directory.set(working_directory)
    end

    def move_task_down(task_index)
      tasks_list.find("tbody tr.task_#{task_index} button.promote_button .promote_down").ancestor('button.promote_button').click
    end

    def move_task_up(task_index)
      tasks_list.find("tbody tr.task_#{task_index} button.promote_button .promote_up").ancestor('button.promote_button').click
    end
   def set_task(task_type,target,build_file,working_directory,run_if_list)
      add_new_task.click
      new_task_list.find('a', text: task_type, exact_text: true).click
      task_target.set(target)
      task_build_file.set(build_file)
      task_working_directory.set(working_directory)
      run_if_list.split(',').each { |run_condition|
       page.find("input[name='task[runIfConfigs#{run_condition}]']").set(true) }
      general_settings_page.task_save.click
    end

    def get_cell_value_from_table(row_count,header_name,column_name)
      case column_name
        when "Task Type"
         return page.find(".tasks_list_table tr:nth-child(#{row_count.to_i}) td:nth-child(2)").text.eql?(header_name)
        when "Run If Conditions"
         return page.find(".tasks_list_table tr:nth-child(#{row_count.to_i}) td:nth-child(3)").text.eql?(header_name)
        when "Properties"
          return page.find(".tasks_list_table tr:nth-child(#{row_count.to_i}) td:nth-child(4)").text.gsub("\n", ' ').eql?(header_name)
        when "On Cancel"
         return page.find(".tasks_list_table tr:nth-child(#{row_count.to_i}) td:nth-child(5)").text.eql?(header_name)
       end
    end   

  end
end
