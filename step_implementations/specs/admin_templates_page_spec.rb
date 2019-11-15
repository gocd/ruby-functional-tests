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

step 'On Admin Templates page' do |_tmp|
  admin_templates_page.load
end

step 'Verify that edit pipeline <pipeline> lands on pipeline edit page' do |pipeline|
  admin_templates_page.click_edit_pipeline scenario_state.get(pipeline)
  assert_true admin_templates_page.landed_on_pipeline_edit_page? scenario_state.get(pipeline)
end

step 'Enter template name <template> - On template page' do |template|
  admin_templates_page.enter_template_name template
end


step 'Select extract template from a existing pipeline' do
  admin_templates_page.extract_from_pipeline.click
end

step 'Verify extract template checkbox is disabled & not checked' do
  assert_true !admin_templates_page.extract_from_pipeline.checked?
  assert_true admin_templates_page.extract_from_pipeline.disabled?
end
