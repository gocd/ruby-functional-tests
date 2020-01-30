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
  class ElasticProfiles < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/elastic_agent_configurations"

    element :add_new_cluster_profile, "[data-test-id='pageActions']"

    element :modal_cluster_profile_id, "[data-test-id='form-field-input-id']"
    element :wizard_cluster_profile_id, "[data-test-id='form-field-input-cluster-profile-name']"
    element :plugin_id, "[data-test-id='form-field-input-plugin-id']"
    element :go_server_url, "input[ng-model='go_server_url']"
    element :auto_register_timeout, "input[ng-model='auto_register_timeout']"
    element :max_docker_containers, "input[ng-model='max_docker_containers']"
    element :env_variable, "textarea[ng-model='environment_variables']"
    element :docker_uri, "input[ng-model='docker_uri']"
    element :save_cluster_profile_btn, "[data-test-id='cluster-profile-save-btn']"

    element :save_and_exit_btn, "[data-test-id='save-cluster-profile']"
    element :previous_btn, "[data-test-id='previous']"
    element :next_btn, "[data-test-id='next']"
    element :finish_btn, "[data-test-id='finish']"

    element :modal_elastic_agent_profile_id, "[data-test-id='form-field-input-id']"
    element :wizard_elastic_agent_profile_id, "[data-test-id='form-field-input-elastic-profile-name']"
    element :selected_cluster_profile_id, "[data-test-id='form-field-input-cluster-profile-id']"
    element :image, "input[ng-model='Image']"
    element :modal_ok_btn, "[data-test-id='button-ok']"
    element :max_memory, "input[ng-model='MaxMemory']"

    element :confirm_delete, "button[data-test-id='button-delete']"
    element :k8s_config_properties, "#properties"
    element :error_flash_message, "div[data-test-id='flash-message-alert']"

    def save_cluster_profile
      save_cluster_profile_btn.click
    end

    def save_cluster_profile_and_exit
      save_and_exit_btn.click
    end

    def save_elastic_agent_profile
      finish_btn.click
    end

    def save_elastic_agent_profile_modal
      modal_ok_btn.click
    end

    def click_confirm_delete
      confirm_delete.click
    end

    def add_elastic_agent_profile(cluster_profile_id)
      cluster_profile_header(cluster_profile_id).find("button[data-test-id='new-elastic-agent-profile-button']").click
    end

    def has_selected_cluster_profile_id?(cluster_profile_id, plugin_name)
      page.has_css?("[data-test-id='form-field-input-cluster-profile-name']", text: "#{cluster_profile_id}")
      page.has_css?("[data-test-id='form-field-input-plugin-id']", text: "#{plugin_name}")
    end

    def has_elastic_agent?(elastic_agent_profile_id)
      page.has_css?("[data-test-id='elastic_profile_id']", text: elastic_agent_profile_id)
    end

    def edit_cluster_profile(cluster_profile_id)
      cluster_profile_header(cluster_profile_id).find("button[data-test-id='edit-cluster-profile']").click
    end

    def delete_cluster_profile(cluster_profile_id)
      cluster_profile_header(cluster_profile_id).find("button[data-test-id='delete-cluster-profile']").click
    end

    def clone_cluster_profile(cluster_profile_id)
      cluster_profile_header(cluster_profile_id).find("button[data-test-id='clone-cluster-profile']").click
    end

    def clone_elastic_agent_profile(cluster_id, elastic_agent_profile_id)
      expand_cluster_profile_header(cluster_id)
      elastic_agent_profile_header(cluster_id, elastic_agent_profile_id).find("button[data-test-id='clone-elastic-profile']").click
    end

    def edit_elastic_agent_profile(cluster_id, elastic_agent_profile_id)
      expand_cluster_profile_header(cluster_id)
      elastic_agent_profile_header(cluster_id, elastic_agent_profile_id).find("button[data-test-id='edit-elastic-profile']").click
    end

    def delete_elastic_agent_profile(cluster_id, elastic_agent_profile_id)
      expand_cluster_profile_header(cluster_id)
      elastic_agent_profile_header(cluster_id, elastic_agent_profile_id).find("button[data-test-id='delete-elastic-profile']").click
    end

    def expand_cluster_profile_header(cluster_profile_id)
      cluster_panel = cluster_profile_header(cluster_profile_id)
      cluster_panel.find("[data-test-id='plugin-icon']").click if cluster_panel[:'data-test-element-state'].eql? "collapsed"
    end

    def cluster_profiles_exists?(cluster_profile)
      page.has_css?("[data-test-id='cluster-profile-list']", text: cluster_profile)
    end

    def elastic_agent_profile_exist?(elastic_agent_profile_id)
      page.has_css?("div[data-test-id='elastic-profile-id']", text: elastic_agent_profile_id)
    end

    def banner_message
      page.find("div[data-test-id='flash-message-alert']", wait: 20).text
    end

    def error_message
      error_flash_message.text
    end

    def cluster_profile_header(cluster_profile_id)
      page.find("div[data-test-id='cluster-profile-name']", text: cluster_profile_id).ancestor("div[data-test-id='cluster-profile-panel']")
    end

    def elastic_agent_profile_header(cluster_profile_id, elastic_agent_profile_id)
      elastic_profile = cluster_profile_header(cluster_profile_id).find("div[data-test-id='elastic-profile-list']").find("div[data-test-id='elastic-profile-id']", text: elastic_agent_profile_id)
      elastic_profile.ancestor("[data-test-id='elastic-profile-header']")
    end

    def click_previous_button_on_wizard
      previous_btn.click
    end

    def click_next_button_on_wizard
      next_btn.click
    end

    def elastic_profile_operation_disabled?(cp, ep, operation)
      elastic_agent_profile_header(cp, ep).find("[data-test-id='#{operation}-elastic-profile']").disabled?
    end

    def cluster_profile_operation_disabled?(cp, operation)
      cluster_profile_header(cp).find("[data-test-id='#{operation}-cluster-profile']").disabled?
    end

  end
end
