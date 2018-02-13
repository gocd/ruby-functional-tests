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

    load_validation { has_pipeline_group? }

    def trigger_pipeline(pipeline)
      (pipeline_name text: scenario_state.get_pipeline(pipeline)).find(:xpath, '../..').find('.btn.play').click
      reload_page
    end

    def pause_pipeline(pipeline, reason)
      (pipeline_name text: scenario_state.get_pipeline(pipeline)).find(:xpath, '../..').find('.btn.pause').click
      page.find('.modal-body').find('input').set(reason)
      page.find('.modal-buttons').find('button', text: 'OK').click
    end

    def pause_message?(message)
      (pipeline_name text: scenario_state.get_pipeline(pipeline)).find(:xpath, '../..').has_selector?('.pipeline_pause-message', text: message)
    end

    def unpause_pipeline(pipeline)
      (pipeline_name text: scenario_state.get_pipeline(pipeline)).find(:xpath, '../..').find('.btn.unpause').click
    end

    def get_all_stages(pipeline) # This one needs to be relooked - the way the view is modelled do not make it easy to get latest stage state
      (pipeline_name text: scenario_state.get_pipeline(pipeline)).find(:xpath, '../..').find('.pipeline_stages').all('a')
    end

    def get_pipeline_stage_state(pipeline, stagename) # This need relook too
      target_stage = (pipeline_name text: scenario_state.get_pipeline(pipeline)).find(:xpath, '../..').find('.pipeline_stages').all('a').select { |stage| stage['href'].include?(stagename) }
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
        break if get_all_stages(pipeline).first['class'].include?('building')
      end
    end

    def wait_till_pipeline_complete(pipeline)
      wait_till_event_occurs_or_bomb 60, "Pipeline #{scenario_state.get_pipeline(pipeline)} failed to complete with in timeout" do
        reload_page
        break unless get_all_stages(pipeline).last['class'].include?('building')
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
      pipeline_group_title.all.select { |grp| grp.find('strong').text == group }.any?
    end

    def pipeline_in_group(name, group)
      pipelines = pipeline_group.all.select { |grp| 
          grp.find('.pipeline-group_title')
             .find('strong').text == group 
          }.all('.pipeline_name')
      pipelines.select { |pipeline| pipeline.text == name }.any?
    end

    def pipeline_history_exists?(pipeline)
      (pipeline_name text: scenario_state.get_pipeline(pipeline))
        .find(:xpath, '../..').has_selector?('.pipeline_instances', visible: true)
    end

    def wait_till_pipeline_showsup(pipeline)
      wait_till_event_occurs_or_bomb 30, "Config repo Pipeline #{scenario_state.get_pipeline(pipeline)} failed to showup on dashboard" do
        reload_page
        break if has_pipeline_name? text: scenario_state.get_pipeline(pipeline)
      end
    end

    def click_history(pipeline)
      (pipeline_name text: scenario_state.get_pipeline(pipeline)).find(:xpath, '../..').find('.pipeline_history').click
    end

    def open_build_cause(pipeline)
      (pipeline_name text: scenario_state.get_pipeline(pipeline)).find(:xpath, '../..').find('.changes').click
    end

    def revisions(pipeline)
      (pipeline_name text: scenario_state.get_pipeline(pipeline)).find(:xpath, '../..').find('.material_changes.show').all('div')
    end

    def revision_of_material(pipeline, type, name)
      revisions(pipeline).select { |material| material.find('.rev-head').text.include? "#{type} - #{name}" }.first
    end

    def shows_revision?(revision_element, revision_id)
      revision_element.has_css?('.revision_id', text: revision_id)
    end
  end
end
