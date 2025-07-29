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
      (pipeline_name text: name).ancestor('.pipeline').find('.pipeline_btn.play').click
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
      page.find('.modal-body').find('input').set(reason, rapid: false)
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
        .ancestor('.pipeline')
        .find('.pipeline_instance')
        .find('.pipeline_stages')
        .all('.pipeline_stage_manual_gate_wrapper .pipeline_stage')
    rescue StandardError => e
      # p "Looks like Pipeline #{pipeline} still not started, trying after page reload... [#{e}]"
      nil
    end

    def get_all_stages_at_label(pipeline, label)
      reload_page
      (pipeline_name text: pipeline)
        .ancestor('.pipeline')
        .find(:xpath, ".//div[*[@class='pipeline_instance-label' and string(.)='Instance: #{label}']]")
        .find('.pipeline_stages')
        .all('.pipeline_stage_manual_gate_wrapper .pipeline_stage')
    rescue StandardError => e
      # p "Looks like Pipeline #{pipeline} with label #{label} still not started, trying after page reload... [#{e}]"
      nil
    end


    def get_manual_gate(pipeline, stagename)
      target_stage = get_all_stages(pipeline).select { |stage| (stage['title'] || {}).include?(stagename)}
      parent = target_stage.first.find(:xpath,".//..")
      parent.find('.manual_gate')
    end

    def is_stage_manual(pipeline, stagename)
      !get_manual_gate(pipeline, stagename).nil?
    rescue StandardError => e
      false
    end

    def verify_pipeline_is_at_label(pipeline, label)
      assert_true (pipeline_name text: pipeline)
        .ancestor('.pipeline').find('.pipeline_instance-label').text.include?(label)
    end

    def verify_pipeline_stays_at_label(pipeline, label)
      wait_till_event_occurs_or_bomb 30, "Pipeline #{pipeline} label verification timed out" do
        reload_page
        raise "Pipeline #{pipeline} got triggered. Expected not to" if (pipeline_name text: pipeline)
                        .ancestor('.pipeline')
                        .find('.pipeline_instance-label')
                        .text.include?((label.to_i+1).to_s)
      end
    end

    def get_pipeline_stage_state(pipeline, stagename)
      # p "getting stage state for pipeline: #{pipeline} and stage: #{stagename}"
      all_stages = get_all_stages(pipeline)
      return if all_stages.nil?
      target_stage = all_stages.select { |stage| (stage['title'] || {}).include?(stagename)}
      (target_stage.first || {})['class']
    end

    def get_pipeline_stage_at_label(pipeline, stagename, label)
      # p "getting stage state for pipeline: #{pipeline} and stage: #{stagename} at label: #{label}"
      all_stages = get_all_stages_at_label(pipeline, label)
      return if all_stages.nil?
      all_stages.select { |stage| (stage['title'] || {}).include?(stagename) }
    end

    def wait_for_expected_stage_state(pipeline, stage, state, wait_time = 60)
      wait_till_event_occurs_or_bomb wait_time, "Pipeline #{pipeline} stage #{stage} is not in #{state} state" do
        pipeline_stage_state = get_pipeline_stage_state(pipeline, stage)
        next if pipeline_stage_state.nil?
        break if pipeline_stage_state.include?(state)
      end
    end

    def wait_for_expected_stage_state_at_label(pipeline, stage, state, label)
      wait_till_event_occurs_or_bomb 60, "Pipeline #{pipeline} at label #{label}'s stage #{stage} is not in #{state} state" do
        pipeline_stage = get_pipeline_stage_at_label(pipeline, stage, label)
        pipeline_stage_state = pipeline_stage.first['class'] if pipeline_stage&.first
        break if pipeline_stage_state&.include?(state)
      end
    end

    def wait_for_expected_stage_state_at_label_and_counter(pipeline, stage, state, label, counter)
      wait_till_event_occurs_or_bomb 60, "Pipeline #{pipeline} at label #{label}'s stage #{stage} is not in #{state} state for counter #{counter}" do
        pipeline_stage = get_pipeline_stage_at_label(pipeline, stage, label)
        pipeline_stage_state = pipeline_stage.first['class'] if pipeline_stage&.first
        next unless pipeline_stage_state&.include?(state)

        # Check the stage counter
        expected_stage_counter_url = "/go/pipelines/#{pipeline}/#{label}/#{stage}/#{counter}"
        pipeline_stage.first.click
        url = stage_overview_stage_details_link['href']
        actual_stage_counter_url = '/go' + (url.split '/go')[1]

        break if actual_stage_counter_url == expected_stage_counter_url
      end
    end

    def verify_pipeline_stage_is_manual(pipeline, stage)
      assert_true is_stage_manual(pipeline, stage)
    end

    def verify_pipeline_stage_is_not_manual(pipeline, stage)
      assert_false is_stage_manual(pipeline, stage)
    end

    def manually_trigger_stage(pipeline, stage)
      reload_page
      manual_gate = get_manual_gate(pipeline, stage)
      manual_gate.click
      page.find('.manual-stage-trigger-body').text.include?("Do you want to trigger stage '#{stage}'?")

      page.find('.button.save.primary').click

      sleep 5
      reload_page
    end

    def verify_manual_stage_state(pipeline, stage, enabled)
      reload_page
      manual_gate = get_manual_gate(pipeline, stage)
      is_disabled = manual_gate['class'].include?('disabled')
      assert_equal !is_disabled, enabled
    end

    def verify_manual_stage_message(pipeline, stage, message)
      reload_page
      manual_gate = get_manual_gate(pipeline, stage)
      is_disabled = manual_gate['class'].include?('disabled')

      if is_disabled
        target_stage = get_all_stages(pipeline).select { |s| s['title'].include?(stage)}
        parent = target_stage.first.find(:xpath,".//..")
        assert_true parent.find('.tooltip', :visible => false).text(:all).include?(message)
      else
        assert_true manual_gate['title'].include?(message)
      end
    end

    def wait_till_pipeline_start_building(wait_time = 60)
      wait_till_event_occurs_or_bomb wait_time, "Pipeline #{scenario_state.self_pipeline} failed to start building" do
        all_stages = get_all_stages(scenario_state.self_pipeline)
        break if all_stages&.first and (all_stages.first['class'] || "").include?('building')
      end
    end

    def wait_to_check_pipeline_do_not_start(wait_time = 20)
      wait_till_event_occurs wait_time do
        all_stages = get_all_stages(scenario_state.self_pipeline)

        # Keep waiting if we have no stages, we don't know if it will trigger at some point
        next if all_stages&.last.nil?

        # Fail fast if the last stage ever mentions it is building
        raise "Pipeline #{scenario_state.self_pipeline} started building when it was expected not to" if (all_stages.last['class'] || "").include?('building')
      end
    end

    def wait_till_pipeline_complete(wait_time = 60)
      wait_till_event_occurs_or_bomb wait_time, "Pipeline #{scenario_state.self_pipeline} failed to complete" do
        all_stages = get_all_stages(scenario_state.self_pipeline)
        next if all_stages&.last.nil? or all_stages.last['class'].nil?
        break unless all_stages.last['class'].include?('building')
      end
    end

    def wait_till_stage_complete(stage)
      wait_till_event_occurs_or_bomb 60, "Pipeline #{scenario_state.self_pipeline} Stage #{stage} failed to complete" do
        pipeline_stage_state = get_pipeline_stage_state(scenario_state.self_pipeline, stage)
        next if pipeline_stage_state.nil?
        break unless pipeline_stage_state.include?('building')
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

    def wait_till_pipeline_showsup(pipeline, wait_time = 120)
      wait_till_event_occurs_or_bomb wait_time, "Pipeline #{scenario_state.get(pipeline)} failed to showup on dashboard" do
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

      page.find('i[data-test-id="Cancel Stage-icon"]').click

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
      page.find('.material-revision-search').set(scenario_state.material_revision(identifier), rapid: false)
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
      environment_variables_secure_key_value.find('dt', text: secure_env_variable_key.to_s, exact_text: true).sibling('.value').find('input').set(secure_env_variable_value, rapid: false)
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
        unless material['attributes']['url'].nil?
          if material['attributes']['url'].include? current_material_url
              scenario_state.put('fingerprint',material['fingerprint'])
              break
          end
        end
      }
    end

    def open_stage_overview(pipeline, stage)
      target_stage = get_all_stages(pipeline).select { |s| s['title'].include?(stage)}
      target_stage.first.click
    end

    def verify_stage_overview_header(pipeline, pipeline_counter, stage, stage_counter)
      assert_true page.find('div[data-test-id="pipeline-name-container"]').text.include?(pipeline)
      assert_true page.find('div[data-test-id="pipeline-instance-container"]').text.include?(pipeline_counter)
      assert_true page.find('div[data-test-id="stage-name-container"]').text.include?(stage)
      assert_true page.find('div[data-test-id="stage-instance-container"]').text.include?(stage_counter)
    end

    def select_stage_counter_from_stage_overview_header(counter)
      page.find('select[data-test-id="form-field-input-"]').select counter
    end

    def verify_stage_overview_triggered_by_user(username)
      assert_true page.find('div[data-test-id="triggered-by-container"]').text.include?(username)
    end

    def verify_stage_overview_cancelled_by_user(username)
      assert_true page.find('div[data-test-id="cancelled-by-container"]').text.include?(username)
    end

    def verify_stage_overview_element_not_empty(data_test_id)
      assert_false page.find("div[data-test-id='#{data_test_id}']").text.empty?
    end

    def verify_stage_overview_rerun_stage_is_enabled
      assert_false page.find("[data-test-id='Repeat-icon']").disabled?
    end

    def verify_stage_overview_cancel_stage_is_enabled
      assert_false page.find("[data-test-id='Cancel Stage-icon']").disabled?
    end

    def verify_stage_overview_stage_settings_is_enabled
      assert_false page.find("[data-test-id='Settings-icon']").disabled?
    end

    def verify_stage_overview_rerun_stage_is_disabled
      page.find("[data-test-id='Repeat-icon'][data-test-disabled-element]")
    end

    def verify_stage_overview_stage_settings_is_disabled
      page.find("[data-test-id='Settings-icon'][data-test-disabled-element]")
    end

    def open_stage_settings_from_stage_overview_and_verify_url(url)
      page.find("[data-test-id='Settings-icon']").click
      sleep 5
      assert_true page.current_url.include?(url)
    end

    def open_stage_details_from_stage_overview_and_verify_url(url)
      stage_overview_stage_details_link.click
      sleep 5
      assert_true page.current_url.include?(url)
    end

    def stage_overview_rerun_stage
      page.find("[data-test-id='Repeat-icon']").click
      sleep 11
    end

    def stage_overview_cancel_stage
      page.find("[data-test-id='Cancel Stage-icon']").click
      sleep 11
    end

    def stage_overview_verify_job_state(job, state)
      assert_false page.find("[data-test-id='job-name-for-#{job}']").nil?
      assert_true page.find("[data-test-id='job-name-for-#{job}']").find('div[class*="job-result"]')[:class].include?(state)
    end

    def select_job_for_rerun(job)
      page.find("[data-test-id='checkbox-for-#{job}']").find('input').check
    end

    def rerun_failed_jobs
      page.find("[data-test-id='job-rerun-container']").find_all('button')[0].click
    end

    def rerun_selected_jobs
      page.find("[data-test-id='job-rerun-container']").find_all('button')[1].click
    end

    def stage_overview_verify_rerun_failed_btn_state(is_enabled)
      assert_equal !page.find("[data-test-id='job-rerun-container']").find_all('button')[0].disabled?, is_enabled
    end

    def stage_overview_verify_rerun_selected_btn_state(is_enabled)
      assert_equal !page.find("[data-test-id='job-rerun-container']").find_all('button')[1].disabled?, is_enabled
    end

    def stage_overview_verify_failed_job_count(count)
      assert_true page.find("[data-test-id='failed-jobs-container']").text.include?(count)
    end

    def stage_overview_verify_passed_job_count(count)
      assert_true page.find("[data-test-id='passed-jobs-container']").text.include?(count)
    end

    def stage_overview_verify_building_job_count(count)
      assert_true page.find("[data-test-id='in-progress-jobs-container']").text.include?(count)
    end

    private

    def stage_overview_stage_details_link
      page.find('[data-test-id="stage-details-page-link"]').find('a')
    end

    def revisions(pipeline)
      (pipeline_name text: pipeline)
        .ancestor('.pipeline')
        .find('.material_changes').all('.revisions')
    end
  end
end
