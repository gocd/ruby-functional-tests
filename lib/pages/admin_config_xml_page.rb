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
  class AdminConfigXMLPage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/config_xml"

    element :save_message, '#message_pane > p'

    def save_config
      page.execute_script "window.scrollTo(0,0)"
      page.find('#save_config').click
    end

    def get_message
      save_message.text
    end
  end
end
