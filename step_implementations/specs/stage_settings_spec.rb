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

step 'On Stage settings page of pipeline <pipeline_name> stage <stage_name>' do |pipeline_name, stage_name|
    stage_settings_page.load(pipeline_name: scenario_state.actual_pipeline_name(pipeline_name), stage_name: stage_name)
  end
  
  step 'Open <tab_id> tab - On Stage settings page' do |tab_id|
    stage_settings_page.on_tab(tab_id)
  end

