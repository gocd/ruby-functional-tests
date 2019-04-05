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
  class ElasticAgentsProfiles < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/elastic_profiles"

    element :input_profile_name, "[data-test-id='form-field-input-id']"
    element :plugin_id, "[data-test-id='form-field-input-plugin-id']"
    element :btn_save, "[data-test-id='button-ok']"
    element :image, "input[ng-model='Image']"
    element :profile_id, "[data-test-id='elastic-profile-id']"
    element :add_new_profile, "[data-test-id='pageActions']"

    load_validation { has_add_new_profile? }

    def profile_displayed?(name)
      !(profile_id text: name).nil?
    end

    def edit_profile(name)
      (profile_id text: name).ancestor("[data-test-id='collapse-header']")
                             .find("[data-test-id='edit-elastic-profile']").click
    end
  end
end
