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
require 'json'

SECRET_CONFIG_ACCEPT_HEADER = 'application/vnd.go.cd.v1+json'.freeze
SECRET_CONFIG_API_BASE = '/api/admin/secret_configs'.freeze

def get_all_secret_configs()
  RestClient.get http_url("#{SECRET_CONFIG_API_BASE}"),
                  { content_type: :json, accept: SECRET_CONFIG_ACCEPT_HEADER }.merge(basic_configuration.header)
end


def get_secret_config(id)
  RestClient.get http_url("#{SECRET_CONFIG_API_BASE}/#{id}"),
                  { content_type: :json, accept: SECRET_CONFIG_ACCEPT_HEADER }.merge(basic_configuration.header)
end

step 'Delete secret config <secret_config_id> should return <code>' do |secret_config_id, expected_code|
  begin
    res = RestClient.delete http_url("#{SECRET_CONFIG_API_BASE}/#{secret_config_id}"),
                    { content_type: :json, accept: SECRET_CONFIG_ACCEPT_HEADER }.merge(basic_configuration.header)
    assert_true res.code == expected_code.to_i
  rescue RestClient::ExceptionWithResponse => err
    assert_true err.response.code == expected_code.to_i
  end
end

step "Get all API should return all secret configs <list_of_config_ids>" do |list_of_config_ids|
  expected_config_ids = list_of_config_ids.split(',')
  res = get_all_secret_configs()
  secret_configs = JSON.parse(res)["_embedded"]["secret_configs"]

  assert_true secret_configs.size == expected_config_ids.size

  actual_config_ids = (secret_configs.map { |secret_config| secret_config["id"]})
  assert_true actual_config_ids.sort == expected_config_ids.sort
end

step "Get secret config <id> should return <response_code>" do |config_id, expected_code|
  begin
  res = get_secret_config(config_id)
  assert_true res.code == expected_code.to_i
  rescue RestClient::ExceptionWithResponse => err
    assert_true err.response.code == expected_code.to_i
  end
end

step 'Add secret config <config_id> should return code <code>', 'Adding duplicate secret config <config_id> should fail with error code <code>' do |secret_config_id, expected_code|
  req_body = %({
    "id": "#{secret_config_id}",
    "description": "This is used to lookup for secrets for the team Dev team.",
    "plugin_id": "cd.go.secrets.file-based-plugin",
    "properties": [
      {
        "key": "secrets_file_path",
        "value": "/home/secret/secret.dat"
      },
      {
        "key": "secret_password",
        "secure": true,
        "value": "secret"
      }
    ]
  }
  )
  begin
    res = RestClient.post http_url("#{SECRET_CONFIG_API_BASE}"), req_body,
                    { content_type: :json, accept: SECRET_CONFIG_ACCEPT_HEADER }.merge(basic_configuration.header)
    assert_true res.code == expected_code.to_i
  rescue RestClient::ExceptionWithResponse => err
    assert_true err.response.code == expected_code.to_i
  end

end

step 'Secret config <config_id> should contain rule to <directive> usage in pipeline group <pipeline_group>' do |config_id, directive, pipeline_group|
  res = get_secret_config(config_id)
  assert_true res.code == 200
  json = JSON.parse(res.body)
  rules = json['rules'].select { |rule| (rule['directive'].eql? "#{directive}") && (rule['resource'].eql? "#{pipeline_group}")}
  assert_true rules.size == 1
end

step 'Update secret config <config_id> to <directive> usage only in pipeline group <pipeline_group>' do |config_id, directive, pipeline_group|
  etag = get_secret_config(config_id).headers[:etag]

  req_body = %({
    "id": "#{config_id}",
    "description": "This is used to lookup for secrets for the team Dev team.",
    "plugin_id": "cd.go.secrets.file-based-plugin",
    "properties": [
      {
        "key": "secrets_file_path",
        "value": "/home/secret/secret.dat"
      },
      {
        "key": "secret_password",
        "secure": true,
        "value": "secret"
      }
    ],
    "rules": [
      {
        "directive": "#{directive}",
        "action": "refer",
        "type": "pipeline_group",
        "resource": "#{pipeline_group}"
      }
    ]
  }
  )

  res = RestClient.put http_url("#{SECRET_CONFIG_API_BASE}/#{config_id}"), req_body,
                  { content_type: :json, accept: SECRET_CONFIG_ACCEPT_HEADER, if_match: etag}.merge(basic_configuration.header)

  assert_true res.code == 200
end