##########################################################################
# Copyright 2016 ThoughtWorks, Inc.
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
  class DataSharingSPA < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/data_sharing/settings"

    element :data_sharing_toggle, '.consent-toggle'
    element :switch_paddle, '.switch-paddle'
    element :save_button, '.update-consent'
    element :reset_button, '.reset-consent'
    element :updated_by_info, '.updated-by'
    element :shared_data_info, '.shared-data'

    load_validation { has_data_sharing_toggle? }

    def data_sharing_allowed?
      page.find('.human-readable-consent').text.eql? 'Yes'
    end

    def toggle_data_sharing
      switch_paddle.click
    end

    def save
      save_button.click
    end

    def reset
      reset_button.click
    end

    def get_updated_by_message
      updated_by_info.text
    end

    def get_data_that_will_be_shared
      shared_data_info.text
    end
  end
end
