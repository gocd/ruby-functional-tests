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

    element :template_name_on_popup, "[data-test-id='form-field-input-template-name']"
    element :extract_from_pipeline, "[data-test-id='form-field-input-extract-from-pipeline']"
    element :create_new_template, "[data-test-id='create-new-template']"
    element :button_create, "[data-test-id='button-create']"

    load_validation { has_create_new_template? }

    def landed_on_pipeline_edit_page? pipeline
      page.find('.pipeline_header').has_css?('a', text:pipeline)
    end

    def click_edit_pipeline pipeline
      page.find("[data-test-id='edit-pipeline-#{pipeline.downcase}']").click
    end

    def enter_template_name name
      template_name_on_popup.set name
    end

    def click_extract_template pipeline
      extract_from_pipeline.click
    end

    def click_add_new_template
      page.find("[data-test-id='create-new-template']").click
    end


    def extractable_pipelines
      page.find("[data-test-id='form-field-input-pipeline']").all('option').collect(&:text)
    end


    def select_pipeline_for_template pipeline
      find("[data-test-id='form-field-input-pipeline'] option", :text => pipeline).click
    end


    def all_templates
      all_templates = []
      page.all("[data-test-id^='template-name-']").each do |group|
        all_templates << group['data-test-id'].gsub('template-name-', '')
      end
      all_templates
    end


    def get_pipelines_from_template(template)
      pipelines = []
      page.find("[data-test-id='template-#{template.downcase}']").all("[data-test-id ^='pipeline-']").each do |pipeline|
        pipelines << pipeline['data-test-id'].sub('pipeline-', '')
      end
      pipelines
    end

    def template_has_message?(template,message)
      page.find("[data-test-id='template-#{template.downcase}']").has_css?("[data-test-id='flash-message-info']", text: message)
    end


    def delete_link_is_disabled_for_template? template
      page.find("[data-test-id='delete-template-#{template.downcase}']").disabled?
    end

    def delete_template template
      page.find("[data-test-id='delete-template-#{template.downcase}']").click
      page.find("[data-test-id='button-delete']").click
    end

  end
end
