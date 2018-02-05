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
  class NewPipelineDashboard < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/dashboard{?autoRefresh*}"

    element :pipeline_name, '.pipeline_name'
    elements :pipeline_group, '.pipeline-group'
    elements :pipeline_group_title, '.pipeline-group_title'

    def trigger_pipeline(pipeline)
      (pipeline_name text: scenario_state.get_pipeline(pipeline)).find(:xpath, '../..').find('.btn.play').click
      reload_page
    end

    def pause_pipeline(pipeline, reason)
      (pipeline_name text: scenario_state.get_pipeline(pipeline)).find(:xpath, '../..').find('.btn.pause').click
      page.find('.modal-body').input.set(reason)
      page.find('.modal-body').find('.button.save.primary').click
    end

    def pause_message?(message)
      (pipeline_name text: scenario_state.get_pipeline(pipeline)).find(:xpath, "../..").has_selector?('.pipeline_pause-message', text: message)
    end 

    def unpause_pipeline(pipeline)
      (pipeline_name text: scenario_state.get_pipeline(pipeline)).find(:xpath, '../..').find('.btn.unpause').click
    end

    def get_latest_stage_state(pipeline) # This one needs to be relooked - the way the view is modelled do not make it easy to get latest stage state
      SitePrism::Page.element :pipeline_panel, "#pipeline_#{scenario_state.get_pipeline(pipeline)}_panel"
      pipeline_panel.find('.latest_stage').text
    end

    def get_pipeline_stage_state(pipeline, stagename) # This need relook too
      target_stage = (pipeline_name text: scenario_state.get_pipeline(pipeline)).find(:xpath, '../..').find('.pipeline_stages').a.select { |stage| stage['href'].include?(stagename) }
      target_stage.first['class']
    end

    def verify_pipeline_is_at_label(pipeline, label)
      assert_true (pipeline_name text: pipeline).find('.pipeline_instance-label').text.include?(label)
    end

    def verify_pipeline_stage_state(pipeline, stage, state)
      reload_page
      assert get_pipeline_stage_state(pipeline, stage).include?(state)
    end

    def wait_till_pipeline_start_building(pipeline)
      wait_till_event_occurs_or_bomb 30, "Pipeline #{scenario_state.get_pipeline(pipeline)} failed to start building" do
        reload_page
        break if get_latest_stage_state(pipeline).include?('building')
      end
    end

    def wait_till_pipeline_complete(pipeline)
      wait_till_event_occurs_or_bomb 60, "Pipeline #{scenario_state.get_pipeline(pipeline)} failed to complete with in timeout" do
        reload_page
        break unless get_latest_stage_state(pipeline).include?('building')
      end
    end

    def wait_till_stage_complete(pipeline, stage)
      wait_till_event_occurs_or_bomb 60, "Pipeline #{scenario_state.get_pipeline(pipeline)} Stage #{stage} failed to complete with in timeout" do
        reload_page
        break unless get_pipeline_stage_state(pipeline, stage).include?('building')
      end
    end

    def editable?(pipeline)
      (pipeline_name text: scenario_state.get_pipeline(pipeline)).find(:xpath, '..').has_css?('.pipeline_edit')
    end

    def locked?(pipeline)
      (pipeline_name text: scenario_state.get_pipeline(pipeline)).find(:xpath, '..').has_css?('.pipeline_locked')
    end

    def visible?(pipeline)
      has_pipeline_name? text: scenario_state.get_pipeline(pipeline)
    end

    def group_visible?(group)
      pipeline_group_title.all.select { |grp| grp.a.text == group }.any?
    end

    def pipeline_in_group(name, group)
      pipelines = pipeline_group.all.select { |grp| grp.find('.pipeline-group_title').a.text == group }.find('.pipeline_name')
      pipelines.all.select { |pipeline| pipeline.text == name }.any?
    end

    def pipeline_history_exists?(pipeline)
      (pipeline_name text: scenario_state.get_pipeline(pipeline)).find(:xpath, "../..").has_selector?('.pipeline_instances', visible: true)
    end

    def wait_till_pipeline_showsup(pipeline)
      wait_till_event_occurs_or_bomb 30, "Config repo Pipeline #{scenario_state.get_pipeline(pipeline)} failed to showup on dashboard" do
        reload_page
        break if has_pipeline_name? text: scenario_state.get_pipeline(pipeline)
      end
    end

    def open_build_cause(pipeline)
      (pipeline_name text: scenario_state.get_pipeline(pipeline)).find(:xpath, "../..").find('.changes').click
    end

    
  end
end
