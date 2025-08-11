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
  class PipelineCreationWizard < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/pipelines/create{?group*}"

    # Pipeline name and group
    element :new_pipeline_name, "[data-test-id='form-field-input-pipeline-name']"

    # pipeline materials
    element :material_type, "[data-test-id='form-field-input-material-type']"
    element :upstream_pipeline, "[data-test-id='form-field-input-upstream-pipeline']"
    element :upstream_stage, "[data-test-id='form-field-input-upstream-stage']]"
    element :material_url, "[data-test-id='form-field-input-repository-url']"
    element :project_path, "[data-test-id='form-field-input-project-path']"
    element :check_connection, "[data-test-id='test-connection-button']"
    element :material_branch, "[data-test-id='form-field-input-repository-branch']"
    element :material_username, "[data-test-id='form-field-input-username']"
    element :material_password, "[data-test-id='form-field-input-password']"
    element :material_checkout_path, "[data-test-id='form-field-input-alternate-checkout-path']"
    element :material_name, "[data-test-id='form-field-input-material-name']"

    # Stage details
    element :stage_name, "[data-test-id='form-field-input-stage-name']"
    element :auto_trigger_switch, "[data-test-id='switch-paddle']"

    # jobs
    element :job_name, "[data-test-id='form-field-input-job-name']"
    element :task_command, "[data-test-id='form-field-label-type-your-tasks-below-at-the-prompt'] > code > pre"

    # #task-details
    element :exec_tas_command, '.exec-task-command'

    def set_task_field(task_with_args)
      page.find("[data-test-id='form-field-label-type-your-tasks-below-at-the-prompt']").sibling('code').find('pre').set(task_with_args, rapid: false)
    end

    def set_material_url(url)
      material_url.set(url, rapid: false)
    end

    def select_approval_type(_type)
      page.all('dt', text: 'Advanced Settings')[2].click
      auto_trigger_switch.click
    end

    def connection_ok?
      page.has_css?("[data-test-id='flash-message-success']", wait: 10)
    end

    def set_polling_off(_material_type)
      raise 'Needs implementation as new pipeline creation wizard misses this option'
    end

    def git_error_message_present?(error_message, material_type)
      page.find("[data-test-id='flash-message-alert']").text.include? error_message
    end

    def set_username(username)
      material_username.set(username, rapid: false)
    end

    def set_password(password)
      material_password.set(password, rapid: false)
    end

    def set_branch(branch)
      material_branch(wait: 10).set(branch, rapid: false)
    end

    def open_material_advanced_settings
      page.all('dt', text: 'Advanced Settings').first.click
    end

    def save_and_edit
      page.find('button', text: 'Save + Edit Full Config', wait: 10).click
    end

    def save_and_run
      page.find('button', text: 'Save + Run This Pipeline').click
    end
  end
end
