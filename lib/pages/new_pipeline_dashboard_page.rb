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
    element :dashboard_container, '.dashboard-container'
    elements :pipeline_group_title, '.dashboard-group_name'
    element :material_for_trigger, '.material-for-trigger'
    iframe :build_time_chart, PipelineBuildTime, 0
    element :stage_name, '.stage_name'
    element :environment_variables_tab, '.h-tab_tab-head.pipeline_options-heading'
    element :environment_variables_key_value, '.environment-variables.plain.key-value-pair'
    element :environment_variables_secure_key_value, '.environment-variables.secure.key-value-pair'

    load_validation { has_dashboard_container? }

    def admin?
      page.has_css?("[data-is-user-admin='true']")
    end

    def trigger_pipeline(name: scenario_state.self_pipeline, wait_to_build: false)
      (pipeline_name text: name)
        .ancestor('.pipeline').find('.pipeline_btn.play').click
      wait_till_pipeline_start_building if wait_to_build
    end

    def trigger_pipeline_disabled?
      begin
        (pipeline_name text: scenario_state.self_pipeline)
          .ancestor('.pipeline').find('.pipeline_btn.play.disabled', wait: 5)
      rescue StandardError
        return false
      end
      true
    end

    def trigger_pipeline_with_options
      (pipeline_name text: scenario_state.self_pipeline)
        .ancestor('.pipeline').find('.pipeline_btn.play_with_options').click
    end

    def trigger_pipeline_with_options_disabled?
      (pipeline_name text: scenario_state.self_pipeline)
        .ancestor('.pipeline').has_css?('.pipeline_btn.play_with_options.disabled')
    end

    def pause_pipeline(reason)
      (pipeline_name text: scenario_state.self_pipeline)
        .ancestor('.pipeline').find('.pipeline_btn.pause').click
      page.find('.modal-body').find('input').set(reason)
      page.find('.modal-buttons').find('button', text: 'OK').click
    end

    def pause_message?(message)
      (pipeline_name text: scenario_state.self_pipeline)
        .ancestor('.pipeline').has_selector?('.pipeline_pause-message', text: message)
    end

    def unpause_pipeline
      (pipeline_name text: scenario_state.self_pipeline)
        .ancestor('.pipeline').find('.pipeline_btn.unpause').click
    end

    def get_all_stages(pipeline) # This one needs to be relooked - the way the view is modelled do not make it easy to get latest stage state
      reload_page
      (pipeline_name text: pipeline)
        .ancestor('.pipeline').find('.pipeline_instance', wait: 10).find('.pipeline_stages').all('a')
    rescue StandardError => e
      p 'Looks like Pipeline still not started, trying after page reload...'
      nil
    end

    def get_pipeline_stage_state(pipeline, stagename) # This need relook too
      return if get_all_stages(pipeline).nil?
      target_stage = get_all_stages(pipeline).select { |stage| stage['href'].include?(stagename) }
      target_stage.first['class']
    end

    def verify_pipeline_is_at_label(pipeline, label)
      assert_true (pipeline_name text: pipeline)
        .ancestor('.pipeline').find('.pipeline_instance-label').text.include?(label)
    end

    def verify_pipeline_stays_at_label(pipeline, label)
      wait_for_event 30, "Pipeline #{pipeline} label verification timed out" do
        reload_page
        raise "Pipeline #{pipeline} got trigerred. Expected not to" if (pipeline_name text: pipeline)
                        .ancestor('.pipeline').find('.pipeline_instance-label').text.include?((label.to_i+1).to_s)
      end
    end

    def verify_stage_counter_on_pipeline(pipeline, stage, label, counter)
      expected_stage_counter_url = "/go/pipelines/#{pipeline}/#{label}/#{stage}/#{counter}"
      actual_stage_counter_url = ""
      (pipeline_name text: pipeline).ancestor('.pipeline').find('.pipeline_instance', wait: 30).all('.pipeline_stages a').each{ |element|
        actual_stage_counter_url=element['href'].match(/\/go.*/)[0] if element['href'].include?stage
      }
      assert_equal actual_stage_counter_url,  expected_stage_counter_url
    end

    def verify_pipeline_stage_state(pipeline, stage, state)
      wait_till_event_occurs_or_bomb 120, "Pipeline #{pipeline} stage #{stage} is not in #{state} state" do
        next if get_pipeline_stage_state(pipeline, stage).nil?
        break if get_pipeline_stage_state(pipeline, stage).include?(state)
      end
    end

    def wait_till_pipeline_start_building(wait_time = 60)
      wait_till_event_occurs_or_bomb wait_time, "Pipeline #{scenario_state.self_pipeline} failed to start building" do
        return if get_all_stages(scenario_state.self_pipeline).nil?
        break if get_all_stages(scenario_state.self_pipeline).first['class'].include?('building')
      end
    end


    def wait_for_expected_stage_state pipeline, stage, state, wait_time
      wait_till_event_occurs_or_bomb wait_time, "Pipeline #{pipeline} stage #{stage} is not in #{state} state" do
        next if get_pipeline_stage_state(pipeline, stage).nil?
        break if get_pipeline_stage_state(pipeline, stage).include?(state)
      end
    end

    def wait_to_check_pipeline_do_not_start(wait_time = 20)
      wait_till_event_occurs_or_bomb wait_time, "Pipeline #{scenario_state.self_pipeline} started building when it was expected not to" do
        return if get_all_stages(scenario_state.self_pipeline).nil?
        break unless get_all_stages(scenario_state.self_pipeline).first['class'].include?('building')
      end
    end

    def wait_till_pipeline_complete(wait_time = 120)
      wait_till_event_occurs_or_bomb wait_time, "Pipeline #{scenario_state.self_pipeline} failed to complete with in timeout" do
        return if get_all_stages(scenario_state.self_pipeline).nil?
        break unless get_all_stages(scenario_state.self_pipeline).last['class'].include?('building')
      end
    end

    def wait_till_stage_complete(stage)
      wait_till_event_occurs_or_bomb 60, "Pipeline #{scenario_state.self_pipeline} Stage #{stage} failed to complete with in timeout" do
        return if get_pipeline_stage_state(scenario_state.self_pipeline, stage).nil?
        break unless get_pipeline_stage_state(scenario_state.self_pipeline, stage).include?('building')
      end
    end

    def editable?
      !((pipeline_name text: scenario_state.self_pipeline)
        .ancestor('.pipeline').has_css?('.edit_config.disabled') ||
        (pipeline_name text: scenario_state.self_pipeline)
        .ancestor('.pipeline').has_css?('.has-tip.info_config.disabled'))
    end

    def edit_pipeline(_pipeline)
      !(pipeline_name text: scenario_state.self_pipeline)
        .ancestor('.pipeline').find('.edit_config').click
    end

    def locked?
      (pipeline_name text: scenario_state.self_pipeline)
        .ancestor('.pipeline').has_css?('.pipeline_locked')
    end

    def unlock
      sleep 5
      (pipeline_name text: scenario_state.self_pipeline)
        .ancestor('.pipeline').find('.pipeline_locked').click
    end

    def open_build_analytics
      (pipeline_name text: scenario_state.self_pipeline)
        .ancestor('.pipeline').find('.pipeline-analytics').click
    end

    def build_time_graph_displayed?
      page.has_css?('h5', text: "Analytics for pipeline: #{scenario_state.self_pipeline}")
      build_time_chart do |frame|
        frame.find('#chart-container').has_css?('.highcharts-series-group')
      end
    end

    def mttr_displayed?
      build_time_chart do |frame|
        frame.find('#chart-container').has_css?('.mttr') &&
          !frame.find('#chart-container').find('.mttr').find('.metric-value').text.match(/[1-9][0-9]*[ms]/)[0].nil?
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
        selected_pipeline_group = pipeline_group.select { |grp| grp.find('.dashboard-group_name').text == group }.first
        unless selected_pipeline_group.nil?
          pipelines = selected_pipeline_group.all('.pipeline_name')
          return pipelines.select { |pipeline| pipeline.text == scenario_state.self_pipeline }.any?
        end
      end
    end

    def pipeline_history_exists?
      (pipeline_name text: scenario_state.self_pipeline)
        .ancestor('.pipeline').has_selector?('.pipeline_instances', visible: true)
    end

    def visible?(pipeline = scenario_state.self_pipeline)
      has_pipeline_name? text: (scenario_state.get(pipeline) || pipeline)
    end

    def wait_till_pipeline_showsup(pipeline, timeout = 120)
      wait_till_event_occurs_or_bomb timeout, "Pipeline #{scenario_state.get(pipeline)} failed to showup on dashboard" do
        reload_page
        break if visible?(pipeline)
      end
    end

    def click_history
      (pipeline_name text: scenario_state.self_pipeline)
        .ancestor('.pipeline').find('.pipeline_history').click
    end

    def trigger_cancel_pipeline(trigger_number)
      (0...trigger_number.to_i).each do |_number|
        trigger_pipeline(wait_to_build: true)
        cancel_pipeline
      end
    end

    def cancel_pipeline
      (pipeline_name text: scenario_state.self_pipeline)
        .ancestor('.pipeline').find('.pipeline_stage.building').click

      (stage_name text: scenario_state.get('current_stage_name'))
        .ancestor('.pipeline').find('.stage_action').click

      page.find('#app-menu').find('a', text: 'DASHBOARD').click
    end

    def open_build_cause
      (pipeline_name text: scenario_state.self_pipeline)
        .ancestor('.pipeline').find('.changes').click
    end

    def revision_of_material(type, name)
      revisions(scenario_state.self_pipeline).select do |material|
        material.find('.rev-head').text.include? "#{type} - #{name}"
      end .first
    end

    def shows_revision_at?(revision_element, revision, position = 0)
      revision_class = scenario_state.get('current_material_type') == 'Pipeline' ? '.modified_by' : '.revision_id'
      revision_element.all('.modifications')[position].has_css?(revision_class, text: revision, exact_text: true)
    end

    def triggered_by?(user)
      (pipeline_name text: scenario_state.self_pipeline)
        .ancestor('.pipeline')
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

    def click_vsm(pipeline)
      (pipeline_name text: pipeline)
        .ancestor('.pipeline')
        .find('a', text: 'VSM').click
    end

    def click_compare(pipeline)
      (pipeline_name text: pipeline)
        .ancestor('.pipeline')
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

    def switch_to_environment_variables_tab
      environment_variables_tab.find('li', text: 'Environment variables', exact_text: true).click
    end

    def switch_to_secure_environment_variables_tab
      environment_variables_tab.find('li', text: 'Secure Environment variables', exact_text: true).click
    end

    def override_secure_env_variable(secure_env_variable_key, secure_env_variable_value)
      environment_variables_secure_key_value.find('dt', text: secure_env_variable_key.to_s, exact_text: true).sibling('.value').find('a', text: 'Override').click
      environment_variables_secure_key_value.find('dt', text: secure_env_variable_key.to_s, exact_text: true).sibling('.value').find('input').set(secure_env_variable_value)
    end

    def change_variable_to(key, value)
      env_var_to_be_repalaced = environment_variables_key_value.find('dt', text: key.to_s, exact_text: true).sibling('.value').find('input')
      replace_element_value(env_var_to_be_repalaced, value)
    end

    def material_revision_changed?(revision)
      revision[:class].include?('changed')
    end

    def can_operate_using_ui?
      !(pipeline_name text: scenario_state.self_pipeline).ancestor('.pipeline_header').find('.pipeline_operations').find("button[title='Trigger Pipeline']")['class'].include? 'disabled'
    rescue StandardError => e
      p "Pipeline operate check failed with ERROR: #{e}"
      false
    end

    def can_operate_using_api?
      response = RestClient.post http_url("/api/pipelines/#{scenario_state.self_pipeline}/schedule"), {}, { accept: 'application/vnd.go.cd+json', X_GoCD_Confirm: 'true' }.merge(basic_configuration.header)
      (response.code == 202)
    rescue RestClient::ExceptionWithResponse => err
      p "Pipeline API call failed with response code #{err.response.code} and the response body - #{err.response.body}"
      false
    end

    def can_pause_using_ui?
      !(pipeline_name text: scenario_state.self_pipeline).ancestor('.pipeline_header').find('.pipeline_operations').find("button[title='Pause Pipeline']")['class'].include? 'disabled'
    rescue StandardError => e
      p "Pipeline pause check failed with ERROR: #{e}"
      false
    end

    def can_pause_using_api?
      pause_using_api?
      unpause_using_api?
    end

    def unpause_using_api?
      response = RestClient.post http_url("/api/pipelines/#{scenario_state.self_pipeline}/unpause"), {}, { accept: 'application/vnd.go.cd+json', X_GoCD_Confirm: 'true' }.merge(basic_configuration.header)
      (response.code == 200)
    rescue RestClient::ExceptionWithResponse => err
      p "Pipeline API call failed with response code #{err.response.code} and the response body - #{err.response.body}"
      false
    end

    def pause_using_api?
      response = RestClient.post http_url("/api/pipelines/#{scenario_state.self_pipeline}/pause"), {}, { accept: 'application/vnd.go.cd+json', X_GoCD_Confirm: 'true' }.merge(basic_configuration.header)
      (response.code == 200)
    rescue RestClient::ExceptionWithResponse => err
      p "Pipeline API call failed with response code #{err.response.code} and the response body - #{err.response.body}"
      false
    end

    def unset_auto_sceduling
      page.find("#pipeline_approval_type").set(false)  if page.find("#pipeline_approval_type").checked?
    end

    def set_auto_sceduling
      page.find("#pipeline_approval_type").set(true)  if page.find("#pipeline_approval_type").checked?
    end

    def auto_sceduling_selected?
      page.find("#pipeline_approval_type").checked?
    end

    def auto_sceduling_enabled?
      page.find("#pipeline_approval_type").disabled?
    end

    def admin_link_visible?
      page.has_css?('ul li a', text:'Admin')
    end

    def set_fingerprint current_material_url
      response = begin
                   RestClient.get http_url("/api/config/materials"), { accept: 'application/vnd.go.cd+json' }.merge(basic_configuration.header)
                 rescue RestClient::ExceptionWithResponse => err
                   p "Get All Material call failed with response code #{err.response.code} and the response body - #{err.response.body}"
                 end
      JSON.parse(response.body)['_embedded']['materials'].each{|material|
        if !material['attributes']['url'].nil?
          if material['attributes']['url'].include? current_material_url
              scenario_state.put('fingerprint',material['fingerprint'])
              break
          end
        end
      }
    end

    private

    def revisions(pipeline)
      (pipeline_name text: pipeline)
        .ancestor('.pipeline')
        .find('.material_changes').all('.revisions')
    end
  end
end
