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
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/pipelines{/pipeline_name}/edit#!{pipeline_name}{/stage_name}{/job_name}/tasks"

    element :add_new_task, 'button[data-test-id="add-task-button"]'
    element :new_task_list, 'select[data-test-id="form-field-input-"]'
    element :external_artifact, 'input[data-test-id="radio-external"]'
    element :task_pipeline, 'input[data-test-id="form-field-input-pipeline"]'
    element :task_stage, 'input[data-test-id="form-field-input-stage"]'
    element :task_job, 'input[data-test-id="form-field-input-job"]'
    element :task_artifact_id, 'input[data-test-id="form-field-input-artifact-id"]'
    element :task_configuration_path, 'input[ng-model="Path"]'
    element :publish_artifact_type, 'select[data-test-id="form-field-input-"]'
    element :add_artifact, 'button[data-test-id="add-artifact-button"]'
    element :artifact_source, '.artifact_source'
    element :artifact_id, 'input[data-test-id="artifact-id-"]'
    element :store_id, 'select[data-test-id="artifact-store-id"]'
    element :task_working_directory, 'input[data-test-id="form-field-input-working-directory"]'
    element :task_target, "input[name='task[target]']"
    element :argument, 'textarea[data-test-id="form-field-input-arguments"]'
    element :advance_option_task_type, ".on_cancel_type.MB_focusable option"
    element :on_cancel_task_check_box, 'input[data-test-id="form-field-input-on-cancel-task"]'
    element :tasks_list, "table.tasks_list_table"
    element :task_build_file, "input[name='task[buildFile]']"
    element :task_commands, 'input[data-test-id="form-field-input-command"]'
    element :task_cancel, ".close_modalbox_control"
    element :job_name, "#job_name"
    element :set_never, 'input[data-test-id="radio-never"]'
    element :resources_on_popup, '#job_resources'
    element :task_source_file, "input[name='task[src]']"
    element :task_dest_dir, "input[name='task[dest]']"

    load_validation {has_add_new_task?}


    def on_tab(tab_name)
      page.find('a', text: tab_name.upcase).click
    end

    def add_new_task_of_type(type)
      new_task_list.select type
      add_new_task.click
    end

    def configure_rake_task(target, working_directory)
      task_target.set(target)
      task_working_directory.set(working_directory)
    end

    def configure_more_task(command, arglist, working_directory, run_conditions)
      task_commands.set(command)
      argument.set(arglist)
      task_working_directory.set(working_directory)
      if run_conditions === ""
        page.find("input[data-test-id='form-field-input-passed']").set(false)
      else
        run_conditions.split(',').each {|run_condition|
          page.find("input[data-test-id='form-field-input-#{run_condition.downcase}']").set(true)
        }
      end
    end

    def configure_on_cancel_more_task(task, command)
      on_cancel_task_check_box.click
      cancel_body = page.find('div[data-test-id="on-cancel-body"]')
      cancel_body.find('select[data-test-id="form-field-input-"]').select task
      cancel_body.find('input[data-test-id="form-field-input-command"]').set(command)
    end

    def get_cell_value_from_table(row_count, column_name, header_name)
      table_row = page.find("div[data-test-id='tasks-container'] table tr[data-id='#{row_count.to_i - 1}']")
      case column_name
      when "Task Type"
        return table_row.find("td:nth-child(2)").text.eql?(header_name)
      when "Run If Conditions"
        return table_row.find("td:nth-child(3)").text.eql?(header_name)
      when "Properties"
        properties = table_row.find("td:nth-child(4)")
        header_name.split(',').each do |key_value|
          vals   = key_value.split(':')
          result = properties.find("span[data-test-id='key-value-value-#{vals[0].strip.downcase}']").text.eql?(vals[1].strip)
          unless result
            return false
          end
        end
        return true
      when "On Cancel"
        return table_row.find("td:nth-child(5)").text.eql?(header_name)
      else
        return false
      end
    end

    def delete_task (task_no)
      page.find("i[data-test-id='task-#{task_no.to_i - 1}-delete-icon']").click
      page.find("button[data-test-id='primary-action-button']").click
    end

    def verify_task_with_command_is_not_exists(command)
      page.has_no_css?('li.task_property.command span.value', text: command.split(':').last.strip)
    end

    def verify_task_with_command_is_not_exist_in_config(task, command, job, stage, pipeline)
      basic_configuration.get_config_from_server.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.get(pipeline)}']/stage[@name='#{stage}']/jobs/job[@name='#{job}']/tasks/#{task}[@command='#{command}']").count == 0
    end

    def move_task_down(task_index)
      tasks_list.find("tbody tr.task_#{task_index} button.promote_button .promote_down").ancestor('button.promote_button').click
    end

    def move_task_up(task_index)
      tasks_list.find("tbody tr.task_#{task_index} button.promote_button .promote_up").ancestor('button.promote_button').click
    end

    def set_task(task_type, target, build_file, working_directory, run_if_list)
      add_new_task.click
      (new_task_list wait: 20).find('a', text: task_type, exact_text: true).click
      task_target.set(target)
      task_build_file.set(build_file)
      task_working_directory.set(working_directory)
      run_if_list.split(',').each {|run_condition|
        page.find("input[name='task[runIfConfigs#{run_condition}]']").set(true)}
      general_settings_page.task_save.click
    end

    def click_on_task_by_index(row_count)
      page.find(".tasks_list_table tr:nth-child(#{row_count.to_i}) td:nth-child(2) a").click
    end

    def edit_task_with_on_cancel(build_file, target, working_directory, cancel_task_type, cancel_build_file, cancel_Target, cancel_working_Dir)

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
      __binding__.pry
      errors = []
      page.all('.form_error', wait: 10).each {|err| errors.push(err.text)}
      page.all('.error', wait: 10).each {|err| errors.push(err.text)}
      return errors
    end

    def set_custom_tab(tab_name, path_name)
      page.all('input.environment_variable_name').each {|tab|
        if (tab.value.blank?)
          tab.set(tab_name)
        else
        end
      }
      page.all('input.environment_variable_value').each {|tab|
        if (tab.value.blank?)
          tab.set(tab_name)
        else
        end
      }
    end

    def tab_error(tab_index)
      page.find('tr:nth-child(1) .name .name_value_error').text
    end

    def set_run_type(run_type)
      page.find('label', text: run_type).sibling('input').click
    end

    def get_dropdown
      dropdown = []
      page.all('.ac_results li').each {|list_item|
        dropdown.push(list_item.text)
      }
      return dropdown
    end

    def select_resouce_from_dropdown resource
      page.find('#job_resources').click
      page.find('.ac_results li', text: resource).click
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

    def error_message_for_working_dir()
      task_working_directory
          .sibling('span[class*="forms__form-error-text___"]')
          .text
    end

    def fill_external_form(key_value)
      vals   = key_value.split(':', 2)
      parent = page.find('div[data-test-id="external-artifact-view"]')
      parent.find("input[ng-model=\"#{vals[0].strip}\"]").set vals[1].strip
    end

    def fill_form(type, key_value)
      vals   = key_value.split(':', 2)
      parent = page.find("div[data-test-id='#{type}-artifact-view']")
      parent.find("input[data-test-id='artifact-#{vals[0].strip}-']").set vals[1].strip
    end

  end
end
