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
  class AdminPipelinePage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/pipelines"
    element :pipeline_link, '.pipeline td.name a'
    element :error_and_warning_count, "[data-test-id='server-health-messages-count']"
    element :error_popup_ok_button, "[data-test-id='button-ok']"
    elements :error_messages, "[data-test-class='server-health-message_message']"
    elements :error_discription, "[data-test-class='server-health-message_detail']"
    element :add_group_name, '#group_group'
    element :save_clone_pipeline, 'button.finish.submit'
    element :error_message_on_clone_window, '.form_error'
    element :set_pipeline, '.uniquePipelineName'
    element :set_group, '.ac_input'
    element :edit_group_name, 'input#group_group'
    element :save_server_configuration, '#submit_form'
    element :edit_config_xml, '#edit_config'
    element :save_config, '#save_config'
    element :cancel_config, '.cancel'
    element :template_name, '#admin_pipeline_page'
    element :extract_from_pipeline, '#pipeline_useExistingPipeline'
    element :template_name_on_popup, '#pipeline_template_name'

    def clone_pipeline(source_pipeline_name, new_pipeline_name, pipeline_group_name)
      click_on_clone_link_for(source_pipeline_name)
      page.find('#pipeline_group_pipeline_name').set new_pipeline_name
      page.find('#pipeline_group_name_text_field').set pipeline_group_name
      page.find('button.submit', text: 'SAVE').click
    end

    def delete_pipeline(pipeline)
      pipeline_row = row_for_pipeline(pipeline)
      pipeline_row.find('.delete_icon').click
      page.find('#warning_prompt').find('button.primary').click
    end

    def move_pipeline(pipeline, _source_group, destination_group)
      pipeline_row = row_for_pipeline(pipeline)
      page.find("#a_move_#{pipeline}").click
      page.find('#shared_micro_dropdown').find('ul li.move_to_group_option', text: destination_group).click
    end

    def verify_number_of_error_message(number_of_err_msg)
      wait_till_event_occurs_or_bomb 60, "Total number of errors are not equal to #{number_of_err_msg}" do
        reload_page
        break if number_of_err_msg.to_i == error_and_warning_count.text.split('and')[0].scan(/\d+/)[0].to_i
      end
    end



    def verify_number_of_warnings(number_of_warning_msg)
      wait_till_event_occurs_or_bomb 90, "Total number of Warnings are not equal to #{number_of_warning_msg}" do
        reload_page
        break if number_of_warning_msg.to_i == error_and_warning_count.text.match('\d warning').to_s.scan(/\d+/)[0].to_i
      end
    end

    def wait_till_error_popup_appears
      page.has_css?("[data-test-id='server-health-messages-count']", wait: 240)
    end

    def verify_there_are_no_warnings
      if page.has_no_css?("[data-test-id='server-health-messages-count']",wait: 10)
        assert_true true
      elsif page.has_css?("[data-test-id='server-health-messages-count']", wait: 10)
        assert_true !error_and_warning_count.text.include?('warning')
      else
        assert_true false
      end
    end

    def verify_there_are_no_errors_and_warnings
      page.has_css?("[data-test-id='server-health-messages-count']")
    end

    def verify_there_are_no_errors_and_warnings
      page.has_css?("[data-test-id='server-health-messages-count']")
    end

    def verify_there_are_no_error_messages
      assert_true !error_and_warning_count.text.include?('error')
    end

    def verify_error_message(error_message)
      wait_till_event_occurs_or_bomb 60, "Does not contains #{error_message}" do
        found = false
        error_messages.each do |message|
          found = true if message.text.include? error_message
        end
        break if found
      end
    end

    def verify_message_do_not_contains(error_message)
      msg_list = []
      error_messages.each do |message|
        msg_list.push(message.text)
      end
      assert_true !msg_list.include?(error_message)
    end

    def verify_error_description_do_not_contains(error_message)
      msg_list = []
      error_discription.each do |message|
        msg_list.push(message.text)
      end
      assert_true !msg_list.include?(error_message)
    end

    def verify_error_description(error_message)
      wait_till_event_occurs_or_bomb 60, "Does not contains #{error_message}" do
        found = false
        error_discription.each do |message|
          found = true if message.text.include? error_message
        end
        break if found
      end
    end

    def navigate_to(tab)
      page.find('.sub_tabs_container').find('a', text: tab).click
    end

    def pipeline_can_be_extracted?(pipeline)
      page.find(".title_secondary_info.extract_template_for_pipeline_#{pipeline}").visible?
    end

    def pipeline_extraction_disabled?(pipeline)
      page.find(".action_icon.add_icon_disabled.extract_template_for_pipeline_#{pipeline}").visible?
    end

    def add_pipeline_group
      page.find('a.link_as_button').click
    end

    def total_pipeline_groups
      total_groups = []
      page.all('.group_name').each do |group|
        total_groups.push(group.text)
      end
      total_groups
    end

    def get_pipelines_from(group)
      pipelines = []
      page.find('h2', text: group).ancestor('.pipeline_group').all('td.name a').each do |pipeline|
        pipelines.push(pipeline.text)
      end
      pipelines
    end

    def get_pipelines_from_templates(template)
      pipelines = []
      page.find('h2.group_name', text: template).ancestor('.template_group').all('td.name a').each do |pipeline|
        pipelines.push(pipeline.text)
      end
      pipelines
    end

    def delete_link_is_disabled?(group)
      page.find('h2', text: group).ancestor('.pipeline_group').has_css?('.delete_icon_disabled.group_name_delete')
    end

    def delete_link_is_disabled_for_template? template
      page.find('h2.group_name', text: template).sibling('.title_action_wrapper').has_css?('.delete_icon_disabled')
    end

    def delete_template template
      page.find("span#trigger_delete_#{template}").click
      page.find("button[value='Proceed']").click
    end

    def delete_group(group)
      page.find('h2', text: group).ancestor('.pipeline_group').find('.group_name_delete').click
      page.find("button[value='Proceed']").click
    end

    def delete_pipeline_from_group(pipeline)
      page.find('td a', text: scenario_state.get(pipeline)).ancestor('tr').find('form span.delete_icon').click
      page.find("button[value='Proceed']").click
    end

    def verify_group_has_pipeline(group, pipeline)
      page.find('.group.pipeline_group', text: group).has_css?('a.wrapped_word', text: pipeline)
    end

    def click_clone_button(pipeline)
      page.find(".clone_button_for_#{pipeline}").click
    end

    def unpos_button_exist?(pipeline)
      page.has_css?("button#unpause-#{pipeline}")
    end

    def get_pos_discription
      page.find('.pause_description.paused_by').text
    end

    def delete_button_enabled?(pipeline)
      page.has_css?("form[action='/go/admin/pipelines/#{pipeline}'] span a")
    end

    def group_has_message?(group, message)
      page.find('h2', text: group).ancestor('.pipeline_group').has_css?('.information', text: message)
    end

    def template_has_message?(template,message)
      page.find('h2.group_name', text: template).ancestor('.template').has_css?('.information', text: message)
    end

    def add_new_pipeline_in_group(group)
      page.find('h2', text: group).ancestor('.pipeline_group').find('.add_link.add_pipeline_to_group').click
    end

    def edit_link_exist_for_pipeline?(pipeline)
      page.find(".edit_for_pipeline_#{scenario_state.get(pipeline)}")[:href].include? "go/admin/pipelines/#{scenario_state.get(pipeline)}/general"
    end

    def move_button_exist_for_pipeline?(pipeline)
      page.has_css?("#a_move_#{scenario_state.get(pipeline)}")
    end

    def pipeline_moved_to_group_list(pipeline)
      page.find("#a_move_#{pipeline}").click
      groups = []
      page.all("form[action='/go/admin/pipelines/move/#{pipeline}'] a").each do |group|
        groups.push(group)
      end
      page.find("#a_move_#{pipeline}").click
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

    def total_templates
      total_templates = []
      page.all('.template_group h2.group_name').each do |template|
        total_templates.push(template.text)
      end
      total_templates
    end

    def click_edit_pipeline pipeline
      page.find('td a',text:pipeline).ancestor('tr').find('td a.action_icon.edit_icon').click
    end

    def landed_on_pipeline_edit_page? pipeline
      page.find('.pipeline_header').has_css?('a', text:pipeline)
    end

    def template_tab_is_visible?
      page.has_css?('#tab-link-of-templates')
    end

    def set_hung_job_override_time time
      page.find("#hungjobs_overrideTimeout").click
      page.find("#server_configuration_form_jobTimeout").set time
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
      new_context=page.find('#content_container_for_edit').text.gsub! "#{scenario_state.get(pipeline)}", new_pipeline
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

    def select_pipeline_for_template pipeline
      find('#pipeline_selectedPipelineName option', :text => pipeline).click
    end

    def has_template? template
    page.has_css?('a.edit_template',text: template )
    end

    private

    def row_for_pipeline(pipeline)
      pipeline_link = pipeline_link text: pipeline
      pipeline_link.first(:xpath, './/../..')
    end

    def click_on_clone_link_for(pipeline)
      pipeline_name = scenario_state.get(pipeline)
      page.find(".clone_button_for_#{pipeline_name}").click
    end
  end
end
