##########################################################################
# Copyright 2019 ThoughtWorks, Inc.
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

step 'On Admin pipeline page' do |_tmp|
  admin_pipeline_page.load
end

step 'Clone pipeline <pipeline_name> to <new_pipeline_name> in pipeline group <target_group>' do |pipeline_name, new_pipeline_name, pipeline_group_name|
  admin_pipeline_page.clone_pipeline(scenario_state.get(pipeline_name), new_pipeline_name, pipeline_group_name)
end

step 'Delete <pipeline_name>' do |pipeline|
  admin_pipeline_page.delete_pipeline(scenario_state.get(pipeline).nil? ? pipeline : scenario_state.get(pipeline))
end

step 'Move pipeline <pipeline_name> from group <source_group> to group <destination_group>' do |pipeline, source_group, destination_group|
  admin_pipeline_page.move_pipeline(scenario_state.get(pipeline), source_group, destination_group)
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

step 'Add new pipeline group' do
  admin_pipeline_page.add_pipeline_group
end

step 'Enter pipeline group name <group> - Already On New Pipeline Group Popup' do |group|
  admin_pipeline_page.input_pipeline_group_name.set group
end

step 'Enter pipeline group name <group> - Already On Clone Pipeline pop up' do |group|
  admin_pipeline_page.input_pipeline_group_name.set(group)
end

step 'Verify error message <message> - Already On New Pipeline Group Popup' do |message|
  assert_true job_settings_page.error_messages.include? message
end

step 'Verify groups <groups> are visible - on Admin Pipelines tab' do |groups|
  group_names = admin_pipeline_page.all_pipeline_groups
  groups.split(',').each do |group|
    assert_true group_names.include? group.downcase
  end
end

step 'Verify <group> has pipelines <pipelines>' do |group, pipelines|
  pipelines_from_groups = admin_pipeline_page.get_pipelines_from(group)
  p                     = pipelines.split(',').map {|pipeline| scenario_state.get(pipeline.strip).nil? ? pipeline.strip : scenario_state.get(pipeline)}
  assert_true (p & pipelines_from_groups) == p
end

step 'Verify delete link is disabled for <group>' do |group|
  assert_true admin_pipeline_page.delete_link_is_disabled? group
end

step 'Delete group <group>' do |group|
  admin_pipeline_page.delete_group(group)
end

step 'Verify groups <groups> are not visible - on Admin Pipelines tab' do |groups|
  group_names = admin_pipeline_page.all_pipeline_groups
  groups.split(',').each do |group|
    assert_false group_names.include? group
  end
end

step 'Delete pipeline <pipeline_name>' do |pipeline|
  admin_pipeline_page.delete_pipeline_from_group(scenario_state.get(pipeline))
end

step 'Verify error message <message> - Already On Clone Pipeline Popup' do |message|
  assert_true admin_pipeline_page.error_message_on_clone_window(message)
end

step 'Enter pipeline name <pipeline>' do |pipeline|
  admin_pipeline_page.input_new_pipeline_name.set(pipeline)
end

step 'Verify <message> message is displayed' do |message|
  assert_true pipeline_settings_page.message_displayed?(message)
end

step 'Verify pipeline <pipeline> is paused with message <message>' do |pipeline, message|
  assert_true admin_pipeline_page.unpos_button_exist?(pipeline)
  assert_equal message, admin_pipeline_page.get_pos_discription
end

step 'Click clone button for pipeline <pipeline>' do |pipeline|
  pipeline_name = scenario_state.get(pipeline) || pipeline
  admin_pipeline_page.click_clone_button(pipeline_name)
end

step 'Save Cloning' do ||
  admin_pipeline_page.save_clone
end

step 'Save template' do ||
  admin_pipeline_page.button_extract_template.click
end

step 'Save group create' do ||
  admin_pipeline_page.button_create.click
end

step 'Verify can delete <pipelines>' do |pipelines|
  pipelines.split(',').each do |pipeline|
    assert_true admin_pipeline_page.delete_button_enabled?(scenario_state.get(pipeline))
  end
end

step 'Verify cannot delete <pipelines>' do |pipelines|
  pipelines.split(',').each do |pipeline|
    assert_false admin_pipeline_page.delete_button_enabled?(scenario_state.get(pipeline))
  end
end

step 'Verify <group> does not have pipelines <pipelines>' do |group, pipelines|
  pipelines_from_groups = admin_pipeline_page.get_pipelines_from(group)
  pipeline_names        = []
  pipelines.split(',').each do |pipeline|
    ppl            = scenario_state.get(pipeline) || pipeline
    pipeline_names = pipeline_names.push(ppl)
  end
  pipeline_names.each do |pipeline|
    assert_false pipelines_from_groups.include? pipeline
  end
end

step 'Verify <group> has message <message>' do |group, message|
  assert_true admin_pipeline_page.group_has_message?(group, message)
end

step 'Click to create a new pipeline to group <group>' do |group|
  admin_pipeline_page.add_new_pipeline_in_group(group)
end

step 'Verify that the edit button for pipeline <pipeline> is a link for edit pipeline' do |pipeline|
  assert_true admin_pipeline_page.edit_link_exist_for_pipeline?(scenario_state.get(pipeline))
end

step 'Verify that move button is not present for <pipeline>' do |pipeline|
  assert_false admin_pipeline_page.move_button_exist_for_pipeline?(scenario_state.get(pipeline))
