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
  class JobDetails < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/tab/build/detail{/pipeline_name}/{/pipeline_counter}{/stage_name}{/stage_counter}{/job_name}"

    element :tabs, '.sub_tabs_container'
    element :console_output, '.buildoutput_pre'


    load_validation { has_add_new_task? }

    def on_tab(type)
      tabs.find('a', text: type).click
    end

    def console_content
      console_output['innerHTML']
    end
  end
end