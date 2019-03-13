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
  class PersonalAccessToken < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/access_tokens"

    element :generate_token, "[data-test-id='generate-token-button']"
    element :description, "[data-test-id='form-field-input-description']"
    element :submit, "[data-test-id='button-save']"

    load_validation { has_generate_token? }

    def generate_token(description = '')
      generate_token.click
      description.set description
      submit.click
      binding.pry
    end


  end
end
