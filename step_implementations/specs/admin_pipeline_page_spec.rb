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

step 'On Admin page' do |_tmp|
  admin_pipeline_page.load
end

step 'Clone pipeline <pipeline_name> to <new_pipeline_name> in pipeline group <target_group>' do |pipeline_name, new_pipeline_name, pipeline_group_name|
  admin_pipeline_page.clone_pipeline(pipeline_name, new_pipeline_name, pipeline_group_name)
end

step 'Delete <pipeline_name>' do |pipeline|
  admin_pipeline_page.delete_pipeline(scenario_state.get(pipeline))
end

step 'Move pipeline <pipeline_name> from group <source_group> to group <destination_group>' do |pipeline, source_group, destination_group|
  admin_pipeline_page.move_pipeline(scenario_state.get(pipeline), source_group, destination_group)
end

step 'Verify there are <number_of_errors> errors' do |number_of_errors|
  admin_pipeline_page.verify_number_of_error_message number_of_errors
end

step 'Verify there are <number_of_warnings> warnings' do |number_of_warnings|
  admin_pipeline_page.verify_number_of_warnings number_of_warnings
end

step 'Wait till error message popup appears' do ||
  admin_pipeline_page.wait_till_error_popup_appears
end

step 'Verify message contains <message>' do |message|
  admin_pipeline_page.verify_error_message(message)
end

step 'Verify error description contains <message>' do |message|
  admin_pipeline_page.verify_error_description(message)
end

step 'Open error messages popup' do
  admin_pipeline_page.error_and_warning_count.click
end

step 'Verify there are no warnings' do
  admin_pipeline_page.verify_there_are_no_warnings
end

step 'Verify there are no error messages' do
  admin_pipeline_page.verify_there_are_no_error_messages
end

step 'Verify message do not contain <message>' do |message|
  admin_pipeline_page.verify_message_do_not_contains message
end

step 'Verify error description does not contain <message>' do |message|
  admin_pipeline_page.verify_error_description_do_not_contains message
end

step 'Close the error popup' do
  admin_pipeline_page.error_popup_ok_button.click
end
step 'Open config tab as group admin' do
  admin_pipeline_page.navigate_to('Config XML')
end

step 'Verify that extract template is enabled for <pipeline>' do |pipeline|
  scenario_state.put 'current_pipeline', pipeline
  assert_true admin_pipeline_page.pipeline_can_be_extracted? scenario_state.self_pipeline
end

step 'Verify that extract template is disabled for <pipeline>' do |pipeline|
  scenario_state.put 'current_pipeline', pipeline
  assert_true admin_pipeline_page.pipeline_extraction_disabled? scenario_state.self_pipeline
end

step 'Add new pipeline group' do ||
  admin_pipeline_page.add_pipeline_group
end
step 'Enter pipeline group name <group> - Already On New Pipeline Group Popup' do |group|
  admin_pipeline_page.add_group_name.set group
end

step 'Enter pipeline group name <group> - Already On Clone Pipeline pop up' do |group|
  admin_pipeline_page.set_group.set(group)
end

step 'Verify error message <message> - Already On New Pipeline Group Popup' do |message|
  assert_true job_settings_page.error_messages.include?message
end

step 'Verify groups <groups> are visible - on Admin Pipelines tab' do |groups|
   group_names=admin_pipeline_page.total_pipeline_groups
  groups.split(',').each{|group|
  assert_true group_names.include?group
 }  
end

step 'Verify <group> has pipelines <pipelines>' do |group,pipelines|
  pipelines_from_groups=admin_pipeline_page.get_pipelines_from(group)
  pipeline_names=[]
  pipelines.split(',').each{ |pipeline|
    if scenario_state.get(pipeline)==nil ? pipeline_names.push(pipeline) : pipeline_names.push(scenario_state.get(pipeline))
    end
    }
  pipeline_names.each{|pipeline|
  assert_true pipelines_from_groups.include?pipeline
  }
end

step 'Verify delete link is disabled for <group>' do |group|
 assert_true admin_pipeline_page.delete_link_is_disabled? group
end 

step 'Delete group <group>' do |group|
  admin_pipeline_page.delete_group(group)
end

step 'Verify groups <groups> are not visible - on Admin Pipelines tab' do |groups|
  group_names=admin_pipeline_page.total_pipeline_groups
  groups.split(',').each{|group|
   assert_false group_names.include?group
  }  
 end

step 'Delete pipeline <pipeline_name>' do |pipeline|
  admin_pipeline_page.delete_pipeline_from_group(pipeline)
 end

step 'Verify error message <message> - Already On Clone Pipeline Popup' do |message|
  assert_equal message, admin_pipeline_page.error_message_on_clone_window.text
end

step 'Enter pipeline name <pipeline>' do |pipeline|
  admin_pipeline_page.set_pipeline.set(pipeline)
end

step 'Verify <message> message is displayed' do |message|
  assert_true pipeline_settings_page.message_displayed?(message)
end

step 'Verify pipeline <pipeline> is paused with message <message>' do |pipeline, message|
  assert_true admin_pipeline_page.unpos_button_exist?(pipeline)
  assert_equal message, admin_pipeline_page.get_pos_discription
end

step 'Click clone button for pipeline <pipeline>' do |pipeline|
  pipeline_name=scenario_state.get(pipeline) || pipeline
  admin_pipeline_page.click_clone_button(pipeline_name)
end

step 'Verify can delete <pipelines>' do |pipelines|
  pipelines.split(',').each{|pipeline|
  assert_true admin_pipeline_page.delete_button_enabled?(scenario_state.get(pipeline))
  }
