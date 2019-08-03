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
  class PipelineCreationWizard < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/pipeline/create{?group*}"

    # Pipeline name and group
    element :new_pipeline_name, "[data-test-id='form-field-input-pipeline-name']"
    element :reset_button, '.reset_button'

    # pipeline materials
    element :material_type, "[data-test-id='form-field-input-material-type']"
    element :upstream_pipeline, "[data-test-id='form-field-input-upstream-pipeline']"
    element :upstream_stage, "[data-test-id='form-field-input-upstream-stage']]"
    element :material_url, "[data-test-id='form-field-input-repository-url']"
    element :project_path, "[data-test-id='form-field-input-project-path']"
    element :check_connection, "[data-test-id='test-connection-button']"

    # Stage details
    element :stage_name, "[data-test-id='form-field-input-stage-name']"
    element :auto_trigger_switch, "[data-test-id='switch-paddle']"

    #jobs
    element :job_name, "[data-test-id='form-field-input-job-name']"
    element :task_command, "[data-test-id='form-field-label-type-your-tasks-below-at-the-prompt'] > code > pre"


    def set_task_field(task_name, field, value)
      page.find("#pipeline_group_pipeline_stage_jobs__tasks_#{task_name}_#{field}").set value
    end



    def set_material_url_for(material, url)
      material_url.set(url)
    end





    def select_approval_type type
      page.find("#{type}").click
    end

    def connection_ok?
      page.has_css?('.ok_message')
    end

    def set_polling_off (material_type)
      auto_trigger_switch.click
    end

    def git_error_message_present?(error_message,material_type)
      page.find("#vcsconnection-message_#{material_type}").text.include? error_message
    end

    def set_username(material_type,username)
      page.find(".#{material_type}_username").set username
    end

    def set_password(material_type,password)
      page.find(".#{material_type}_password").set password
    end

    def set_branch(branch,material_type)
      page.find(".#{material_type}_branch").set branch
    end

  end
end
