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
    set_url "#{GoConstants::SERVER_BASE_URL}/admin/config_xml"

    element :save_message, '#message_pane > p'

    def config_content_is_loaded?
      page.has_no_css?('#content_area .spinner-container')
    end
    
    def change_config_to_conflict
      context = page.find('#content').text.gsub! 'replace-job', 'replace-job-conflict'
      page.find('#content').set(context, rapid: false)
    end

    def verify_split_appears
      assert_true page.has_css?('.conflicted_content')
      assert_true page.has_css?('.current_content')
    end

    def add_downstream_pipeline_to_create_post_validations
      context = %Q(<pipeline name="downstream-pipeline">\n <materials>\n <pipeline pipelineName="#{scenario_state.get('upstream-pipeline')}"
                   stageName="defaultStage" materialName="UP" />\n </materials>\n <stage name="defaultStage">\n <approval type="manual"/>\n <jobs>\n <job name="replace-job">
                   \n <tasks>\n <exec command="ls"/>\n </tasks>\n </job>\n </jobs>\n </stage>\n </pipeline>\n </pipelines>)
      new_context = page.find('#content').text.sub! "</pipelines>", context
      page.find('#content').set(new_context, rapid: false)
    end

    def post_validation_error_message_exist?(message)
      errors = []
      page.all('.error').each { |error|
        errors.push(error.text) }
      errors.include? new_pipeline_dashboard_page.interpolate_from_scenario_state(message)
    end

    def click_edit_config
      page.find('a.link_as_button', text: 'EDIT').click
    end

    def save_config
      page.execute_script "window.scrollTo(0,0)"
      page.find('#save_config').click
    end

    def get_message
      save_message.text
    end
  end
end
