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
    class PipelineSettingsPage < GeneralSettingsPage
      set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/pipelines{/pipeline_name}/general"

      element :message, '#success'
      element :add_variables, '#add_variables'
      element :save, "button[@value='SAVE']"

      def message_displayed?(message)
        page.has_css?('.success', text:message, exact_text: true)
      end

      def partial_message_displayed?(message)
        page.find('.success').text.include?(message)
      end

      def add_parameter(name, value)
        params_row = page.find('.params.variables').find('.params').all('tr').last
        params_row.find("input[name='pipeline[params][][name]']").set name
        params_row.find("input[name='pipeline[params][][valueForDisplay]']").set value
        add_variables.click
      end


    end
end