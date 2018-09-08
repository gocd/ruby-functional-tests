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
  class PipelineBuildTime < AppBase
  end

  class NewPipelineDashboard < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/pipelines{?autoRefresh*}"

    element :pipeline_name, '.pipeline_name'
    elements :pipeline_group, '.dashboard-group'
    elements :pipeline_group_title, '.dashboard-group_title'
    element :material_for_trigger, '.material-for-trigger'
    element :pipeline_selector_dropdown, '.filter_options'
    iframe :build_time_chart, PipelineBuildTime, 0
    element :stage_name, '.stage_name'
    element :environment_variables_tab, '.h-tab_tab-head.pipeline_options-heading'
    element :environment_variables_key_value , '.environment-variables.plain.key-value-pair'
    element :environment_variables_secure_key_value , '.environment-variables.secure.key-value-pair'

    load_validation { has_pipeline_group? }

    def trigger_pipeline(wait_to_build = true)
      (pipeline_name text: scenario_state.self_pipeline)
        .find(:xpath, '../..').find('.pipeline_btn.play').click
      if wait_to_build
        reload_page
        wait_till_pipeline_start_building
      end
    end

    def trigger_pipeline_disabled?
      begin
        (pipeline_name text: scenario_state.self_pipeline)
          .find(:xpath, '../..').find('.pipeline_btn.play.disabled', wait: 5)
      rescue StandardError
        return false
      end
      true
    end

    def trigger_pipeline_with_options
      (pipeline_name text: scenario_state.self_pipeline)
        .find(:xpath, '../../..').find('.pipeline_btn.play_with_options').click
    end

    def trigger_pipeline_with_options_disabled?
      (pipeline_name text: scenario_state.self_pipeline)
        .find(:xpath, '../../..').has_css?('.pipeline_btn.play_with_options.disabled')
    end

    def pause_pipeline(reason)
      (pipeline_name text: scenario_state.self_pipeline)
        .find(:xpath, '../../..').find('.pipeline_btn.pause').click
      page.find('.modal-body').find('input').set(reason)
      page.find('.modal-buttons').find('button', text: 'OK').click
    end

    def pause_message?(message)
      (pipeline_name text: scenario_state.self_pipeline)
        .find(:xpath, '../../..').has_selector?('.pipeline_pause-message', text: message)
    end

    def unpause_pipeline
      (pipeline_name text: scenario_state.self_pipeline)
        .find(:xpath, '../../..').find('.pipeline_btn.unpause').click
    end

    def get_all_stages(pipeline) # This one needs to be relooked - the way the view is modelled do not make it easy to get latest stage state 
    (pipeline_name text: pipeline)
        .find(:xpath, '../../..').find('.pipeline_stages', wait: 10).all('a')
    rescue StandardError => e
      p 'Looks like Pipeline still not started, trying after page reload...'
    end

    def get_pipeline_stage_state(pipeline, stagename) # This need relook too
      target_stage = get_all_stages(pipeline).select { |stage| stage['href'].include?(stagename) }
      target_stage.first['class']
    end

    def verify_pipeline_is_at_label(pipeline, label)
      assert_true (pipeline_name text: pipeline)
        .find(:xpath, '../../..').find('.pipeline_instance-label').text.include?(label)
    end

    def verify_pipeline_stage_state(pipeline, stage, state)
      wait_till_event_occurs_or_bomb 20, "Pipeline #{pipeline} stage #{stage} is not in #{state} state" do
        reload_page
        break if get_pipeline_stage_state(pipeline, stage).include?(state)
      end
    end

    def wait_till_pipeline_start_building
      wait_till_event_occurs_or_bomb 60, "Pipeline #{scenario_state.self_pipeline} failed to start building" do
        reload_page
        break if get_all_stages(scenario_state.self_pipeline).first['class'].include?('building')
      end
    end

    def wait_to_check_pipeline_do_not_start
      wait_till_event_occurs_or_bomb 20, "Pipeline #{scenario_state.self_pipeline} failed to start building" do
        reload_page
        break if !get_all_stages(scenario_state.self_pipeline).first['class'].include?('building')
      end
    end

    def wait_till_pipeline_complete
      wait_till_event_occurs_or_bomb 60, "Pipeline #{scenario_state.self_pipeline} failed to complete with in timeout" do
        reload_page
        break unless get_all_stages(scenario_state.self_pipeline).last['class'].include?('building')
      end
    end

    def wait_till_stage_complete(stage)
      wait_till_event_occurs_or_bomb 60, "Pipeline #{scenario_state.self_pipeline} Stage #{stage} failed to complete with in timeout" do
        reload_page
        break unless get_pipeline_stage_state(scenario_state.self_pipeline, stage).include?('building')
      end
    end

    def editable?
      !(pipeline_name text: scenario_state.self_pipeline)
        .find(:xpath, '..').has_css?('.edit_config.disabled')
    end

    def edit_pipeline(pipeline)
      !(pipeline_name text: scenario_state.self_pipeline)
        .find(:xpath, '..').find('.edit_config').click
    end

    def locked?
      (pipeline_name text: scenario_state.self_pipeline)
        .find(:xpath, '..').has_css?('.pipeline_locked')
    end

    def unlock
      sleep 5
      (pipeline_name text: scenario_state.self_pipeline)
        .find(:xpath, '..').find('.pipeline_locked').click
    end

    def open_build_analytics
      (pipeline_name text: scenario_state.self_pipeline)
        .find(:xpath, '..').find('.pipeline-analytics').click
    end

    def build_time_graph_displayed?
      build_time_chart do |frame|
        (frame.find('#chart-container').find('.pipeline-val').text == scenario_state.self_pipeline) &&
          frame.find('#chart-container').has_css?('.highcharts-series-group')
      end
    end

    def mttr_displayed?
      build_time_chart do |frame|
        frame.find('#chart-container').has_css?('.mttr') &&
          !frame.find('#chart-container').find('.mttr').text.match(/[1-9][0-9].*s/)[0].nil?
      end
    end

    def close_analytics
      page.find('.analytics-modal').find('.close-button').click
    end

    def group_visible?(group)
      pipeline_group_title.select { |grp| grp.text == group }.any?
    end

    def pipeline_in_group?(group)
      wait_till_event_occurs_or_bomb 10, "Pipeline not in group #{group}" do
        selected_pipeline_group = pipeline_group.select { |grp| grp.find('.dashboard-group_title').text == group }.first
        unless selected_pipeline_group.nil?
          pipelines = selected_pipeline_group.all('.pipeline_name')
          return pipelines.select { |pipeline| pipeline.text == scenario_state.self_pipeline }.any?
        end
      end
    end

    def pipeline_history_exists?
      (pipeline_name text: scenario_state.self_pipeline)
        .find(:xpath, '../../..').has_selector?('.pipeline_instances', visible: true)
    end

    def visible?(pipeline)
      has_pipeline_name? text: (scenario_state.actual_pipeline_name(pipeline) || pipeline)
    end

    def wait_till_pipeline_showsup(pipeline, timeout=120)
      wait_till_event_occurs_or_bomb timeout, "Pipeline #{scenario_state.actual_pipeline_name(pipeline)} failed to showup on dashboard" do
        reload_page
        break if visible?(pipeline)
      end
    end

    def click_history
      (pipeline_name text: scenario_state.self_pipeline)
        .find(:xpath, '../../..').find('.pipeline_history').click
    end

    def trigger_cancel_pipeline(trigger_number)
        
      (0...trigger_number.to_i).each do |number|
        trigger_pipeline
        cancel_pipeline
      end
    end

    def cancel_pipeline 
      (pipeline_name text: scenario_state.self_pipeline)
        .find(:xpath, '../../..').find('.pipeline_stage.building').click

      (stage_name text: scenario_state.retrieve('current_stage_name'))
        .find(:xpath, '../..').find('.stage_action').click
    
      find_by_id('cruise-header-tab-pipelines').click
    end

    def open_build_cause
      (pipeline_name text: scenario_state.self_pipeline)
        .find(:xpath, '../../..').find('.changes').click
    end

    def revision_of_material(type, name)
      revisions(scenario_state.self_pipeline).select do |material|
        material.find('.rev-head').text.include? "#{type} - #{sanitize_message(name)}"
      end .first
    end

    def shows_revision_at?(revision_element, revision, position=0)
      revision_class = scenario_state.retrieve('current_material_type').equal? 'Pipeline' ? '.modified_by' : '.revision_id'
      revision_element.all('.modifications')[position].has_css?(revision_class, text: sanitize_message(revision))
    end

    def triggered_by?(user)
      (pipeline_name text: scenario_state.self_pipeline)
        .find(:xpath, '../../..')
        .find('.pipeline_instance-details')
        .all('div').first.text.eql? "Triggered by #{user}"
    end

    def last_run_revision
      material_for_trigger.find('.last-run-revision').find('span').text
    end

    def close_trigger_with_options
      page.find('.modal-buttons').find('button', text: 'CLOSE').click
    end

    def trigger_with_options
      page.find('.modal-buttons').find('button', text: 'Trigger Pipeline').click
    end

    def set_revision_to_trigger_with(material_name, identifier)
      page.find('.material-name', text: material_name).click
      page.find('.material-revision-search').set scenario_state.material_revision identifier
      sleep 10
    end

    def open_pipeline_selector_dropdown
      page.find('.filter_btn').click
    end

    def group_name_visible_in_selection_dropdown(group_name)
      pipeline_selector_dropdown.find("#pgroup_#{group_name}", wait: 2)
                                .find(:xpath, './/..')
                                .find('label', text: group_name)
                                .visible?
    end

    def deselect_all_pipelines
      pipeline_selector_dropdown.find('.select-none').click
    end

    def select_all_pipelines
      pipeline_selector_dropdown.find('.select-all').click
    end

    def all_pipelines_selected?
      pipeline_selector_dropdown.find('.select-all')[:class].include?('selected')
    end

    def no_pipelines_selected?
      pipeline_selector_dropdown.find('.select-none')[:class].include?('selected')
    end

    def click_vsm(pipeline)
      (pipeline_name text: pipeline)
        .find(:xpath, '../../..')
        .find('a', text: 'VSM').click
    end

    def click_compare(pipeline)
      (pipeline_name text: pipeline)
        .find(:xpath, '../../..')
        .find('a', text: 'Compare').click
    end

    def current_vsm_rendered_for(pipeline)
      page.has_css?('.page_name', text: 'Value Stream Map') &&
        page.has_css?('.label', text: 'Pipeline') &&
        page.find("##{pipeline}")[:class].include?('current')
    end

    def material_vsm_rendered_for(revision)
      page.find('.vsm-entity.material').find('.more').click
      page.find('a', text: scenario_state.material_revision(revision)).click
      page.has_css?('.label', text: 'Material') && !page.find("##{scenario_state.self_pipeline}")[:class].include?('current')
    end

    def select_pipeline_group(pipeline_group_name)
      unless pipeline_group_checkbox_for(pipeline_group_name).checked?
        pipeline_group_checkbox_for(pipeline_group_name).click
      end
    end

    def deselect_pipeline_group(pipeline_group_name)
      if pipeline_group_checkbox_for(pipeline_group_name).checked?
        pipeline_group_checkbox_for(pipeline_group_name).click
      end
    end

    def expand_pipeline_group(pipeline_group_name)
      dropdown_arrow = pipeline_group_checkbox_for(pipeline_group_name).first(:xpath, './/..').find('.arrow-right')
      dropdown_arrow.click
    end

    def are_all_pipelines_selected_for?(pipeline_group_name)
      pipeline_checkboxes_for_pgroup = get_pipeline_checkboxes_for(pipeline_group_name)
      pipeline_checkboxes_for_pgroup.each do |checkbox|
        return false unless is_checked?("##{checkbox[:id]}")
      end
      true
    end

    def are_all_pipelines_deselected_for?(pipeline_group_name)
      pipeline_checkboxes_for_pgroup = get_pipeline_checkboxes_for(pipeline_group_name)
      pipeline_checkboxes_for_pgroup.each do |checkbox|
        return false if is_checked?("##{checkbox[:id]}")
      end
      true
    end

    def select_pipeline(pipeline_name)
      pipeline_checkbox = pipeline_checkbox_for(pipeline_name)
      pipeline_checkbox.click unless pipeline_checkbox.checked?
    end

    def deselect_pipeline(pipeline_name)
      pipeline_checkbox = pipeline_checkbox_for(pipeline_name)
      pipeline_checkbox.click if pipeline_checkbox.checked?
    end

    def apply_selection
      pipeline_selector_dropdown.find_button('Apply').click
    end

    def is_checked?(selector)
      pipeline_selector_dropdown.find(selector).checked?
    end

    def set_newly_created_pipeline_status(status)
      unless status == checked_status_for_newly_created_pipelines
        pipeline_selector_dropdown.find('#show-newly-created-pipelines').click
      end
    end

    def switch_to_environment_variables_tab
      environment_variables_tab.find('li', text: 'Environment variables', exact_text: true).click
    end

    def switch_to_secure_environment_variables_tab
      environment_variables_tab.find('li', text: 'Secure Environment variables', exact_text: true).click
    end

    def override_secure_env_variable(secure_env_variable_key,secure_env_variable_value)
      environment_variables_secure_key_value.find('dt' , text: "#{secure_env_variable_key}", exact_text: true).find(:xpath , '..').find('a' , text: 'Override').click
      environment_variables_secure_key_value.find('dt' , text: "#{secure_env_variable_key}", exact_text: true).find(:xpath , '..').find('.value').find('input').set(secure_env_variable_value)
    end  

    def change_variable_to(key,value)
      env_var_to_be_repalaced = environment_variables_key_value.find('dt' , text: "#{key}", exact_text: true).find(:xpath , '..').find('.value').find('input')
      replace_element_value(env_var_to_be_repalaced,value)
    end

    def material_revision_changed?(revision)
      revision[:class].include?('changed')
    end

    private

    def pipeline_checkbox_for(pipeline_name)
      pipeline_selector_dropdown.find("input#pipeline_#{scenario_state.actual_pipeline_name(pipeline_name)}")
    end

    def get_pipeline_checkboxes_for(pipeline_group_name)
      begin
        expand_pipeline_group(pipeline_group_name)
      rescue StandardError
        # do nothing the group is already expanded.
      end
      expanded_section = pipeline_group_checkbox_for(pipeline_group_name).first(:xpath, '../..')
      expanded_pipelines_section = expanded_section.all('.filter_pipeline-list')
      expanded_pipelines_section.first.all('.pipeline-cb')
    end

    def checked_status_for_newly_created_pipelines
      checked_status = is_checked?('#show-newly-created-pipelines')
      return 'checked' if checked_status
      'unchecked'
    end

    def pipeline_group_checkbox_for(pipeline_group_name)
      pipeline_selector_dropdown.find("input#pgroup_#{pipeline_group_name}")
    end

    def revisions(pipeline)
      (pipeline_name text: pipeline)
        .find(:xpath, '../../..')
        .find('.material_changes').all('.revisions')
    end
  end
end
