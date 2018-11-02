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

step 'On Job settings page of pipeline <pipeline_name> stage <stage_name> job <job_name>' do |pipeline_name, stage_name, job_name|
  job_settings_page.load(pipeline_name: scenario_state.actual_pipeline_name(pipeline_name), stage_name: stage_name, job_name: job_name)
end

step 'Open <tab_id> tab - On Job settings page' do |tab_id|
  job_settings_page.on_tab(tab_id)
end

step 'Add artifact of type <type>' do |type|
  job_settings_page.publish_artifact_type.select type
  job_settings_page.add_artifact.click
end

step 'Start creating external artifact with values <key_value>' do |key_value|
  key_value.split(',').each do |field|
    publish_artifacts_view.fill_form(field)
  end
end

step 'Save external artifact with values <key_value>' do |key_value|
  key_value.split(',').each do |field|
    publish_artifacts_view.fill_form(field)
  end
  publish_artifacts_view.save_publish_artifacts.click
end

step 'Save artifact with values <key_value> at <index>' do |key_value,index|
  key_value.split(',').each do |field|
    publish_artifacts_view.fill_form_with_index(field,index)
  end
  publish_artifacts_view.save_publish_artifacts.click
end

step 'Add task <task_name>' do |task|
  job_settings_page.add_new_task.click
  job_settings_page.add_new_task_of_type task
end

step 'Move task <task_index> up' do |task_index|
  job_settings_page.move_task_up task_index
end

step 'Move task <task_index> down' do |task_index|
  job_settings_page.move_task_down task_index
end

step 'Select artifact type <a_type> pipeline <p_name> stage <s_name> job <j_name> artifact id <a_id> path <path>' do |a_type, p_name, s_name, j_name, a_id, path|
  job_settings_page.external_artifact.click
  job_settings_page.task_pipeline.set scenario_state.actual_pipeline_name(p_name)
  job_settings_page.task_stage.set s_name
  job_settings_page.task_job.set j_name
  job_settings_page.task_artifactId.set a_id
  job_settings_page.task_configuration_path.set path
end

step 'Save task details' do
  job_settings_page.task_save.click
end

step 'Set target to <target> with working directory <working_directory>' do |target,working_directory|
  job_settings_page.configure_rake_task(target,working_directory)
end

step 'Set on Cancel task <task> and command <command> - Already on Task edit popup' do |task,command|
  job_settings_page.configure_on_cancel_more_task(task,command)
end
step 'Set More task - Command as <command> argument as <arglist> working directory as <working_directory> runIfConditions as <run_conditions> - Already on Task edit popup' do |command,arglist,working_directory,run_conditions|
  job_settings_page.configure_more_task(command,arglist,working_directory,run_conditions)
end  

step 'verifyTask <table>' do |table|
  table.rows.each do |row| 
    (1..table.columns.length-1).each do |column_Header| 
      assert_true  job_settings_page.get_cell_value_from_table(row['Order_no'].to_i,row[table.columns[column_Header]],table.columns[column_Header])
    end
  end
end

step 'Delete task <task_no>' do |task_no|
  job_settings_page.delete_task(task_no)
end

step 'Verify no task with command <command> exists' do |command|
  assert_true  job_settings_page.verify_task_with_command_is_not_exists(command)
end

step 'Verify artifact with type as <type> source as <src> and destination as <dest>  exists for <job> in <stage>' do |type, src, dest, job,stage|
  artifact="#{type}:#{src}:#{dest}"
  assert_true  publish_artifacts_view.verify_artifact_exist(scenario_state.actual_pipeline_name(scenario_state.current_pipeline),artifact,stage,job)
end

step 'Verify no <task> task with command  <command> exists in <job> under <stage> for piepline <pipeline>' do |task,command,job,stage,pipeline|
   assert_true  job_settings_page.verify_task_with_command_is_not_exist_in_config(task,command,job,stage,pipeline)
end

step 'setTask <table>' do |table|
  table.rows.each do |row|
     job_settings_page.set_task(row['TaskType'],row['Target'],row['BuildFile'],row['WorkingDirectory'],row['RunIf-View'])
    end
end


step 'VerifyFieldsOnTaskList <table>' do |table|
      table.rows.each do |row|
      (1..table.columns.length-1).each do |column_name| 
      element=table.columns[column_name]
      job_settings_page.click_on_task_by_index(row['TaskIndex'].to_i)
      value=job_settings_page.send(element).value
      job_settings_page.task_cancel.click
      assert_equal row[table.columns[column_name]], value
    end
  end
end

step 'EditTaskWithOnCancel <table>' do |table|
    table.rows.each do |row|
    job_settings_page.click_on_task_by_index(row['TaskIndex'].to_i)
    job_settings_page.edit_task_with_on_cancel(row['task_build_file'],row['task_target'],row['task_working_directory'],row['On_Cancel_TaskType'],row['On_Cancel_Build_File'],row['On_Cancel_Target'],row['On_Cancel_Working_Dir'])
    end
end
