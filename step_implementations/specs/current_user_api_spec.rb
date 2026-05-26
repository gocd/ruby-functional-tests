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

CURRENT_USER_VERSION = 'application/vnd.go.cd.v1+json'.freeze

step 'Set current user email to <email>' do |email|
  payload = { email: email, email_me: true }
  Helpers::HTTP.conn.patch http_url('/api/current_user'), payload.to_json,
                   { content_type: 'application/json', accept: CURRENT_USER_VERSION }.merge(basic_configuration.header)
end
