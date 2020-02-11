##########################################################################
# Copyright 2020 ThoughtWorks, Inc.
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

step 'Verify permissions API shows <entity> <permission> list has only <list>' do |entity, permission, list|
	expected_list = list.split(',').map(&:strip).sort
	actual_list = JSON.parse(get_permissions(entity))['permissions'][entity][permission]
	assert_equal  expected_list, actual_list.sort
end

def get_permissions(entity)
	begin
		RestClient.get http_url("/api/auth/permissions?type=#{entity}"),
							   { accept: 'application/vnd.go.cd+json' }.merge(basic_configuration.header)
	rescue RestClient::ExceptionWithResponse => e
		raise "Permissions API response failed with error #{e.message}"
	end
end
