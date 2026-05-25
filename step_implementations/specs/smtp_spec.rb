##########################################################################
# Copyright 2026 Thoughtworks, Inc.
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

step 'SMTP server - start' do
  smtp_server.start
end

step 'SMTP server - stop' do
  smtp_server.stop
end

step 'SMTP server - clear inbox' do
  smtp_server.clear
end

step 'Verify SMTP server received email from <sender> to <recipient> with subject containing <text>' do |sender, recipient, text|
  message = smtp_server.wait_for_message(timeout: 10)
  assert_not_nil message, "No email received within timeout. Inbox size: #{smtp_server.messages.size}"
  assert_true message.from.include?(sender), "Sender #{sender} not in From: #{message.from.inspect}"
  assert_true message.to.include?(recipient), "Recipient #{recipient} not in To: #{message.to.inspect}"
  assert_true message.subject.to_s.include?(text), "Subject did not contain #{text.inspect}. Subject was: #{message.subject.inspect}"
end

step 'Verify SMTP server received email containing <text>' do |text|
  message = smtp_server.wait_for_message(timeout: 10)
  assert_not_nil message, 'No email received within timeout'
  body = message.body.decoded
  assert_true body.include?(text), "Body did not contain #{text.inspect}. Body was:\n#{body}"
end
