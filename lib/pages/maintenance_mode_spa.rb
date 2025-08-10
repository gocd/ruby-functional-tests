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
  class MaintenanceModePage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/maintenance_mode"
    element :settings_save, 'button[data-test-id="button-save"]'
    element :maintenance_mode_switch, 'label[data-test-id="switch-paddle"]'
    element :in_progress_subsystems, 'div[data-test-id="in-progress-subsystems"]'
    element :flash_message, "div[data-test-id='flash-message-success']"

    load_validation { has_maintenance_mode_switch? }

    def maintenance_complete?
      page.has_css?('div', text: 'GoCD Server has no running subsystems.')
    end

    def maintenance_in_progress?
      page.has_css?('div', text: 'Some subsystems of GoCD are still in progress.')
    end

    def maintenance_mode_enabled?(wait = 2)
      page.has_css?('div', text: /GoCD Server has no running subsystems|Some subsystems of GoCD are still in progress/, wait: wait)
    end

    def cancel_stage(pipeline, pipeline_counter, stage, stage_counter)
      page.find("button[data-test-id='cancel-stage-btn-for-#{pipeline}/#{pipeline_counter}/#{stage}/#{stage_counter}']").click
      page.has_css?("div[data-test-id='flash-message-success']", text: 'stage defaultStage successfully cancelled', wait: 10)

    end

    def stage_in_inprogress_subsystem(pipeline, pipeline_counter, stage, stage_counter)
      reload_page
      page.find('div[data-test-id="in-progress-subsystems"]').has_css?("button[data-test-id='cancel-stage-btn-for-#{pipeline}/#{pipeline_counter}/#{stage}/#{stage_counter}']", wait: 10)
    end

    def switch_maintenance_mode
      maintenance_mode_switch.click
      settings_save.click
    end

    def shows_running_mdu_for_material(name)
      page.has_css?('div[data-test-id="key-value-value-name"]', text: name)
    end

    def maintenance_mode_banner_shown?
      page.has_css?('div[data-test-id="maintenance-mode-banner"]')
    end

    def disable_maintenance_mode
      switch_maintenance_mode if maintenance_mode_enabled?(0)
    end
  end
end