end

step 'Verify cannot delete <pipelines>' do |pipelines|
  pipelines.split(',').each{|pipeline|
  assert_false admin_pipeline_page.delete_button_enabled?(scenario_state.get(pipeline))
  }
end

step 'Verify <group> does not have pipelines <pipelines>' do |group,pipelines|
  pipelines_from_groups=admin_pipeline_page.get_pipelines_from(group)
  pipeline_names=[]
  pipelines.split(',').each{ |pipeline|
    ppl=scenario_state.get(pipeline)|| pipeline
    pipeline_names=pipeline_names.push(ppl)
  }
  pipeline_names.each{|pipeline|
  assert_false pipelines_from_groups.include?pipeline
  }
end

step 'Verify <group> has message <message>' do |group,message|
assert_true admin_pipeline_page.group_has_message?(group,message)
end

step 'Verify that template <template> has message <message>' do |template,message|
  assert_true admin_pipeline_page.template_has_message?(template,message)
 end

step 'Click to create a new pipeline to group <group>' do |group|
  admin_pipeline_page.add_new_pipeline_in_group(group)
end

step 'Verify that the edit button for pipeline <pipeline> is a link for edit pipeline' do |pipeline|
assert_true admin_pipeline_page.edit_link_exist_for_pipeline?(pipeline)
end

step 'Verify that move button is not present for <pipeline>' do |pipeline|
  assert_false admin_pipeline_page.move_button_exist_for_pipeline?(pipeline)
end

step 'Verify that <pipeline> cannot be moved to group <group>' do |pipeline,group|
  assert_false admin_pipeline_page.pipeline_moved_to_group_list(scenario_state.get(pipeline)).include?scenario_state.get(pipeline)
end 

step 'Adding <user> as a <type> user for group <group>' do |user,type,group|
  admin_pipeline_page.add_user_to_group(user,type,group)
end

step 'Adding <user> as a <type> role for group <group>' do |user,type,group|
  admin_pipeline_page.add_role_to_group(user,type,group)
end

step 'Verify pipeline group <group> has user <user> with <permissions> permissions' do |group,user,permissions|
  users=admin_pipeline_page.users_in_group()
  permissions=admin_pipeline_page.users_permissions_in_group(user)
  assert_true users.include?user
  permissions.each{|permission|
  assert_true permissions.include?permission
  }
end

step 'Verify pipeline group <group> has role <role> with <permission> permissions' do |group,role,permissions|
  roles=admin_pipeline_page.roles_in_group()
  permissions=admin_pipeline_page.roles_permissions_in_group(role)
  assert_true roles.include?role
  permissions.each{|permission|
  assert_true permissions.include?permission
  }
end

step 'Verify pipeline group <group> does not have user <user>' do |group,user|
  users=admin_pipeline_page.users_in_group()
  assert_false users.include?user 
end

step 'Verify pipeline group <group> does not have role <role>' do |group,role|
  roles=admin_pipeline_page.roles_in_group()
  assert_false roles.include?role
end

step 'Delete user <user> -on edit group page' do |user|
  admin_pipeline_page.delete_user_on_edit_group(user)
end

step 'Delete role <user> -on edit group page' do |role|
  admin_pipeline_page.delete_role_on_edit_group(role)
end

step 'Set group name as <group>' do |group|
  admin_pipeline_page.edit_group_name.set group
end

step 'Verify tabs <tabs> are visible' do |tabs|
  tabs.split(',').each { |tab|
  assert_true admin_pipeline_page.tab_is_visible?(tab)
  }
end

step 'Verify tabs <tabs> are not visible' do |tabs|
  tabs.split(',').each { |tab|
  assert_false admin_pipeline_page.tab_is_visible?(tab)
  }
end  

step 'Open <tab> tab' do |tab|
  admin_pipeline_page.open_tab tab
end

step 'Verify that templates <tmplates> are present - on Admin Templates tab' do |templates|
  template_names=admin_pipeline_page.total_templates
  templates.split(',').each{|template|
 assert_true template_names.include?template
}  
end

step 'Verify that template <template> is used by pipelines <pipeline>' do |template,pipelines|
  pipelines_from_template=admin_pipeline_page.get_pipelines_from_templates(template)
  pipeline_names=[]
  pipelines.split(',').each{ |pipeline|
    if scenario_state.get(pipeline)==nil ? pipeline_names.push(pipeline) : pipeline_names.push(scenario_state.get(pipeline))
    end
    }
  pipeline_names.each{|pipeline|
  assert_true pipelines_from_template.include?pipeline
  }
end

step 'Verify that edit pipeline <pipeline> lands on pipeline edit page' do ||
  admin_pipeline_page.click_edit_pipeline pipeline
  assert_true admin_pipeline_page.click_edit_pipeline pipeline
end

step 'Verify cannot delete templates <templates>' do |templates|
  templates.each{ |template|
    assert_true admin_pipeline_page.delete_link_is_disabled_for_template? template
  }
end

step 'Verify can delete templates <templates>' do |templates|
  templates.each{ |template|
    assert_false admin_pipeline_page.delete_link_is_disabled_for_template? template
  }
end 

step 'Delete template <template>' do |template|
  admin_pipeline_page.delete_template template
end
step 'Verify that templates <tmplates> are not present - on Admin Templates tab' do |templates|
  template_names=admin_pipeline_page.total_templates
  templates.split(',').each{|template|
 assert_false template_names.include?template
}  
end

step 'Verify templates tab is visible' do ||
  admin_pipeline_page.template_tab_is_visible?
end