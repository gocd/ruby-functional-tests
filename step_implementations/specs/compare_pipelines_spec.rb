##########################################################################
# Copyright 2022 ThoughtWorks, Inc.
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
  assert_true compare_pipeline_page.verify_pipeline_dependency_revision(scenario_state.get(pipeline), revision)
  assert_true compare_pipeline_page.verify_pipeline_dependency_label(scenario_state.get(pipeline), label)
end

step 'Verify displays revision <material_id> having comment <comment> under <material_type>' do |material_id, comment, material_type|
  assert_true compare_pipeline_page.verify_scm_material_comment(material_type, comment)
  assert_true compare_pipeline_page.verify_scm_material_revision(material_type, scenario_state.material_revision(material_id))
end

step 'Search for <search_string> on to pipeline textbox' do |search_string|
  compare_pipeline_page.to_pipeline.set(search_string, rapid: false)
end

step 'Search for <search_string> on from pipeline textbox' do |search_string|
  compare_pipeline_page.from_pipeline.set(search_string, rapid: false)
end

step 'Search for revision <revision> on from pipeline textbox' do |revision|
  compare_pipeline_page.from_pipeline.set(scenario_state.material_revision(revision), rapid: false)
end

step 'Search for revision <revision> on to pipeline textbox' do |revision|
  compare_pipeline_page.to_pipeline.set(scenario_state.material_revision(revision), rapid: false)
end

step 'Click on label <label> in the dropdown' do |label|
  compare_pipeline_page.click_label label
end

step 'Verify dropdown has labels <label_list>' do |label_list|
  label_list.split(',').each {|label|
    compare_pipeline_page.label_exists? label.strip
  }
end

step 'Verify that to pipeline textbox is populated with <label>' do |expected|
  actual = compare_pipeline_page.to_pipeline(wait: 10).value
  assert_true (actual == expected), "Actual value on to pipeline textbox #{actual}"
end

step 'Verify that from pipeline textbox is populated with <label>' do |label|
  actual = compare_pipeline_page.from_pipeline.value
  assert_true (actual == label), "Actual value on from pipeline textbox #{actual}"
end

step 'Verify there is message <msg>' do |msg|
  assert_true compare_pipeline_page.checkin_info_message?(msg)
end

step 'Verify that to pipeline textbox has error message <msg>' do |msg|
  assert_true compare_pipeline_page.to_instance_error_msg(msg)
end

step 'Verify that there are <count> materials' do |count|
  assert_true compare_pipeline_page.number_of_materials? count.to_i
end

step 'On Pipeline Compare page from <from_pipeline> build to <to_pipeline>' do |from_pipeline, to_pipeline|
  compare_pipeline_page.load(pipeline_name: scenario_state.self_pipeline, from_pipeline: from_pipeline, to_pipeline: to_pipeline)
end

step 'Click to browse the timeline on to suggestion box' do ||
  compare_pipeline_page.click_on_To_box_for_browse_timeline
end

step 'Click to browse the timeline on from suggestion box' do ||
  compare_pipeline_page.click_on_From_box_for_browse_timeline
end

step 'Verify selected pipeline label is <label>' do |label|
  assert_true compare_pipeline_page.selected_pipeline_label_is? label
end

step 'Verify that page has pipeline range <high> to <low>' do |high, low|
  pipeline_label_range = *(low.to_i..high.to_i)
  actual_labels        = []

  compare_pipeline_page.retry_until_true(max_tries: 2, delay: 3) do
    actual_labels = compare_pipeline_page.get_pipeline_labels
    (pipeline_label_range - actual_labels).empty?
  end

  assert_true (pipeline_label_range - actual_labels).empty?, "Expected: #{pipeline_label_range}, Actual: #{actual_labels}"
end

step 'Click next - On Pipeline Compare page' do |_tmp|
  compare_pipeline_page.click_next_page
end

step 'Click page <page> - On Pipeline Compare page' do |page|
  compare_pipeline_page.click_page page
end

step 'Choose and select pipeline with label <label>' do |label|
  compare_pipeline_page.select_pipeline_with_label label
end

step 'Click on upstream pipeline revision <rev>' do |rev|
  compare_pipeline_page.click_revision rev
end

step 'Verify that unauthorized access message is shown' do ||
  assert_true compare_pipeline_page.unauthorized_message_exist?
end
