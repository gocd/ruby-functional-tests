##########################################################################
# Copyright 2022 Thoughtworks, Inc.
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

module Context
  class BasicConfiguration
    attr_accessor :config_dom

    def setup(config_file)
      get_dom(config_file)
      replace_pipeline_names
      load_dom(config_dom)
      sleep 5 # wait for config reload :-(
    end

    def detect_headers_from_loaded_config
      begin
        response = RestClient.get admin_config_url
        return { Confirm: true } unless response.code != 200
      rescue StandardError
      end

      basic_auth = Base64.encode64(%w[admin badger].join(':'))
      { Authorization: "Basic #{basic_auth}", Confirm: true }
    end

    def load_dom(xml)
      RestClient.post admin_config_url, { xmlFile: xml.to_s, md5: @md5 }, detect_headers_from_loaded_config
    rescue RestClient::ExceptionWithResponse => err
      raise "Update config xml api call failed. Error message #{err.response.body}"
    end

    def get_dom(file)
      get_config_from_server
      self.config_dom = Nokogiri::XML(File.read("#{GoConstants::CONFIG_PATH}/#{file}"))
      config_dom.xpath('//server').first['serverId'] = @serverId
      config_dom.xpath('//server').first['tokenGenerationKey'] = @tokenGenerationKey
    end

    def get_config_from_server
      response = RestClient.get admin_config_url, detect_headers_from_loaded_config
      current_config = Nokogiri::XML(response.body)
      @md5 = response.headers[:x_cruise_config_md5]
      @serverId = current_config.xpath('//server').first['serverId']
      @tokenGenerationKey = current_config.xpath('//server').first['tokenGenerationKey']
      current_config
    end

    def has_material_of_type type, pipeline
      current_configuration = basic_configuration.get_config_from_server
      flag = true if current_configuration.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.get(pipeline)}']/materials/#{type}").count > 0
      flag
    end

    def set_material_path_for_pipeline(material_type, pipeline, material_path, material_url)
      current_config = get_config_from_server
      current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.get(pipeline)}']/materials/#{material_type}[@url='#{material_url}']").each do |material|
        material['url'] = material_path
      end
      load_dom(current_config)
    end

    def set_material_path_for_tfs_pipeline pipeline, tfs_url, tfs_username, tfs_password
      current_config = get_config_from_server
      current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.get(pipeline)}']/materials/tfs").each do |material|
        material['url'] = tfs_url
        material['username'] = tfs_username
        material['password'] = tfs_password
      end
      load_dom(current_config)
    end

    def replace_pipeline_names
      config_dom.xpath('//cruise/pipelines/pipeline').each do |pipeline|
        initial_name = pipeline['name']
        pipeline['name'] = "#{initial_name}#{SecureRandom.hex(4)}"
        config_dom.xpath('//materials/pipeline').each do |materials|
          materials['pipelineName'] = pipeline['name'] if materials['pipelineName'] == initial_name
        end
        config_dom.xpath('//fetchartifact').each do |fetch|
          if fetch.attributes.include? 'pipeline'
            if fetch['pipeline'].include?('/')
              fetch['pipeline'].split('/').each { |fetch_pipeline|
                if fetch_pipeline.eql?(initial_name)
                  fetch['pipeline'] = fetch['pipeline'].sub(initial_name, pipeline['name'])
                end
              }

            else
              fetch['pipeline'] = pipeline['name'] if fetch['pipeline'] == initial_name
            end
          end
        end
        config_dom.xpath('//environments/environment/pipelines/pipeline').each do |env|
          env['name'] = pipeline['name'] if env['name'] == initial_name
        end
        scenario_state.put initial_name, pipeline['name']
      end
    end

    def set_config_repo(config_repo_path, idx)
      current_config = get_config_from_server
      current_config.xpath("//cruise/config-repos/config-repo[#{idx}]/git").each do |config_repo|
        config_repo['url'] = config_repo_path
      end
      load_dom(current_config)
    end

    def create_plugin_settings(settings)
      RestClient.post http_url('/api/admin/plugin_settings'), settings.to_json,
                      { content_type: :json, accept: 'application/vnd.go.cd+json' }.merge(basic_configuration.header)
    end

    def reset_config
      self.config_dom = get_config_from_server
      config_dom.search('//pipelines', '//environments', '//agents', '//security', '//scms', '//security', '//templates', '//config-repos').each(&:remove)
      load_dom(config_dom)
    end

    def remove_environments_except(except_environments)
      self.config_dom = get_config_from_server

      except_environments_names = except_environments.map do |except_env|
        scenario_state.get(except_env)
      end

      config_dom.xpath('//cruise/environments/environment').each do |env|
        env.remove unless except_environments_names.include?(env['name'])
      end

      load_dom(config_dom)
    end

    def remove_pipelines_except(except_pipelines)
      pipeline_groups = []
      self.config_dom = get_config_from_server

      except_pipelines_names = except_pipelines.map do |except_pipeline|
        scenario_state.get(except_pipeline)
      end

      except_pipelines_names.each do |pl|
        group_name = config_dom.xpath("//cruise/pipelines/pipeline[@name='#{pl}']").first.parent['group']
        pipeline_groups.push(group_name)
      end

      config_dom.xpath('//cruise/pipelines/pipeline').each do |pipeline|
        pipeline.remove unless except_pipelines_names.include?(pipeline['name'])
      end
      config_dom.xpath('//environments/environment/pipelines/pipeline').each do |env|
        env.remove unless except_pipelines_names.include?(env['name'])
      end
      config_dom.xpath('//cruise/pipelines').each do |pgroup|
        pgroup.remove unless pipeline_groups.uniq.include?(pgroup['group'])
      end
      load_dom(config_dom)
    end

    def header
      return { Confirm: true } unless scenario_state.get 'current_user'
      basic_auth = Base64.encode64([scenario_state.get('current_user'), 'badger'].join(':'))
      { Authorization: "Basic #{basic_auth}", Confirm: true }
    end

    def remove_all_users
      RestClient.get http_url("/api/users"), { accept: 'application/vnd.go.cd+json' }.merge(header) do |response, _request, _result|
        if response.code == 200
          disabled_users = JSON.parse(response.body)['_embedded']['users'].collect { |user|
            user['login_name'] if user['enabled'].eql? true
          }.compact
          enabled_users = JSON.parse(response.body)['_embedded']['users'].collect { |user|
            user['login_name'] if user['enabled'].eql? false
          }.compact
          users_to_be_removed = enabled_users.concat(disabled_users).delete_if { |user| user.eql? 'admin' }
          RestClient.patch http_url("/api/users/operations/state"),
                           { "operations": { "enable": false }, "users": enabled_users }.to_json,
                           { content_type: :json, accept: 'application/vnd.go.cd+json' }.merge(header) unless enabled_users.empty?
          RestClient::Request.execute(method: 'delete',
                                      url: http_url("/api/users"), payload: { "users": users_to_be_removed }.to_json,
                                      headers: { content_type: :json, accept: 'application/vnd.go.cd+json' }.merge(header)) unless users_to_be_removed.empty?
        end
      end
    end

    def update_toggle(toggle, value)
      RestClient.put http_url("/api/admin/feature_toggles/#{toggle}"),
                     { "toggle_value": "#{value}" }.to_json,
                     { content_type: :json, accept: 'application/vnd.go.cd+json' }.merge(basic_configuration.header)
    end

    def material_url_for(pipeline)
      get_config_from_server.xpath("//cruise/pipelines/pipeline[@name='#{pipeline}']/materials/git").attribute('url').value
    end

    def material_url(pipeline, material_type, material_name)
      current_configuration = basic_configuration.get_config_from_server
      return current_configuration.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.get(pipeline)}']/materials/#{material_type}[@materialName='#{material_name}']")[0]['url']
    end

    def add_user_as_admin(user)
      current_config = get_config_from_server
      admin_user_tag = "<user>#{user}</user>"
      current_config.at("//cruise/server/security/roles/role[@name='admins']/users").add_child admin_user_tag
      load_dom(current_config)
    end

    def remove_user_as_admin(user)
      current_config = get_config_from_server
      current_config.xpath("//cruise/server/security/roles/role[@name='admins']/users/user[contains(text(),'#{user}')]").remove
      load_dom(current_config)
    end

    def enable_security_with_admin_rights(pwd_file, adminUsers)
      current_config = get_config_from_server
      password_file_path = GoConstants::RUN_ON_DOCKER ? "/test-config/#{pwd_file}" : File.expand_path("#{GoConstants::CONFIG_PATH}/#{pwd_file}")

      admin_users = adminUsers.split(',')
      admin_user_tag = ''
      admin_users.each { |admin| admin_user_tag += "<user>#{admin}</user>" }

      password_authentication_config = "<security>
          <authConfigs>
              <authConfig id=\"61f10215-9fba-4962-a2f4-d6c8944ade32\" pluginId=\"cd.go.authentication.passwordfile\">
                  <property>
                      <key>PasswordFilePath</key>
                      <value>#{password_file_path}</value>
                  </property>
              </authConfig>
          </authConfigs>
            <roles>
                <role name=\"admins\">
                    <users>
                        #{admin_user_tag}
                    </users>
                </role>
            </roles>
            <admins>
                <role>admins</role>
            </admins>
        </security>"
      current_config.xpath('//server').first.add_child password_authentication_config
      load_dom(current_config)
    end

    def enable_security_with_password_file(pwd_file)
      current_config = get_config_from_server
      password_file_path = GoConstants::RUN_ON_DOCKER ? "/test-config/#{pwd_file}" : File.expand_path("#{GoConstants::CONFIG_PATH}/#{pwd_file}")

      password_file_authentication_config = "<security>
          <authConfigs>
              <authConfig id=\"61f10215-9fba-4962-a2f4-d6c8944ade32\" pluginId=\"cd.go.authentication.passwordfile\">
                  <property>
                      <key>PasswordFilePath</key>
                      <value>#{password_file_path}</value>
                  </property>
              </authConfig>
          </authConfigs>
        </security>"
      current_config.xpath('//server').first.add_child password_file_authentication_config
      load_dom(current_config)
    end

    def set_artifact_location(artifact_location)
      current_config = get_config_from_server
      artifactsDir_tag = "<artifactsDir>#{artifact_location}</artifactsDir>"
      current_config.at('artifactsDir')['text'] = artifact_location
      if current_config.xpath("//cruise/server/artifacts/artifactsDir").empty?
        current_config.xpath("//cruise/server/artifacts").children.first.add_previous_sibling artifactsDir_tag
      else
        current_config.xpath("//cruise/server/artifacts/artifactsDir").remove
        current_config.xpath("//cruise/server/artifacts").children.first.add_previous_sibling artifactsDir_tag
      end
      load_dom(current_config)
    end

    def add_new_timer_spec_to_file(spec)
      current_config = get_config_from_server
      timer_tag = "<timer>#{spec}</timer>"
      if current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.self_pipeline}']/timer").empty?
        current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.self_pipeline}']").children.first.add_previous_sibling timer_tag
      else
        current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.self_pipeline}']/timer").remove
        current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.self_pipeline}']").children.first.add_previous_sibling timer_tag
      end
      file = File.open("#{GoConstants::SERVER_DIR}/config/cruise-config.xml", 'w')
      begin
        file.write(current_config.to_xml)
      rescue IOError => e
      ensure
        file.close unless file.nil?
      end
    end

    def set_timer_spec(spec)
      current_config = get_config_from_server
      timer_tag = "<timer>#{spec}</timer>"
      current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.self_pipeline}']").children.first.add_previous_sibling timer_tag
      load_dom(current_config)
    end

    def change_cruise_config_file_to(file)
      config_file = File.open("#{GoConstants::SERVER_DIR}/config/cruise-config.xml", 'w')
      begin
        config_file.write(File.read("#{GoConstants::CONFIG_PATH}/#{file}"))
      rescue IOError => e
      ensure
        config_file.close unless config_file.nil?
      end
    end

    def allow_known_user_to_login(value)
      current_config = get_config_from_server
      current_config.xpath('//cruise/server/security/authConfigs/authConfig').each do |authconfig|
        authconfig['allowOnlyKnownUsersToLogin'] = value
      end
      load_dom(current_config)
    end

    def remove_job_from_stage(job, stage, _pipeline)
      current_config = get_config_from_server
      current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.self_pipeline}']/stage[@name='#{stage}']/jobs/job[@name='#{job}']").remove
      load_dom(current_config)
    end

    def set_run_instance_count_for_job(count, job, pipeline)
      current_config = get_config_from_server
      if count == '0'
        current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.get(pipeline)}']/stage/jobs/job[@name='#{job}']").first.remove_attribute('runInstanceCount')
      else
        current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.get(pipeline)}']/stage/jobs/job[@name='#{job}']").each do |job|
          job['runInstanceCount'] = count
        end
      end
      load_dom(current_config)
    end

    def stage_is_authorised_with_user?(user, stage, pipeline)
      users = []
      current_config = get_config_from_server
      current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.self_pipeline}']/stage[@name='#{stage}']/approval/authorization/user").each do |user|
        users.push(user.text)
      end
      return users
    end

    def stage_is_authorised_with_role?(user, stage, pipeline)
      roles = []
      current_config = get_config_from_server
      current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.self_pipeline}']/stage[@name='#{stage}']/approval/authorization/role").each do |role|
        roles.push(role.text)
      end
      return roles
    end

    def auto_approve_first_stage()
      current_config = get_config_from_server
      current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.self_pipeline}']/materials/*").each { |material|
        material.remove_attribute("autoUpdate") if (material.has_attribute?("autoUpdate"))
      }
      approval_element = current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.self_pipeline}']/stage[1]/approval")
      current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.self_pipeline}']/stage[1]/approval").remove unless approval_element.empty?
      load_dom(current_config)
    end

    def rename_pipeline pipeline_name, new_name
      current_config = get_config_from_server
      current_config.xpath('//cruise/pipelines/pipeline').each { |pipeline|
        pipeline['name'] = new_name if pipeline['name'] == scenario_state.get(pipeline_name)
      }
      load_dom(current_config)
    end

    def enable_auto_updates pipeline
      current_config = get_config_from_server
      current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.self_pipeline}']/materials/*").each { |material|
        material.remove_attribute("autoUpdate") if (material.has_attribute?("autoUpdate"))
      }
      load_dom(current_config)
    end
  end
end
