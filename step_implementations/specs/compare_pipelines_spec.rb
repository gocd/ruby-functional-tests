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

step 'Verify displays revision <revision> having label <label> under pipeline named <pipeline>' do |revision, label, pipeline|
  compare_pipeline_page.verify_pipeline_dependency_revision(scenario_state.retrive(pipeline), revision)
  compare_pipeline_page.verify_pipeline_dependency_label(scenario_state.retrive(pipeline), label)
end

step 'Verify displays revision <material_id> having comment <comment> under <material_type>' do |material_id, comment, material_type|
  compare_pipeline_page.verify_scm_material_comment(material_type, comment)
  compare_pipeline_page.verify_scm_material_revision(material_type, scenario_state.material_revision(material_id))
end

step 'Search for <search_string> on to pipeline textbox' do |search_string|
  compare_pipeline_page.to_pipeline.set search_string
end

step 'Click on label <label> in the dropdown' do |label|
  compare_pipeline_page.click_label label
end
