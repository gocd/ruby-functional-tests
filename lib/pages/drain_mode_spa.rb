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
  class DrainModePage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/drain_mode"
    element :settings_save, 'button[data-test-id="button-save"]'
    element :drain_mode_switch, 'div[data-test-id="switch-wrapper"]'
    element :in_progress_subsystems, 'div[data-test-id="in-progress-subsystems"]'

    load_validation { has_drain_mode_switch? }

    def drain_complete?
      page.has_css?('div', text: 'GoCD Server is completely drained.', wait: 60)
    end

    def drain_mode_enabled?
      drain_complete? || drain_in_progress?
    end

    def drain_in_progress?
      page.has_css?('div', text: 'Some subsystems of GoCD are still in progress.', wait: 60)
    end

    def cancel_stage(pipeline, pipeline_counter, stage, stage_counter)
      page.find('div[data-test-id="in-progress-subsystems"]', wait: 60).find("button[data-test-id='cancel-stage-btn-for-#{pipeline}/#{pipeline_counter}/#{stage}/#{stage_counter}']", wait: 20).click
      reload_page
    end

    def stage_in_inprogress_subsystem(pipeline, pipeline_counter, stage, stage_counter)
      page.find('div[data-test-id="in-progress-subsystems"]', wait: 60).has_css?("button[data-test-id='cancel-stage-btn-for-#{pipeline}/#{pipeline_counter}/#{stage}/#{stage_counter}']", wait: 20)
    end

    def switch_drain_mode
      drain_mode_switch.click
      settings_save.click(wait: 10)
    end

    def shows_running_mdu_for_material(name)
      page.has_css?('div[data-test-id="key-value-value-name"]', text: name)
    end

    def drain_mode_banner_shown?
      page.has_css?('div[data-test-id="drain-mode-banner"]')
    end

    def disable_drain_mode
      switch_drain_mode if drain_mode_enabled?
    end
  end
end
