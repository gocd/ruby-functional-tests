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
  class ServerHealthMessage < AppBase

    element :message_notifier, '[data-test-id="server-health-messages-count"]'
    element :health_messages, '[data-test-id="modal-body"]'

    def verify_message_notifier_showsup
      wait_until_message_notifier_visible(wait: 60)
    end

    def verify_message_displayed(msg)
      message_notifier.click
      assert health_messages.all('[data-test-class="server-health-message_detail"]').map{|available_msg| available_msg.text.include?(sanitize_message msg)}.include?(true)
    end

  end
end
