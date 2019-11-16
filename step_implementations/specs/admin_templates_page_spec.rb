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


step 'Add new template' do
  admin_templates_page.click_add_new_template
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

step 'Verify template can be extracted only from pipelines <pipelines>' do |pipelines|
  actual_pipelines = admin_templates_page.extractable_pipelines
  pipelines.split(',').each do |pipeline|
    assert_true actual_pipelines.include? scenario_state.get(pipeline)
  end
end

step 'Select pipeline <pipeline> for template' do |pipeline|
  admin_templates_page.select_pipeline_for_template scenario_state.get(pipeline)
end


step 'Save Template create' do |_tmp|
  admin_templates_page.button_create.click
end

step 'Verify that templates <tmplates> are present - on Admin Templates tab' do |templates|
  template_names = admin_templates_page.all_templates
  templates.split(',').each do |template|
    assert_true template_names.include? template
  end
end

step 'Verify that templates <tmplates> are not present - on Admin Templates tab' do |templates|
  template_names = admin_templates_page.all_templates
  templates.split(',').each do |template|
    assert_false template_names.include? template
  end
end

step 'Verify that template <template> is used by pipelines <pipeline>' do |template, pipelines|
  pipelines_from_template = admin_templates_page.get_pipelines_from_template(template)
  pipeline_names = []
  pipelines.split(',').each do |pipeline|
    if scenario_state.get(pipeline).nil? ? pipeline_names.push(pipeline) : pipeline_names.push(scenario_state.get(pipeline))
    end
  end
  pipeline_names.each do |pipeline|
    assert_true pipelines_from_template.include? pipeline
  end
end

step 'Verify that template <template> has message <message>' do |template, message|
  assert_true admin_templates_page.template_has_message?(template, message)
end

step 'Verify cannot delete templates <templates>' do |templates|
  templates.split(',').each do |template|
    assert_true admin_templates_page.delete_link_is_disabled_for_template? template
  end
end

step 'Verify can delete templates <templates>' do |templates|
  templates.split(',').each do |template|
    assert_false admin_templates_page.delete_link_is_disabled_for_template? template
  end
end

step 'Delete template <template>' do |template|
  admin_templates_page.delete_template template
end
