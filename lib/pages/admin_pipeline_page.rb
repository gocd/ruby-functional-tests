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

    def verify_number_of_error_message(number_of_err_msg)
        wait_till_event_occurs_or_bomb 60, "Total number of errors are not equal to #{number_of_err_msg}" do
        reload_page
        break if number_of_err_msg.to_i == error_and_warning_count.text.split("and")[0].scan(/\d+/)[0].to_i
          end
    end  

    def verify_number_of_warnings(number_of_warning_msg)
      if error_and_warning_count.text.split('and')[1].include? "warning"
        total_warnings = error_and_warning_count.text.split('and')[1].scan(/\d+/)[0].to_i
        assert_equal total_warnings, number_of_warning_msg.to_i
       else 
       assert_true false 
      end 
    end

    def verify_there_are_no_warnings
      assert_true !error_and_warning_count.text.include?("Warning")
    end  
    
    def verify_there_are_no_error_messages
      assert_true !error_and_warning_count.text.include?("error")
    end 

    def verify_error_message(error_message)
       wait_till_event_occurs_or_bomb 60, "Does not contains #{error_message}" do
        found = false
        error_messages.each { |message|
          found = true if message.text.include? error_message
        }
        break if found
      end
    end  

    def verify_message_do_not_contains(error_message)
      msg_list = []
      error_messages.each { |message|
        msg_list.push(message.text)
      }
      assert_true !msg_list.include?(error_message)
    end  

    def verify_error_description_do_not_contains(error_message)
      msg_list = []
      error_discription.each { |message|
        msg_list.push(message.text)
      }
      assert_true !msg_list.include?(error_message)
    end 

    def verify_error_description(error_message)
      wait_till_event_occurs_or_bomb 60, "Does not contains #{error_message}" do
        found = false
        error_discription.each { |message|
          found = true if message.text.include? error_message
        }
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