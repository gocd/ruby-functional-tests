##########################################################################
# Copyright 2019 ThoughtWorks, Inc.
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
  class NewEnvironments < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/environments"

    element :add, "button[data-test-id='add-environment-button']"
    element :save, "button[data-test-id='button-save']"
    element :modal_save, "button[data-test-id='save-button']"
    element :input_id, "input[data-test-id='form-field-input-environment-name']"
    # element :profile_id, "[data-test-id='elastic-profile-id']"
    element :add_new_environment_button, "[data-test-id='add-environment-button']"


    def add_new_environment(env)
      add.click
      input_id.set(env)
      save.click
    end

    def verify_no_envs_available_message
      assert_true page.find("[data-test-id='no-environment-present-msg']").text.include? "Either no environments have been set up or you are not authorized to view the environments."
    end

    def has_environment(env)
      assert_true find_collapsible_header(env) != nil
    end

    def open_collapsible_for(env)
      page.find("[data-test-id='collapsible-panel-for-env-#{env}']").click
    end

    def edit_pipeline_association_for(env)
      page.find("div[data-test-id='pipelines-for-#{env}'] i[data-test-id=Edit-icon]").click
    end

    def associate_pipeline(pipeline)
      page.find("[data-test-id^='form-field-input-#{pipeline}']").click
      modal_save.click
    end

    def has_pipeline (pipeline, env)
      assert_true page.find("[data-test-id='pipelines-for-#{env}'] ul[data-test-id='pipelines-content']").text.include? pipeline
    end

    def edit_agent_association_for(env)
      page.find("div[data-test-id='agents-for-#{env}'] i[data-test-id=Edit-icon]").click
    end

    def associate_agent(agent)
      page.find("[data-test-id^='form-field-input-#{agent}']").click
      modal_save.click
    end

    def has_agent (agent, env)
      assert_true page.find("[data-test-id='agents-for-#{env}'] ul[data-test-id='agents-content']").text.include? agent
    end

    def find_collapsible_header(id)
      page.all("div[data-test-id='collapse-header']")
          .find {|widget| widget.find("div[data-test-id='environment-header-for-#{id}']")}
    end
  end
end
