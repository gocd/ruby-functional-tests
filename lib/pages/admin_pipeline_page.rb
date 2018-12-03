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
    element :error_and_warning_count, ".server_health_messages_count_widget__server-health-messages-container___ubAjf"
    element :close_erroe_popup, ".index__close-icon___naBaW"
  

    def clone_pipeline(source_pipeline_name, new_pipeline_name, pipeline_group_name)
      click_on_clone_link_for(source_pipeline_name)
      page.find("#pipeline_group_pipeline_name").set new_pipeline_name
      page.find("#pipeline_group_name_text_field").set pipeline_group_name
      page.find("button.submit", {text: "SAVE"}).click
    end

    def delete_pipeline(pipeline)
      pipeline_row = row_for_pipeline(pipeline)
      pipeline_row.find('.delete_icon').click
      page.find('#warning_prompt').find('button.primary').click
    end

    def move_pipeline(pipeline, _source_group, destination_group)
      pipeline_row = row_for_pipeline(pipeline)
      pipeline_row.find('.move_pipeline').click
      page.find('#div_move_to_groups').find('ul li.move_to_group_option', {text: destination_group}).click
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


    def verify_at_least_number_of_error_message(number_of_err_msg)
       if error_and_warning_count.text.split('and')[0].include?"error" 
         total_errors= error_and_warning_count.text.split('and')[0].scan(/\d+/)[0].to_i
         assert_operator total_errors, :>=, number_of_err_msg.to_i
       else 
        assert_true false 
       end
    end  

    def verify_number_of_warnings(number_of_warning_msg)
      if error_and_warning_count.text.split('and')[1].include?"warning" 
        total_warnings= error_and_warning_count.text.split('and')[1].scan(/\d+/)[0].to_i
        assert_equal total_warnings,number_of_warning_msg.to_i
       else 
       assert_true false 
      end 
    end

    def verify_there_are_no_warnings
      assert_true !error_and_warning_count.text.include?("Warning")
    end  
    
    def verify_error_message(error_message)
      msg=""
      page.all('.server_health_messages_count_widget__message___3WAl7').each do |message|
       msg=message.text
       break if msg.include?error_message
      end
      msg.include?error_message
    end  

    def verify_message_do_not_contains(error_message)
      msg_list=[]
      page.all('.server_health_messages_count_widget__message___3WAl7').each do |message|
        binding.pry
        msg_list.push(message.text)
       end
      assert_true !msg_list.include?(error_message)
    end  

    private

    def row_for_pipeline(pipeline)
      pipeline_link = pipeline_link text: (scenario_state.get(pipeline) || pipeline)
      pipeline_link.first(:xpath, ".//../..")
    end

    def click_on_clone_link_for(pipeline)
      pipeline_name = scenario_state.get(pipeline)
      page.find(".clone_button_for_#{pipeline_name}").click
    end



  end
end