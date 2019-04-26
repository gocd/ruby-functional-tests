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
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/elastic_profiles"

    element :add_new_cluster_profile, "[data-test-id='pageActions']"

    element :cluster_profile_id, "[data-test-id='form-field-input-id']"
    element :plugin_id, "[data-test-id='form-field-input-plugin-id']"
    element :go_server_url, "input[ng-model='go_server_url']"
    element :auto_register_timeout, "input[ng-model='auto_register_timeout']"
    element :max_docker_containers, "input[ng-model='max_docker_containers']"
    element :env_variable, "textarea[ng-model='environment_variables']"
    element :docker_uri, "input[ng-model='docker_uri']"
    element :save_cluster_profile_btn, "[data-test-id='cluster-profile-save-btn']"

    element :elastic_agent_profile_id, "[data-test-id='form-field-input-id']"
    element :selected_cluster_profile_id, "[data-test-id='form-field-input-cluster-profile-id']"
    element :image, "input[ng-model='Image']"
    element :save_elastic_agent_profile_btn, "button[data-test-id='button-ok']"

    element :confirm_delete, "button[data-test-id='button-delete']"

    def save_cluster_profile
      save_cluster_profile_btn.click
    end

    def save_elastic_agent_profile
      save_elastic_agent_profile_btn.click
    end

    def click_confirm_delete
      confirm_delete.click
    end

    def add_elastic_agent_profile(cluster_profile_id)
      selected_header = find_collapsible_header(cluster_profile_id)

      if selected_header
        selected_header.find("button[data-test-id='new-elastic-agent-profile-button']").click
      end
    end

    def has_selected_cluster_profile_id(cluster_profile_id, plugin_name)
      page.all("div[data-test-id='form-field-input-cluster-profile-id']")
          .find {|select| select.value === `#{cluster_profile_id} (#{plugin_name})`} != nil
    end

    def has_elastic_agent(elastic_agent_profile_id)
      page.all("div[data-test-id='elastic_profile_id']")
          .find {|div| div.text === elastic_agent_profile_id} != nil
    end

    def edit_cluster_profile(cluster_profile_id)
      selected_header = find_collapsible_header(cluster_profile_id)

      if selected_header
        selected_header.find("button[data-test-id='edit-cluster-profile']").click
      end
    end

    def delete_cluster_profile(cluster_profile_id)
      selected_header = find_collapsible_header(cluster_profile_id)

      if selected_header
        selected_header.find("button[data-test-id='delete-cluster-profile']").click
      end
    end

    def clone_cluster_profile(cluster_profile_id)
      selected_header = find_collapsible_header(cluster_profile_id)

      if selected_header
        selected_header.find("button[data-test-id='clone-cluster-profile']").click
      end
    end

    def edit_elastic_agent_profile(elastic_agent_profile_id)
      selected_header = find_elastic_agent_profile_collapsible_header(elastic_agent_profile_id)

      if selected_header
        selected_header.find("button[data-test-id='edit-elastic-profile']").click
      end
    end

    def expand_cluster_profile_header(cluster_profile_id)
      find_collapsible_header(cluster_profile_id).click
    end

    def cluster_profiles_exists?(cluster_profile)
      page.find("[data-test-id='cluster-profile-list']").text.include?(cluster_profile)
    end

    def elastic_agent_profile_exists?(elastic_agent_profile)
      !page.all("[data-test-id='elastic-profile-id']")
           .select{ |elastic_agent_profile_name| elastic_agent_profile_name.text.eql? elastic_agent_profile}.empty?
    end

    def verify_display_message
      page.find("div[data-test-id='flash-message-alert']").text
    end

    def find_collapsible_header(cluster_profile_id)
      page.all("div[data-test-id='cluster-profile-panel'] div[data-test-id='collapse-header']")
          .find {|div| div.find("div[data-test-id='cluster-profile-name']").text === cluster_profile_id}
    end

    def find_elastic_agent_profile_collapsible_header(elastic_agent_profile_id)
      page.all("div[data-test-id='elastic-profile-header'] div[data-test-id='collapse-header']")
          .find {|div| div.find("div[data-test-id='elastic-profile-id']").text === elastic_agent_profile_id}
    end

  end
end