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
    element :store_id, "input[name='job[artifactTypeConfigs][][storeId]']"
    element :task_configuration_path, "input[name='task[configuration][Path]']"
    element :task_working_directory, "input[name='task[workingDirectory]']"
    element :task_target, "input[name='task[target]']"
    element :argument, "textarea[name='task[argListString]']"
    element :task_advance_option_command, "input[name='task[onCancelConfig][execOnCancel][command]']"
    element :advance_option_task_type, ".on_cancel_type.MB_focusable option"
    element :on_cancel_task_check_box, ".has_cancel_task.MB_focusable"
    element :delete_task_button, ".primary.submit.MB_focusable"
    element :tasks_list, "table.tasks_list_table"
    element :task_build_file, "input[name='task[buildFile]']"
    element :task_commands, "input[name='task[command]']"
    element :task_cancel, ".close_modalbox_control"
    element :job_name, "#job_name"
    element :set_never, "#jobTimeout_never"
    element :resources_on_popup, '#job_resources'
    element :task_source_file, "input[name='task[src]']"
    element :task_dest_dir,"input[name='task[dest]']"

    load_validation { has_add_new_task? }

    def add_new_task_of_type(type)
      add_new_task.click
      add_new_task.click
      new_task_list.find('a', exact_text: type).click
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

    def  configure_on_cancel_more_task(task,command)
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
          return page.find(".tasks_list_table tr:nth-child(#{row_count.to_i}) td:nth-child(4)").text.gsub("\n", ' ').eql?(new_pipeline_dashboard_page.sanitize_message(header_name))
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
     basic_configuration.get_config_from_server.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.get(pipeline)}']/stage[@name='#{stage}']/jobs/job[@name='#{job}']/tasks/#{task}[@command='#{command}']").count==0
    end

    def move_task_down(task_index)
      tasks_list.find("tbody tr.task_#{task_index} button.promote_button .promote_down").ancestor('button.promote_button').click
    end

    def move_task_up(task_index)
      tasks_list.find("tbody tr.task_#{task_index} button.promote_button .promote_up").ancestor('button.promote_button').click
    end

    def set_task(task_type,target,build_file,working_directory,run_if_list)
      add_new_task.click
      (new_task_list wait: 20).find('a', text: task_type, exact_text: true).click
      task_target.set(target)
      task_build_file.set(build_file)
      task_working_directory.set(working_directory)
      run_if_list.split(',').each { |run_condition|
       page.find("input[name='task[runIfConfigs#{run_condition}]']").set(true) }
      general_settings_page.task_save.click
    end

    def click_on_task_by_index(row_count)
      page.find(".tasks_list_table tr:nth-child(#{row_count.to_i}) td:nth-child(2) a").click
     end

    def edit_task_with_on_cancel(build_file,target,working_directory,cancel_task_type,cancel_build_file,cancel_Target,cancel_working_Dir)

      task_build_file.set(build_file)
      task_target.set(target)
      task_working_directory.set(working_directory)
      on_cancel_task_check_box.set(true)
      page.find('option', text: cancel_task_type, exact_text: true).click
      page.find("input[name='task[onCancelConfig][#{cancel_task_type.downcase}OnCancel][buildFile]']").native.clear
      page.find("input[name='task[onCancelConfig][#{cancel_task_type.downcase}OnCancel][buildFile]']").set(cancel_build_file)
      page.find("input[name='task[onCancelConfig][#{cancel_task_type.downcase}OnCancel][target]']").native.clear
      page.find("input[name='task[onCancelConfig][#{cancel_task_type.downcase}OnCancel][target]']").set(cancel_Target)
      page.find("input[name='task[onCancelConfig][#{cancel_task_type.downcase}OnCancel][workingDirectory]']").native.clear
      page.find("input[name='task[onCancelConfig][#{cancel_task_type.downcase}OnCancel][workingDirectory]']").set(cancel_working_Dir)
      general_settings_page.task_save.click
    end

    def set_multiple_instance_with(instance)
      page.find('#jobRunType_runMultipleInstances').set(true)
      page.find('#job_runInstanceCount').set(instance)
    end

    def error_messages
      errors=[]
      page.all('.form_error', wait: 10).each{|err| errors.push(err.text)}
      page.all('.error', wait: 10).each{|err| errors.push(err.text)}
      return errors
    end

    def set_custom_tab(tab_name,path_name)
      page.all('input.environment_variable_name').each{|tab|
     if(tab.value.blank?)
        tab.set(tab_name)
     else
     end
      }
      page.all('input.environment_variable_value').each{|tab|
        if(tab.value.blank?)
           tab.set(tab_name)
        else
        end
      }
    end

    def tab_error(tab_index)
    page.find('tr:nth-child(1) .name .name_value_error').text
    end

    def set_run_type(run_type)
      page.find('label', text:run_type).sibling('input').click
    end

    def get_dropdown
      dropdown=[]
      page.all('.ac_results li').each{|list_item|
        dropdown.push(list_item.text)
      }
      return dropdown
    end

    def select_resouce_from_dropdown resource
      page.find('#job_resources').click
      page.find('.ac_results li',text:resource).click
    end

    def select_task task_no
      page.find("tr:nth-child(#{task_no.to_i}) td a").click
    end

    def move_down_task_number number
      page.find(".task_#{number} .promote_down").click
    end

    def move_up_task_number number
      page.find(".task_#{number} .promote_up").click
    end

    def override_job_time_out(time)
      page.find("#jobTimeout_override").click
      page.find("#job_timeout").set time
    end

    def total_tasks
       page.all('tbody tr').count
    end

    def toggle_source_file_option
      page.execute_script("document.getElementById('is_source_a_file').scrollIntoView(true)")
      page.find('.is_source_a_file').click
    end



  end
end
