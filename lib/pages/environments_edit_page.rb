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
  class EnvironmentsEditPage < AppBase
    element :pipeline_edit_button, "#edit_pipelines"
    element :save_button, "#MB_content > div > form > div.form_buttons.actions > button.primary.finish.submit.MB_focusable"
    element :pipelines_list, "#body_content > div.content_wrapper_outer > div > div > div > div > div.added_item.added_pipelines > ul"

    def initialize(environment)
      SitePrism::Page.set_url "#{GoConstants::GO_SERVER_BASE_URL}/environments/#{environment}/show"
    end

    def is_pipeline_exists?(pipeline)
      pipelines_list.text.include? pipeline
    end

    def click_pipeline_edit
      pipeline_edit_button.click
    end

    def add_pipeline(pipeline)
      SitePrism::Page.element :pipeline_checkbox, "#pipeline_#{pipeline}"
      pipeline_checkbox.set(true)
    end

    def remove_pipeline(pipeline)
      SitePrism::Page.element :pipeline_checkbox, "#pipeline_#{pipeline}"
      pipeline_checkbox.set(false)
    end

    def save
      save_button.click
    end

    def can_edit_pipeline?(pipeline)
      SitePrism::Page.element :pipeline_checkbox, "#pipeline_#{pipeline}"
      !pipeline_checkbox.disabled?
    end
  end
end
