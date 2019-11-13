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
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/pipeline_new"

    element :create_new_pipeline_group, "[data-test-id='create-new-pipeline-group']"
    element :all_pipeline_groups, "[data-test-id='pipeline-groups']"
    element :new_pipeline_name, "[data-test-id='form-field-input-new-pipeline-name']"
    element :pipeline_group_name, "[data-test-id='form-field-input-pipeline-group-name']"
    element :button_clone, "[data-test-id='button-clone']"
    element :pipeline_group_selection, "[data-test-id='move-pipeline-group-selection']"
    element :button_move, "[data-test-id='button-move']"
    element :button_delete, "[data-test-id='button-delete']"

    load_validation { has_create_new_pipeline_group? }

    def clone_pipeline(source_pipeline_name, new_pipeline_name, pipeline_group_name)
      click_on_clone_link_for(source_pipeline_name)
      new_pipeline_name.set new_pipeline_name
      pipeline_group_name.set pipeline_group_name
      button_clone.click
    end

    def delete_pipeline(pipeline)
      all_pipeline_groups.find("[data-test-id='delete-pipeline-#{pipeline}']").click
    end

    def move_pipeline(pipeline, _source_group, destination_group)
      all_pipeline_groups.find("[data-test-id='move-pipeline-#{pipeline}']").click
      pipeline_group_selection.select destination_group
      button_move.click
    end

    def navigate_to(tab)
      page.find('.sub_tabs_container').find('a', text: tab).click
    end

    def pipeline_can_be_extracted?(pipeline)
      !all_pipeline_groups.find("[data-test-id='extract-template-from-pipeline-#{pipeline}']").disabled?
    end

    def pipeline_extraction_disabled?(pipeline)
      all_pipeline_groups.find("[data-test-id='extract-template-from-pipeline-#{pipeline}']").disabled?
    end

    def add_pipeline_group
      create_new_pipeline_group.click
    end

    def total_pipeline_groups
      all_pipeline_groups.all('div').count
    end

    def get_pipelines_from(group)
      pipelines = []
      all_pipeline_groups.all('div').each do |pipeline|
        pipelines < pipeline.attribute('data-test-id').split('-').last
      end
      pipelines
    end

    def get_pipelines_from_templates(template)
      pipelines = []
      page.find('h2.group_name', text: template).ancestor('.template_group').sibling('.grouping_content_wrapper').all('td.name a').each do |pipeline|
        pipelines.push(pipeline.text)
      end
      pipelines
    end

    def delete_link_is_disabled?(group)
      all_pipeline_groups.find("[data-test-id='delete-pipeline-group-#{group}']").disabled?
    end

    def delete_link_is_disabled_for_template? template
      page.find('h2.group_name', text: template).sibling('.title_action_wrapper').has_css?('.delete_icon_disabled')
    end

    def delete_template template
      page.find("span#trigger_delete_#{template}").click
      page.find("button[value='Proceed']").click
    end

    def delete_group(group)
      page.find("data-test-id='delete-pipeline-group-#{group}'").click
      button_delete.click
    end

    def delete_pipeline_from_group(pipeline)
      page.find("data-test-id='delete-pipeline-#{pipeline}'").click
      button_delete.click
    end

    def verify_group_has_pipeline(group, pipeline)
      all_pipeline_groups.find("data-test-id='pipeline-group-#{group}'").has_css?("data-test-id='pipeline-#{pipeline}'")
    end

    def click_clone_button(pipeline)
      page.find("data-test-id='clone-pipeline-#{pipeline}'").click
    end

    def unpos_button_exist?(pipeline)
      page.has_css?("button#unpause-#{pipeline}")
    end

    def get_pos_discription
      page.find('.pause_description.paused_by').text
    end

    def delete_button_enabled?(pipeline)
      !all_pipeline_groups.find("[data-test-id='delete-pipeline-#{pipeline}']").disabled?
    end

    def group_has_message?(group, message)
      page.find("data-test-id='pipeline-group-#{group}'").find("data-test-id='flash-message-info'", text: message)
    end

    def template_has_message?(template,message)
      page.find('h2.group_name', text: template).ancestor('.template').has_css?('.information', text: message)
    end

    def add_new_pipeline_in_group(group)
      page.find("data-test-id='pipeline-group-#{group}'").find("data-test-id='create-pipeline-in-group-#{group}'").click
    end

    def edit_link_exist_for_pipeline?(pipeline)
      page.has_css?("data-test-id='edit-pipeline-#{pipeline}")
    end

    def move_button_exist_for_pipeline?(pipeline)
      page.has_css?("data-test-id='move-pipeline-#{pipeline}")
    end

    def pipeline_moved_to_group_list(pipeline)
      page.find("data-test-id='move-pipeline-#{pipeline}'").click
      groups = page.find("data-test-id='move-pipeline-group-selection'").all('option').collect(&:text)
      page.all("button").select{|btn| btn['class'].include 'overlay-close'}.first.click
      groups
    end

    def add_user_to_group(user,type,group)
      if page.has_css?("tr#USER_#{user}")
        page.find("tr#USER_#{user} td input##{type}Privilege_USER_#{user}").click
        general_settings_page.task_save.click
        return
      elsif page.all('input.permissions_USER_name').each{ |input_element|
        if input_element.value.blank?
           input_element.set user
           element=input_element.ancestor('tr').find("td input##{type}Privilege_USER_name")
           element.click
           general_settings_page.task_save.click
        end
       }
      end
    end

    def add_role_to_group(user,type,group)
       if page.has_css?("tr#ROLE_#{user}")
         page.find("tr#ROLE_#{user} td input##{type}Privilege_ROLE_#{user}").click
         general_settings_page.task_save.click
         return
       elsif page.all('input.permissions_ROLE_name').each{ |input_element|
         if input_element.value.blank?
          input_element.set user
          element=input_element.ancestor('tr').find("td input##{type}Privilege_ROLE_name")
          element.click
          general_settings_page.task_save.click
          return
        end
        }
      end
    end

    def users_in_group()
      users=[]
      page.all('input.permissions_USER_name').each{|element|
        users.push(element.value) if !element.value.blank?
      }
      return users;
    end

    def roles_in_group()
      roles=[]
      page.all('input.permissions_ROLE_name').each{|element|
        roles.push(element.value) if !element.value.blank?
      }
      return roles;
    end

    def users_permissions_in_group(user)
      permissions=[]
      page.all("tr#USER_#{user} td input[type=checkbox]").each{|element|
        permissions.push(element[:name]) if !element.checked?
      }
      return permissions
    end

    def roles_permissions_in_group(role)
      permissions=[]
      page.all("tr#ROLE_#{role} td input[type=checkbox]").each{|element|
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
      page.find('.sub_tabs_container').find('a', text:tab).click
    end

    def open_template template
      page.find('a.edit_template', text:template).click
    end

    def total_templates
      total_templates = []
      page.all('.template_group h2.group_name').each do |template|
        total_templates.push(template.text)
      end
      total_templates
    end

    def click_edit_pipeline pipeline
      page.find("data-test-id='edit-pipeline-#{pipeline}'").click
    end

    def landed_on_pipeline_edit_page? pipeline
      page.find('.pipeline_header').has_css?('a', text:pipeline)
    end

    def template_tab_is_visible?
      page.has_css?('#tab-link-of-templates')
    end


    def edit_template template
      page.all('a.edit_icon').each{|edit|
        edit.click if edit[:href].to_s.include?(template)
      }
    end

    def change_cofig_to_conflict
      context=page.find('#content').text.gsub! 'replace-job', 'replace-job-conflict'
      page.find('#content').set context
    end

    def rename_pipeline_on_config_xml_page pipeline,new_pipeline
      new_context=page.find('#content_container_for_edit').text.gsub! "#{pipeline}", new_pipeline
      page.find('#content_container_for_edit').set new_context
    end

    def verify_split_appears
      assert_true page.has_css?('.conflicted_content')
      assert_true page.has_css?('.current_content')
    end

    def add_downstream_pipeline_to_create_post_validations
     context= %Q(<pipeline name="downstream-pipeline">\n <materials>\n <pipeline pipelineName= "#{scenario_state.get('upstream-pipeline')}"
                   stageName="defaultStage" materialName="UP" />\n </materials>\n <stage name="defaultStage">\n <approval type="manual"/>\n <jobs>\n <job name="replace-job">
                   \n <tasks>\n <exec command="ls"/>\n </tasks>\n </job>\n </jobs>\n </stage>\n </pipeline>\n </pipelines>)
       new_context=page.find('#content').text.sub! "</pipelines>", context
       page.find('#content').set new_context
    end

    def post_validation_error_message_exist?message

     errors=[]
     page.all('.error').each{|error|
       errors.push(error.text)}
     errors.include?new_pipeline_dashboard_page.sanitize_message(message)
    end

    def edit_config
      page.find('a.link_as_button',text:'EDIT').click
    end

    def click_add_new_template
      page.find('a',text:'ADD NEW TEMPLATE').click
    end

    def extractable_pipelines
      page.find('#pipeline_selectedPipelineName').all('option').collect(&:text)
    end

    def extractable_disabled_pipeline
      page.find('select#pipeline_pipelineNames').all('option').collect(&:text)
    end

    def select_pipeline_for_template pipeline
      find('#pipeline_selectedPipelineName option', :text => pipeline).click
    end

    def has_template? template
    page.has_css?('a.edit_template',text: template )
    end

    def click_extract_template pipeline
      page.find(".extract_template_for_pipeline_#{pipeline} a").click
    end

    private

    def row_for_pipeline(pipeline)
      pipeline_link = pipeline_link text: pipeline
      pipeline_link.first(:xpath, './/../..')
    end

    def click_on_clone_link_for(pipeline)
      all_pipeline_groups.find("[data-test-id='clone-pipeline-#{pipeline}']").click
    end
  end
end
