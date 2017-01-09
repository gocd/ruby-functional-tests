##########################################################################
# Copyright 2016 ThoughtWorks, Inc.
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

    element :message_notifier, '#cruise_message_counts > a > span > span'
    element :health_messages, '#cruise_message_body'

    def wait_for_server_health_message
      wait_till_event_occurs_or_bomb 30, "Server Health Message not shown" do
        reload_page
        break if page.has_css?('#cruise_message_counts > a')
      end
    end

    def verify_message_notifier_showsup
      assert message_notifier.visible?
    end

    def verify_message_displayed(msg)
      message_notifier.click
      assert health_messages.all('div > div.description').map{|available_msg| available_msg.text.include?(sanitize_message msg)}.include?(true)
    end

  end
end
