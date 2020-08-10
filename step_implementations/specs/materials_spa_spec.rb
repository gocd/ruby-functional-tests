##########################################################################
# Copyright 2020 ThoughtWorks, Inc.
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

step 'On Materials Page' do
  materials_page.load
end

step 'Verify there are <material_count> materials shown' do |material_count|
  assert_equal material_count.to_i, materials_page.materials_shown
end

step 'Verify usages for <material_name> has pipelines <pipelines>' do |material_name, pipelines|
  assert_equal materials_page.sanitize_message(pipelines).split(','), materials_page.find_all_pipeline_usages_for(material_name)
end

step 'Verify material attributes <table>' do |table|
  table.rows.each do |row|
    material_name = row['material_name']
    assert_equal row['attributes'].split(','), materials_page.get_attrs_for(material_name)
  end
end

step "Verify <material_name> has no modifications" do |material_name|
  assert_true materials_page.no_mod_details(material_name)
end

step "Verify <material_name> has latest modification as <mod_details>" do |material_name, mod_details|
  assert_equal mod_details, materials_page.latest_mod_details(material_name)
end

step 'Verify material modifications for <material_name> <table>' do |material_name, table|
  materials_page.open_modifications_modal(material_name)
  table.rows.each do |row|
    index = row['index']
    assert_equal row['comment'], materials_page.get_comment(index)
  end
end

step 'Trigger material update for <material_name>' do |material_name|
  materials_page.trigger_update(material_name)
end
