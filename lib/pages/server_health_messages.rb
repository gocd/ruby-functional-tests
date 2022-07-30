##########################################################################
# Copyright 2022 Thoughtworks, Inc.
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
  class ServerHealthMessage < AppBase

    element :message_notifier, '[data-test-id="server-health-messages-count"]'
    element :health_messages, '[data-test-id="modal-body"]'
    elements :error_messages, "[data-test-class='server-health-message_message']"
    elements :error_discription, "[data-test-class='server-health-message_detail']"
    element :error_popup_ok_button, "[data-test-id='button-ok']"

    def verify_message_notifier_showsup
      wait_until_message_notifier_visible(wait: 60)
    end

    def verify_message_displayed(msg)
      message_notifier.click
      assert health_messages.all('[data-test-class="server-health-message_detail"]').map{|available_msg| available_msg.text.include?(sanitize_message msg)}.include?(true)
    end

    def verify_number_of_error_message(number_of_err_msg)
      wait_till_event_occurs_or_bomb 60, "Total number of errors are not equal to #{number_of_err_msg}" do
        reload_page
        break if number_of_err_msg.to_i == message_notifier.text.split('and')[0].scan(/\d+/)[0].to_i
      end
    end

    def verify_minimum_number_of_error_message(number_of_err_msg)
      wait_till_event_occurs_or_bomb 60, "Total number of errors are lesser the minimum: #{number_of_err_msg} required" do
        reload_page
        break if message_notifier.text.split('and')[0].scan(/\d+/)[0].to_i >= number_of_err_msg.to_i
      end
    end

    def verify_number_of_warnings(number_of_warning_msg)
      wait_till_event_occurs_or_bomb 90, "Total number of Warnings are not equal to #{number_of_warning_msg}" do
        reload_page
        break if number_of_warning_msg.to_i == message_notifier.text.match('\d warning').to_s.scan(/\d+/)[0].to_i
      end
    end

    def wait_till_error_popup_appears
      page.has_css?("[data-test-id='server-health-messages-count']", wait: 240)
    end

    def verify_there_are_no_warnings
      if page.has_no_css?("[data-test-id='server-health-messages-count']",wait: 10)
        assert_true true
      elsif page.has_css?("[data-test-id='server-health-messages-count']", wait: 10)
        assert_true !message_notifier.text.include?('warning')
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
      assert_true !message_notifier.text.include?('error')
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

  end
end
