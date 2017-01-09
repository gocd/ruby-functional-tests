##########################################################################
# Copyright 2016 ThoughtWorks, Inc.
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

step "Verify server health message is shown" do |pipeline|
  server_health_message.verify_message_notifier_showsup
end

step "Verify server health message <message> is shown" do |msg|
  server_health_message.verify_message_displayed(msg)
end

step "Wait for server health message" do
  server_health_message.wait_for_server_health_message
end
