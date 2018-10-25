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
    element :task_commands, "input[name='task[command]']"
    element :argument, "textarea[name='task[argListString]']"
    element :task_advance_option_command, "input[name='task[onCancelConfig][execOnCancel][command]']"
    element :advance_option_task_type, ".on_cancel_type.MB_focusable option"
    element :on_cancel_task_check_box, ".has_cancel_task.MB_focusable"
    element :delete_task_button, ".primary.submit.MB_focusable"
  
<<<<<<< HEAD
    

=======
   
>>>>>>> Removed parameter true from assert_true
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

    def configure_more_task(command,arglist,working_directory,run_conditions)
      task_commands.set(command)
      arglist.split(',').each {|arg| argument.set(arg)}
      task_working_directory.set(working_directory)

      run_conditions.split(',').each { |run_condition|
         page.find("input[name='task[runIfConfigs#{run_condition}]']").set(true)
        }
    end

<<<<<<< HEAD
    def  configure_on_cancel_More_task(task,command)
=======
    def  configure_on_cancel_more_task(task,command)
>>>>>>> Removed parameter true from assert_true
      on_cancel_task_check_box.click
      page.find('option', text: task).click
      task_advance_option_command.set(command)
    end
  
    def get_cell_value_from_table(row_count,header_name,column_name)
     
       case column_name
         when "Task Type"
          return page.find(".tasks_list_table tr:nth-child(#{row_count.to_i}) td:nth-child(2)").text.eql?(header_name)
         when "Run If Conditions"
          return page.find(".tasks_list_table tr:nth-child(#{row_count.to_i}) td:nth-child(3)").text.eql?(header_name)
         when "Properties"
          return page.find(".tasks_list_table tr:nth-child(#{row_count.to_i}) td:nth-child(4)").text.eql?(header_name)
         when "On Cancel"
          return page.find(".tasks_list_table tr:nth-child(#{row_count.to_i}) td:nth-child(5)").text.eql?(header_name)
        end
     end   
  
   def delete_task (task_no)
    page.find("tr:nth-child(#{task_no.to_i}) td span.icon_remove").click
    delete_task_button.click
   end 

   def verify_task_with_command_is_not_exists(command)
     page.has_no_css?('li.task_property.command span.value', text:command.split(':').last.strip)
   end

   def verify_task_with_command_is_not_exist_in_config(task,command,job,stage,pipeline)
<<<<<<< HEAD
    
      if basic_configuration.get_config_from_server.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.actual_pipeline_name(pipeline)}']/stage[@name='#{stage}']/jobs/job[@name='#{job}']/tasks/#{task}[@command='#{command}']").count==0 
        return true 
      end

   end
   

=======
      if basic_configuration.get_config_from_server.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.actual_pipeline_name(pipeline)}']/stage[@name='#{stage}']/jobs/job[@name='#{job}']/tasks/#{task}[@command='#{command}']").count==0 
        return true 
      end
   end
   
>>>>>>> Removed parameter true from assert_true
  end
end
