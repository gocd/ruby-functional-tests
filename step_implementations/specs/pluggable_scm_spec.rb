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

step "Open Pluggable SCM page" do |_tmp|
  pluggable_scm_page.load
end

step "Click on add scm" do
  pluggable_scm_page.add_scm_button.click
end

step "Enter scm name as <scm_name>" do |scm_name|
  pluggable_scm_page.scm_name.set scm_name
end

step "Select scm <scm_plugin> plugin" do |scm_plugin|
  pluggable_scm_page.scm_plugin.select scm_plugin
end

step "Enter scm url as <scm_url>" do |scm_url|
  pluggable_scm_page.scm_url.set scm_url
end

step "Save scm" do
  pluggable_scm_page.save_button.click
end

step "Verify message <msg> for scm spa" do |message|
  assert_true pluggable_scm_page.flash_message.text.include? message
end

step "Verify scm listing contains <scm_labels>" do |scm_labels|
  expected = scm_labels.split(/[\s,]+/).map(&:strip)
  actual   = pluggable_scm_page.scm_labels
  assert_true difference(expected, actual).empty?, "Assertion failed. Expected: #{expected}, Actual: #{actual}"
end

step "Open scm configuration for <scm_name>" do |scm_name|
  pluggable_scm_page.open_scm_config(scm_name)
end

step "Verify that following scm configurations exist for <scm_name> <table>" do |scm_name, table|
  table.rows.each_with_index do |row, index|
    expected = pluggable_scm_page.scm_config(scm_name, row['id']).text
    assert_true expected === row['value'], "Assertion failed. Expected: #{expected}, Actual: #{row['value']}"
  end
end

step "Clone scm <scm_name>" do |scm_name|
  pluggable_scm_page.clone_scm(scm_name)
end

step "Edit scm <scm_name>" do |scm_name|
  pluggable_scm_page.edit_scm(scm_name)
end

step "Delete scm <scm_name>" do |scm_name|
  pluggable_scm_page.delete_scm(scm_name)
end

step "Confirm delete scm" do
  pluggable_scm_page.confirm_delete.click
end

step 'Verify error message on pluggable scm page <msg>' do |msg|
  assert_true pluggable_scm_page.error_message.text === msg
end
