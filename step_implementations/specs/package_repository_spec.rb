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

step "Open Package repositories page" do |_tmp|
  package_repository_page.load
end

step "Click on add package repository" do
  package_repository_page.add_package_repo_button.click
end

step "Enter repository name as <repo_name>" do |repo_name|
  package_repository_page.name_field.set repo_name
end

step "Select <plugin_name> plugin" do |plugin_name|
  package_repository_page.package_repo_plugin.select plugin_name
end

step "Enter repo url as <repo_url>" do |repo_url|
  package_repository_page.package_repo_url.set repo_url
end

step "Click save - Already on Package Repositories tab" do |_tmp|
  package_repository_page.save_button.click
end

step "Verify repository listing contains <repo_name>" do |repo_name|
  assert_true package_repository_page.package_repo_listed? repo_name
end

step "Verify repository listing does not contains <repo_name>" do |repo_name|
  assert_false package_repository_page.package_repo_listed? repo_name
end

step "Click on <repo_name> in repository listing" do |repo_name|
  package_repository_page.edit_package_repo repo_name
end

step "Enter username as <username>" do |username|
  package_repository_page.package_repo_username username
end

step "Enter password as <password>" do |password|
  package_repository_page.package_repo_password username
end

step "Select repository <repo_name>" do |repo_name|
  package_material_page.package_repo_name.select repo_name
end

step "Select option <option> - On Package Material Creation Popup" do |option|
  package_material_page.add_new_package.click
end

step "Enter package name <name> and spec <spec>" do |name, spec|
  package_material_page.package_material_name.set name
  package_material_page.package_material_spec.set spec
end

step "Save package material" do |_tmp|
  package_material_page.package_material_save.click
end

step "Open Configuration for <pkg_repo>" do |pkg_repo|
  package_repository_page.open_pkg_repo_configuration(pkg_repo)
end

step "Open package panel for <pkg_name>" do |pkg_name|
  package_repository_page.find_package_panel(pkg_name).click
end

step "Verify that following configurations exist for <pkg_repo> <table>" do |pkg_repo, table|
  table.rows.each_with_index do |row, index|
    p "Verify configurations for row #{index + 1}"
    assert_true package_repository_page.pkg_repo_config(pkg_repo, row['id']).text === row['value']
  end
end

step "Verify that following package configurations exist for <pkg_name> <table>" do |pkg_name, table|
  table.rows.each_with_index do |row, index|
    p "Verify configurations for row #{index + 1}"
    assert_true package_repository_page.pkg_config(pkg_name, row['id']).text === row['value']
  end
end

step "Click on add package for <pkg_repo>" do |pkg_repo|
  package_repository_page.button_add_package(pkg_repo).click
end

step "Set package name as <name> and spec as <spec>" do |name, spec|
  package_repository_page.name_field.set name
  package_repository_page.package_spec.set spec
end

step "Set package name as <name>" do |name|
  package_repository_page.name_field.set name
end

step "Set spec as <spec>" do |spec|
  package_repository_page.package_spec.set spec
end

step "Verify package <pkg_name> exists for repo <repo_name>" do |pkg_name, repo_name|
  package_repository_page.toggle_repo_panel(repo_name)
  assert_true package_repository_page.find_package_panel(pkg_name) != nil
end

step "Verify package <pkg_name> does not exists" do |pkg_name|
  assert_false package_repository_page.find_package_panel(pkg_name) != nil
end

step "Verify message <msg> for package repo spa" do |msg|
  assert_true package_repository_page.msg.text === msg
end

step "Clone package repository <pkg_repo>" do |pkg_repo|
  package_repository_page.clone_pkg_repo(pkg_repo)
end

step "Edit package repository <pkg_repo>" do |pkg_repo|
  package_repository_page.edit_pkg_repo(pkg_repo)
end

step "Delete package repository <pkg_repo>" do |pkg_repo|
  package_repository_page.delete_pkg_repo(pkg_repo)
end

step "Confirm delete package repository" do
  package_repository_page.confirm_delete.click
end

step "On package repository page: press ok" do
  package_repository_page.press_ok.click
end

step "Clone package <pkg_name>" do |pkg_name|
  package_repository_page.clone_pkg(pkg_name)
end

step "Edit package <pkg_repo>" do |pkg_name|
  package_repository_page.edit_pkg(pkg_name)
end

step "Delete package <pkg_repo>" do |pkg_name|
  package_repository_page.delete_pkg(pkg_name)
end

step "Click usages for package <pkg_repo>" do |pkg_name|
  package_repository_page.show_usages_pkg(pkg_name)
end

step "Verify message <msg> for usages" do |msg|
  assert_true package_repository_page.modal_body.text === msg
end

step 'Verify error message on package repo page <msg>' do |msg|
  assert_true package_repository_page.error.text === msg
end

step 'Verify connection to package repository is successful with message <msg>' do |msg|
  connection_ok_msg = package_repository_page.connection_ok_msg
  assert_true connection_ok_msg.include?(msg), "Expected '#{msg}' to be a part of '#{connection_ok_msg}'"
end
