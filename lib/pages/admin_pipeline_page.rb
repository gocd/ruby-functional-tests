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

    private
    def row_for_pipeline(pipeline)
      pipeline_link = pipeline_link text: (scenario_state.actual_pipeline_name(pipeline) || pipeline)
      pipeline_link.first(:xpath, ".//../..")
    end

    def click_on_clone_link_for(pipeline)
      pipeline_name = scenario_state.actual_pipeline_name(pipeline)
      page.find(".clone_button_for_#{pipeline_name}").click
    end

  end
end