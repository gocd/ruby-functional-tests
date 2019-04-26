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
  class ElasticAgentProfilesCRUDOperations < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/elastic_profiles"

    element :elastic_agent_profile_id, "[data-test-id='form-field-input-id']"
    element :selected_cluster_profile_id, "[data-test-id='form-field-input-cluster-profile-id']"
    element :image, "input[ng-model='Image']"
    element :max_memory, "input[ng-model='MaxMemory']"
    element :save_elastic_agent_profile_btn, "button[data-test-id='button-ok']"

    element :confirm_delete, "button[data-test-id='button-delete']"

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

    def clone_elastic_agent_profile(elastic_agent_profile_id)
      selected_header = find_elastic_agent_profile_collapsible_header(elastic_agent_profile_id)

      if selected_header
        selected_header.find("button[data-test-id='clone-elastic-profile']").click
      end
    end

    def edit_elastic_agent_profile(elastic_agent_profile_id)
      selected_header = find_elastic_agent_profile_collapsible_header(elastic_agent_profile_id)

      if selected_header
        selected_header.find("button[data-test-id='edit-elastic-profile']").click
      end
    end

    def delete_elastic_agent_profile(elastic_agent_profile_id)
      selected_header = find_elastic_agent_profile_collapsible_header(elastic_agent_profile_id)

      if selected_header
        selected_header.find("button[data-test-id='delete-elastic-profile']").click
      end
    end

    def has_selected_cluster_profile_id(cluster_profile_id, plugin_name)
      page.all("div[data-test-id='form-field-input-cluster-profile-id']")
          .find {|select| select.value === `#{cluster_profile_id} (#{plugin_name})`} != nil
    end

    def elastic_agent_profile_exists?(elastic_agent_profile_id)
      page.all("div[data-test-id='elastic_profile_id']")
          .find {|div| div.text === elastic_agent_profile_id} != nil
    end

    def expand_cluster_profile_header(cluster_profile_id)
      find_collapsible_header(cluster_profile_id).click
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