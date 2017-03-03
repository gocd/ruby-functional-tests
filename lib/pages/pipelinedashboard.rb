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
  class PipelineDashboard < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/pipelines"

    def trigger_pipeline(pipeline)
      SitePrism::Page.element :trigger_button, "#deploy-#{scenario_state.get_pipeline(pipeline)}"
      trigger_button.click
      reload_page
    end

    def get_pipeline_stage_state(pipeline, _stage)
      SitePrism::Page.element :latest_stage, "#pipeline_#{scenario_state.get_pipeline(pipeline)}_panel > div.pipeline_instance > div.status.details > div.pipeline_instance_details > div.stages > div"
      latest_stage.text
    end

    def verify_pipeline_is_at_label(pipeline, label)
      SitePrism::Page.element :label_text, "#pipeline_#{scenario_state.get_pipeline(pipeline)}_panel > div.pipeline_instance > div.status.details > div.label > a"
      assert_equal label_text.text, label
    end

    def verify_pipeline_stage_state(pipeline, stage, state)
      reload_page
      assert get_pipeline_stage_state(pipeline, stage).include?(state)
    end

    def wait_till_pipeline_start_building(pipeline, stage)
      wait_till_event_occurs_or_bomb 10, "Pipeline #{scenario_state.get_pipeline(pipeline)} failed to start building" do
        reload_page
        break if get_pipeline_stage_state(pipeline, stage).include?('Building')
      end
    end

    def wait_till_pipeline_complete(pipeline, stage)
      wait_till_event_occurs_or_bomb 60, "Pipeline #{scenario_state.get_pipeline(pipeline)} failed to complete with in timeout" do
        reload_page
        break unless get_pipeline_stage_state(pipeline, stage).include?('Building')
      end
    end

    def is_editable?(pipeline)
      page.has_css?("#pipeline_#{pipeline}_panel > div.pipeline_header > div.pipeline_actions > a")
    end

    def wait_till_pipeline_showsup(pipeline)
      wait_till_event_occurs_or_bomb 30, "Config repo Pipeline #{scenario_state.get_pipeline(pipeline)} failed to showup on dashboard" do
        reload_page
        break if page.has_css?("#deploy-#{scenario_state.get_pipeline(pipeline)}")
      end
    end
  end
end
