##########################################################################
# Copyright 2017 ThoughtWorks, Inc.
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

step 'On Plugins page' do |_count|
  plugins_spa_page.load
end

step 'Verify plugin with id <id> is marked as invalid with message <message>' do |id, message|
  assert_true plugins_spa_page.invalid_plugin_message_exists?(id, message)
end

step 'Verify multiple method loads for plugin id <id>  are <methods>' do |id, methods|
  methods.split(',').each { |method| assert_true plugins_spa_page.invalid_plugin_message_exists?(id, method.strip) }
end

step 'Verify plugin with id <id> is valid' do |id|
  assert_true plugins_spa_page.plugin_by_id_is_valid?(id)
end

step 'Verify plugin with id <id> has version <version> name <name> description <description> author <author> with enabled link to <link>' do |id, version, name, description, author, link|
  assert_true plugins_spa_page.is_expected_version?(id, version)
  assert_true plugins_spa_page.is_expected_name?(id, name)
  plugins_spa_page.expand_collapse_plugin_config(id)
  assert_true plugins_spa_page.is_expected_description?(id, description)
  assert_true plugins_spa_page.is_expected_author?(id, author)
  assert_true plugins_spa_page.is_expected_author_link?(id, author, link)
  plugins_spa_page.expand_collapse_plugin_config(id)
end

step 'Verify invalid plugin with id <id> has version <version> name <name> description <description> author <author> with enabled link to <link>' do |id, version, name, description, author, link|
  assert_true plugins_spa_page.is_expected_version?(id, version)
  assert_true plugins_spa_page.is_expected_name?(id, name)
  assert_true plugins_spa_page.is_expected_description?(id, description)
  assert_true plugins_spa_page.is_expected_author?(id, author)
  assert_true plugins_spa_page.is_expected_author_link?(id, author, link)
end

step 'Verify plugin with id <id> has path <path> supported OS <os> target go version <go_version> and bundled status as <bundled>' do |id, path, os, go_version, bundled|
  plugins_spa_page.expand_collapse_plugin_config(id)
  assert_true plugins_spa_page.is_expected_installed_path?(id, path)
  assert_true plugins_spa_page.is_expected_supported_os?(id, os)
  assert_true plugins_spa_page.is_expected_go_version?(id, go_version)
  assert_true plugins_spa_page.is_expected_bundled?(id, bundled)
  plugins_spa_page.expand_collapse_plugin_config(id)
end

step 'Verify invalid plugin with id <id> has path <path> supported OS <os> target go version <go_version> and bundled status as <bundled>' do |id, path, os, go_version, bundled|
  assert_true plugins_spa_page.is_expected_installed_path?(id, path)
  assert_true plugins_spa_page.is_expected_supported_os?(id, os)
  assert_true plugins_spa_page.is_expected_go_version?(id, go_version)
  assert_true plugins_spa_page.is_expected_bundled?(id, bundled)
end

step 'Verify plugin with id <plugin_id> has settings enabled' do |id|
  assert_true plugins_spa_page.is_plugins_settings_enabled?(id)
end

step 'Verify plugin with id <plugin_id> has settings disabled' do |id|
  assert_true plugins_spa_page.is_plugins_settings_disabled?(id)
end

step 'Verify plugin with id <plugin_id> do not show settings option' do |id|
  assert_false plugins_spa_page.is_plugins_settings_displayed?(id)
end