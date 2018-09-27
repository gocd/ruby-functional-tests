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
step 'Start VSM analytics selections' do
  vsm_page.click_analytics
end

step 'Select material as the source for VSM analytics' do
  vsm_page.select_source('material')
end

step 'View VSM analytics' do
  vsm_page.view_analytics.click
end

step 'Verify VSM trends are displayed' do
  vsm_page.vsm_analytics_visible?
end

step 'Select pipeline <pipeline> for VSM analytics' do |pipeline|
  vsm_page.select_pipeline_on_VSM(pipeline)
end

step 'Select material <material> for VSM analytics' do |material|
  vsm_page.select_material_on_VSM(material)
end

step 'Verify VSM trend has <workflows> workflows' do |workflows|
  
  vsm_page.verify_Workflow_count_VSM_chart(workflows)
end
