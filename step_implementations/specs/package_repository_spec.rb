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

step "Enter repository name as <repo_name>" do |repo_name|
  package_repository_page.package_repo_name.set repo_name
end

step "Select <plugin_name> plugin" do |plugin_name|
  package_repository_page.package_repo_plugin.select plugin_name
end


step "Enter repo url as <repo_url>" do |repo_url|
  package_repository_page.package_repo_url.set repo_url
end

step "Click save - Already on Package Repositories tab" do |_tmp|
  package_repository_page.package_repo_save.click
end


step "Verify repository listing contains <repo_name>" do |repo_name|
  assert_true package_repository_page.package_repo_listed? repo_name
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
