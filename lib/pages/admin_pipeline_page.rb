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

module Pages
  class AdminPipelinePage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/pipelines"

    element :create_new_pipeline_group, "[data-test-id='create-new-pipeline-group']"
    element :all_pipeline_groups, "[data-test-id='pipeline-groups']"
    element :input_new_pipeline_name, "[data-test-id='form-field-input-new-pipeline-name']"
    element :input_pipeline_group_name, "[data-test-id='form-field-input-pipeline-group-name']"
    element :button_clone, "[data-test-id='button-clone']"
    element :pipeline_group_selection, "[data-test-id='move-pipeline-group-selection']"
    element :button_move, "[data-test-id='button-move']"
    element :button_delete, "[data-test-id='button-delete']"
    element :button_create, "[data-test-id='button-create']"
    element :button_extract_template, "[data-test-id='button-extract-template']"
    element :flash_message, "[data-test-id='flash-message-success']"

    element :group_name, "input[data-test-id='form-field-input-pipeline-group-name']"
    element :save, "button[data-test-id='save-pipeline-group']"
    element :add_user_permission, "button[data-test-id='add-user-permission']"
    element :add_role_permission, "button[data-test-id='add-role-permission']"
    element :users_permissions, "table[data-test-id='users-permissions']"
    element :roles_permissions, "table[data-test-id='roles-permissions']"
    element :error_message, "[data-test-id='pipeline-group-flash-message']"
    element :roles_error_message, "[data-test-id='errors-on-roles']"

    load_validation {has_create_new_pipeline_group?}

    def clone_pipeline(source_pipeline_name, new_pipeline_name, pipeline_group_name)
      click_on_clone_link_for(source_pipeline_name)
      input_new_pipeline_name.set new_pipeline_name
      input_pipeline_group_name.set pipeline_group_name
      button_clone.click(wait: 10)
    end

    def save_clone
      wait_till_event_occurs_or_bomb 20, "Save Clone button is disabled" do
        break unless button_clone.disabled?
      end
      button_clone.click
    end

    def delete_pipeline(pipeline)
      page.find("[data-test-id='delete-pipeline-#{pipeline}']").click
      button_delete.click
    end

    def move_pipeline(pipeline, _source_group, destination_group)
      page.find("[data-test-id='move-pipeline-#{pipeline}']").click
      pipeline_group_selection.select destination_group
      button_move.click
    end

    def navigate_to(tab)
      page.find('.sub_tabs_container').find('a', text: tab).click
    end

    def pipeline_can_be_extracted?(pipeline)
      !page.find("[data-test-id='extract-template-from-pipeline-#{pipeline.downcase}']").disabled?
    end

    def pipeline_extraction_disabled?(pipeline)
      page.find("[data-test-id='extract-template-from-pipeline-#{pipeline.downcase}']").disabled?
    end

    def add_pipeline_group
      create_new_pipeline_group.click
    end

    def all_pipeline_groups
      group_names = []
      page.all("[data-test-id^='pipeline-group-name-']").each do |group|
        group_names << group['data-test-id'].gsub('pipeline-group-name-', '')
      end
      group_names
    end

    def get_pipelines_from(group)
      pipelines = []
      page.find("[data-test-id='pipeline-group-#{group.downcase}']").all("[data-test-id^='pipeline-name']").each do |pipeline|
        pipelines << pipeline['data-test-id'].gsub('pipeline-name-', '')
      end
      pipelines
    end

    def delete_link_is_disabled?(group)
      page.find("[data-test-id='delete-pipeline-group-#{group.downcase}']").disabled?
    end

    def delete_group(group)
      page.find("[data-test-id='delete-pipeline-group-#{group.downcase}']").click
      button_delete.click
    end

    def delete_pipeline_from_group(pipeline)
      page.find("[data-test-id='delete-pipeline-#{pipeline.downcase}']").click
      button_delete.click
    end

    def verify_group_has_pipeline(group, pipeline)
      page.find("[data-test-id='pipeline-group-#{group.downcase}']").has_css?("[data-test-id='pipeline-#{pipeline.downcase}']")
    end

    def click_clone_button(pipeline)
      page.find("[data-test-id='clone-pipeline-#{pipeline.downcase}']").click
    end

    def error_message_on_clone_window(message)
      page.has_css?('span', text: message)
    end

    def unpos_button_exist?(pipeline)
      page.has_css?("button#unpause-#{pipeline}")
    end

    def get_pos_discription
      page.find('.pause_description.paused_by').text
    end

    def delete_button_enabled?(pipeline)
      !page.find("[data-test-id='delete-pipeline-#{pipeline.downcase}']").disabled?
    end

    def group_has_message?(group, message)
      page.find("[data-test-id='pipeline-group-#{group.downcase}']").has_css?("[data-test-id='flash-message-info'] p", text: message)
    end

    def add_new_pipeline_in_group(group)
      page.find("[data-test-id='pipeline-group-#{group.downcase}']").find("[data-test-id='create-pipeline-in-group-#{group.downcase}']").click
    end

    def edit_link_exist_for_pipeline?(pipeline)
      page.has_css?("[data-test-id='edit-pipeline-#{pipeline.downcase}']")
    end

    def move_button_exist_for_pipeline?(pipeline)
      page.has_css?("[data-test-id='move-pipeline-#{pipeline.downcase}']")
    end

    def pipeline_moved_to_group_list(pipeline)
      page.find("[data-test-id='move-pipeline-#{pipeline.downcase}']").click
      groups = page.find("[data-test-id='move-pipeline-group-selection']").all('option').collect(&:text)
      page.all("button").select {|btn| btn['class'].include? 'overlay-close'}.first.click
      groups
    end

    def users_in_group()
      users = []
      page.all('[data-test-id="user-name"]').each {|element|
        users.push(element.value) if !element.value.blank?
      }
      return users;
    end

    def roles_in_group()
      roles = []
      page.all('[data-test-id="role-name"]').each {|element|
        roles.push(element.value) if !element.value.blank?
      }
      return roles;
    end

    def users_permissions_in_group(user)
      permissions = []
      user_row = page.all('[data-test-id="user-name"]').select {|u| u if u.value == user}.first.ancestor('[data-test-id="table-row"]')
      user_row.all('[data-test-id$="-permission"]').each {|element|
        permissions.push(element['data-test-id'].split('-').first) if !element.checked?
      }
      return permissions
    end

    def roles_permissions_in_group(role)
      permissions = []
      page.all("tr#ROLE_#{role} td input[type=checkbox]").each {|element|
        permissions.push(element[:name]) if !element.checked?
      }
      return permissions
    end

    def delete_user_on_edit_group(user)
      page.find("tr#USER_#{user} td span.remove_icon").click
    end

    def delete_role_on_edit_group(role)
      page.find("tr#ROLE_#{role} td span.remove_icon").click
    end

    def tab_is_visible?(tab)
      page.has_css?('.sub_tabs_container ul li a', text: tab)
    end

    def open_tab tab
      page.find('.sub_tabs_container').find('a', text: tab).click
    end

    def open_template template
      page.find('a.edit_template', text: template).click
    end

    def click_edit_pipeline pipeline
      page.find("[data-test-id='edit-pipeline-#{pipeline.downcase}']").click
    end

    def landed_on_pipeline_edit_page? pipeline
      page.find('.pipeline_header').has_css?('a', text: pipeline)
    end

    def template_tab_is_visible?
      page.has_css?('#tab-link-of-templates')
    end

    def edit_template template
      page.find("[data-test-id='edit-template-#{template.downcase}']").click
    end

    def change_cofig_to_conflict
      context = page.find('#content').text.gsub! 'replace-job', 'replace-job-conflict'
      page.find('#content').set context
    end

    def rename_pipeline_on_config_xml_page pipeline, new_pipeline
      new_context = page.find('#content_container_for_edit').text.gsub! "#{pipeline}", new_pipeline
      page.find('#content_container_for_edit').set new_context
    end

    def verify_split_appears
      assert_true page.has_css?('.conflicted_content')
      assert_true page.has_css?('.current_content')
    end

    def add_downstream_pipeline_to_create_post_validations
      context     = %Q(<pipeline name="downstream-pipeline">\n <materials>\n <pipeline pipelineName= "#{scenario_state.get('upstream-pipeline')}"
                   stageName="defaultStage" materialName="UP" />\n </materials>\n <stage name="defaultStage">\n <approval type="manual"/>\n <jobs>\n <job name="replace-job">
                   \n <tasks>\n <exec command="ls"/>\n </tasks>\n </job>\n </jobs>\n </stage>\n </pipeline>\n </pipelines>)
      new_context = page.find('#content').text.sub! "</pipelines>", context
      page.find('#content').set new_context
    end

    def post_validation_error_message_exist? message

      errors = []
      page.all('.error').each {|error|
        errors.push(error.text)}
      errors.include? new_pipeline_dashboard_page.sanitize_message(message)
    end

    def edit_config
      page.find('a.link_as_button', text: 'EDIT').click
    end

    def extractable_disabled_pipeline
      page.find('select#pipeline_pipelineNames').all('option').collect(&:text)
    end

    def has_template? template
      page.has_css?('a.edit_template', text: template)
    end

    def click_extract_template pipeline
      page.find("[data-test-id='extract-template-from-pipeline-#{pipeline.downcase}']").click
    end

    def enter_template_name name
      page.find("[data-test-id='form-field-input-new-template-name']").set name
    end

    def set_group_name(grp_name)
      group_name.set grp_name
    end

    def edit_pipeline_group(grp_name)
      data_test = "edit-pipeline-group-#{grp_name}"
      page.find("button[data-test-id='#{data_test}']").click
    end

    def save_pipeline_grp
      save.click
    end

    def add_user_permissions(user, type)
      add_user_permission.click
      users_permissions.all("input[data-test-id='user-name']").last.set(user)
      users_permissions.all("input[data-test-id='#{type}-permission']").last.set(true)
    end

    def update_user_permissions(user, type)
      users_permissions.all("tbody tr").each do |widget|
        if widget.find("input[data-test-id='user-name']").text === user
          widget.find("input[data-test-id='#{type}-permission']").set(true)
        end
      end
    end

    def add_role_permissions(role, type)
      add_role_permission.click
      roles_permissions.all("input[data-test-id='role-name']").last.set(role)
      roles_permissions.all("input[data-test-id='#{type}-permission']").last.set(true)
    end

    def delete_user_permission(user)
      user_row = page.all('[data-test-id="user-name"]').select {|u| u if u.value == user}.first.ancestor('[data-test-id="table-row"]')
      user_row.find("[data-test-id='user-permission-delete']").click
    end

    def delete_role_permission(role)
      role_row = page.all('[data-test-id="role-name"]').select {|r| r if r.value == role}.first.ancestor('[data-test-id="table-row"]')
      role_row.find("[data-test-id='role-permission-delete']").click
    end

    private

    def row_for_pipeline(pipeline)
      pipeline_link = pipeline_link text: pipeline
      pipeline_link.first(:xpath, './/../..')
    end

    def click_on_clone_link_for(pipeline)
      page.find("[data-test-id='clone-pipeline-#{pipeline}']").click
    end
  end
end
