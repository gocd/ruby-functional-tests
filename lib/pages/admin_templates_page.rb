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
  class AdminTemplatesPage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/templates"

    element :template_name_on_popup, '#pipeline_template_name'
    element :extract_from_pipeline, '#pipeline_useExistingPipeline'

    def landed_on_pipeline_edit_page? pipeline
      page.find('.pipeline_header').has_css?('a', text:pipeline)
    end

    def click_edit_pipeline pipeline
      page.find('td a',text:pipeline).ancestor('tr').find('td a.action_icon.edit_icon').click
    end

    def enter_template_name name
      template_name_on_popup.set name
    end

    def click_extract_template pipeline
      extract_from_pipeline.click
    end

  end
end
