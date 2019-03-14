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

step 'Start creating artifact store for plugin <plugin_name> with id <id>' do |plugin_name, id|
  artifacts_store_page.load
  artifacts_store_page.start_add_store
  artifacts_store_page.id.set id
  artifacts_store_page.plugin = plugin_name
end

step 'Save store details as <key_value>' do |key_value|
  key_value.split(',').each do |field|
    artifacts_store_page.fill_form(field)
  end
  artifacts_store_page.save_store
end

step 'Go to artifact stores page' do |i|
  artifacts_store_page.load
end

step 'Clone artifact store <artifact_store_id>' do |artifact_store_id|
  artifacts_store_page.clone_artifact_store(artifact_store_id)
end

step 'Set id as <artifact_store_id>' do |id|
  artifacts_store_page.id.set id
end

step 'Save artifact store' do |i|
  artifacts_store_page.save_store
end

step 'Verify flash message for artifact <message>' do |message|
  assert_true artifacts_store_page.flash_message.text.include? message
end

step 'Verify if artifact store <artifact_store_id> is present' do |artifact_store_id|
  wait_till_event_occurs_or_bomb 10, "Artifact store  #{artifact_store_id} creation failed" do
    break if artifacts_store_page.has_artifact_store(artifact_store_id)
  end
end

step 'Verify if artifact store <artifact_store_id> is not present' do |artifact_store_id|
  wait_till_event_occurs_or_bomb 10, "Artifact store  #{artifact_store_id} delete failed" do
    break if !artifacts_store_page.has_artifact_store(artifact_store_id)
  end
end

step 'Edit artifact store <artifact_store_id>' do |artifact_store_id|
  artifacts_store_page.edit_artifact_store(artifact_store_id)
end

step 'Expand plugin' do |i|
  artifacts_store_page.expand_plugin
end

step 'Delete artifact store spa <artifact_store_id>' do |artifact_store_id|
  artifacts_store_page.delete_artifact_store(artifact_store_id)
end

step 'Confirm delete artifact store' do |_i|
  artifacts_store_page.click_confirm_delete
end