end

step 'Verify that <pipeline> cannot be moved to group <group>' do |pipeline, _group|
  assert_false admin_pipeline_page.pipeline_moved_to_group_list(scenario_state.get(pipeline)).include? scenario_state.get(pipeline)
end

step 'Adding <user> as a <type> user' do |user, type|
  admin_pipeline_page.add_user_permissions(user, type)
end

step 'Update <user> as a <type> user' do |user, type|
  admin_pipeline_page.update_user_permissions(user, type)
end

step 'Adding <user> as a <type> role' do |user, type|
  admin_pipeline_page.add_role_permissions(user, type)
end

step 'Verify pipeline group <group> has user <user> with <permissions> permissions' do |_group, user, permissions|
  users       = admin_pipeline_page.users_in_group
  permissions = admin_pipeline_page.users_permissions_in_group(user)
  assert_true users.include?(user), "Actual set of users #{users.join(',')}"
  permissions.each do |permission|
    assert_true permissions.include?(permission), "Actual permissions for user #{user} are #{permissions.join(',')}"
  end
end

step 'Verify pipeline group <group> has role <role> with <permission> permissions' do |_group, role, permissions|
  roles       = admin_pipeline_page.roles_in_group
  permissions = admin_pipeline_page.roles_permissions_in_group(role)
  assert_true roles.include? role
  permissions.each do |permission|
    assert_true permissions.include? permission
  end
end

step 'Verify pipeline group <group> does not have user <user>' do |_group, user|
  users = admin_pipeline_page.users_in_group
  assert_false users.include? user
end

step 'Verify pipeline group <group> does not have role <role>' do |_group, role|
  roles = admin_pipeline_page.roles_in_group
  assert_false roles.include? role
end

step 'Delete user <user> -on edit group page' do |user|
  admin_pipeline_page.delete_user_on_edit_group(user)
end

step 'Delete role <user> -on edit group page' do |role|
  admin_pipeline_page.delete_role_on_edit_group(role)
end

step 'Set group name as <group> - on edit group page' do |group|
  admin_pipeline_page.set_group_name group
end

step 'Verify tabs <tabs> are visible' do |tabs|
  tabs.split(',').each do |tab|
    assert_true admin_pipeline_page.tab_is_visible?(tab)
  end
end

step 'Verify tabs <tabs> are not visible' do |tabs|
  tabs.split(',').each do |tab|
    assert_false admin_pipeline_page.tab_is_visible?(tab)
  end
end

step 'Open <tab> tab' do |tab|
  admin_pipeline_page.open_tab tab
end

step 'Open template <template>' do |template|
  admin_pipeline_page.open_template template
end

step 'Verify templates tab is visible' do
  admin_pipeline_page.template_tab_is_visible?
end

step 'Edit template <template>' do |template|
  admin_pipeline_page.edit_template template
end

step 'Click edit Config XML' do
  admin_pipeline_page.edit_config
end

step 'Change config to conflict' do
  admin_pipeline_page.change_cofig_to_conflict
end

step 'Rename pipeline <pipeline> to <new_pipeline> - Already On Pipeline Group Xml' do |pipeline, new_pipeline|
  admin_pipeline_page.rename_pipeline_on_config_xml_page scenario_state.get(pipeline), new_pipeline
end

step 'Verify that split pane appears' do
  admin_pipeline_page.verify_split_appears
end

step 'Add downstream pipeline to create post validation conflict' do
  admin_pipeline_page.add_downstream_pipeline_to_create_post_validations
end

step 'Verify post validation error is shown with message <message>' do |message|
  assert_true admin_pipeline_page.post_validation_error_message_exist? message
end

step 'Verify pipeline selection dropdown is disabled and has value <pipeline>' do |pipeline|
  assert_true admin_pipeline_page.extractable_disabled_pipeline.include? scenario_state.get(pipeline)
end

step 'Verify pipeline uses template <template>' do |template|
  assert_true admin_pipeline_page.has_template? template
end

step 'Verify extract template checkbox is disabled & checked' do
  assert_true admin_pipeline_page.extract_from_pipeline.checked?
  assert_true admin_pipeline_page.extract_from_pipeline.disabled?
end

step 'Enter template name <template> - On template popup' do |template|
  admin_pipeline_page.enter_template_name template
end

step 'Extract template for pipeline <pipeline>' do |pipeline|
  admin_pipeline_page.click_extract_template scenario_state.get(pipeline)
end

step 'Edit pipeline group <group> on pipeline page' do |grp|
  admin_pipeline_page.edit_pipeline_group grp
end

step "Edit pipeline group <group>" do |grp|
  new_pipeline_group_page.edit_pipeline_group(grp)
end

step 'Save pipeline group' do
  admin_pipeline_page.save_pipeline_grp
end

step 'Verify flash message for pipeline group <message>' do |message|
  assert_true admin_pipeline_page.flash_message.text.include? message
end

step 'Verify top level error message <message> is present' do |message|
  assert_true admin_pipeline_page.error_message.text.include? message
end

step 'Verify roles level error message <message> is present' do |message|
  assert_true admin_pipeline_page.roles_error_message.text.include? message
end

step 'Delete user permission <user>' do |user|
  admin_pipeline_page.delete_user_permission(user)
end

step 'Delete role permission <role>' do |role|
  admin_pipeline_page.delete_role_permission(role)
end
