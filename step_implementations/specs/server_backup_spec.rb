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

step 'Perform server backup' do
  server_backup_page.perform_backup
end

step 'On server backup page' do
  server_backup_page.load
end

step 'Verify back up completed with message <msg>' do |msg|
  assert_true server_backup_page.backup_successful?(msg), "Expected #{msg}, But its not shown"
end

step 'Verify the location of the backup store is at <location>' do |location|
  actual_location = server_backup_page.backup_location
  assert_true actual_location.include?(location), "Expected location #{location}, actual #{actual_location}"
end

step 'Verify the last performed backup message contains <msg>' do |msg|
	assert_true server_backup_page.last_backup_message.include? msg
end

step 'Verify the <dir> directory exists' do |dir|
	assert_true Dir.exist? "#{GoConstants::SERVER_DIR}/artifacts/#{dir}"
end

step 'Verify the <dir> directory contains <file> file in the tree' do |dir, file|
	assert_true !Dir.glob("#{GoConstants::SERVER_DIR}/artifacts/#{dir}/**/#{file}").empty?
end

step 'Verify the <dir> directory contains file named <file> which has running go version' do |dir, file|
  assert_true !Dir.glob("#{GoConstants::SERVER_DIR}/artifacts/#{dir}/**/#{file}").empty?
  version_on_backupfile = File.read(Dir.glob("#{GoConstants::SERVER_DIR}/artifacts/#{dir}/**/#{file}").first)
  actual_version = server_backup_page.running_server_full_version
  assert_true version_on_backupfile.eql?(actual_version), "Expected #{version_on_backupfile}, Actual #{actual_version}"
end
