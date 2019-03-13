
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
step 'On personal access token page' do ||
    personal_access_token_page.load
end

step 'Create access token with description as <description> and remember it as <token_id>' do |description, token_id|
    personal_access_token_page.generate_token description
    personal_access_token_page.remember_token_as token_id
end

step 'On revoked tokens tab' do ||
	personal_access_token_page.tab_revoked_tokens.click
end

step 'Token with description <desc> should be listed' do |desc|
	assert_true personal_access_token_page.has_token_listed?(desc), "Access Token with description #{desc} not listed on personal access token page"
end
