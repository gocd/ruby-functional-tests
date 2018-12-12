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

module Context
  class BasicConfiguration
    attr_accessor :config_dom

    def setup(config_file)
      get_dom(config_file)
      replace_pipeline_names
      load_dom(config_dom)
    end

    def detect_headers_from_loaded_config
      begin
        response = RestClient.get admin_config_url
        return {Confirm: true} unless response.code != 200
      rescue
      end

      basic_auth = Base64.encode64(['admin', 'badger'].join(':'))
      {Authorization: "Basic #{basic_auth}", Confirm: true}
    end

    def load_dom(xml)
      RestClient.post admin_config_url, {xmlFile: xml.to_s, md5: @md5}, detect_headers_from_loaded_config
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

    def set_material_path_for_pipeline(material_type, pipeline, material_path)
      current_config = get_config_from_server
      current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.get(pipeline)}']/materials/#{material_type}").each do |material|
        material['url'] = material_path
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
          fetch['pipeline'] = pipeline['name'] if fetch['pipeline'] == initial_name
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
      settings['configuration'].collect!{|hash|
        hash['value'] = GoConstants::ANALYTICS_LICENSE_KEY if hash['key'] == 'license'
        hash
      }
      RestClient.post http_url('/api/admin/plugin_settings'), settings.to_json,
                      {content_type: :json, accept: 'application/vnd.go.cd.v1+json'}.merge(basic_configuration.header)
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
      pipeline_groups=[]
      self.config_dom = get_config_from_server

      except_pipelines_names = except_pipelines.map do |except_pipeline|
        scenario_state.get(except_pipeline)
      end

      except_pipelines_names.each do |pl|
        group_name=config_dom.xpath("//cruise/pipelines/pipeline[@name='#{pl}']").first.parent['group']
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
      return {Confirm: true} unless scenario_state.get 'current_user'
      basic_auth = Base64.encode64([scenario_state.get('current_user'), 'badger'].join(':'))
      {Authorization: "Basic #{basic_auth}", Confirm: true}
    end

    def remove_all_users
      RestClient.post delete_all_users_url, header
    end

    def enable_toggle(toggle)
      RestClient.post http_url("/api/admin/feature_toggles/#{toggle}"),
                      '{"toggle_value": "on"}',
                      {content_type: :json}.merge(basic_configuration.header)
    end

    def disable_toggle(toggle)
      RestClient.post http_url("/api/admin/feature_toggles/#{toggle}"),
                      '{"toggle_value": "off"}',
                      {content_type: :json}.merge(basic_configuration.header)
    end

    def material_url_for(pipeline)
      get_config_from_server.xpath("//cruise/pipelines/pipeline[@name='#{pipeline}']/materials/git").attribute('url').value
    end

    def add_user_as_admin(user)
      current_config = get_config_from_server
      admin_user_tag="<user>#{user}</user>"
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
      password_file_path = File.expand_path("#{GoConstants::CONFIG_PATH}/#{pwd_file}")
      admin_users = adminUsers.split(',')
      admin_user_tag = ''
      admin_users.each {|admin| admin_user_tag += "<user>#{admin}</user>"}

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
      password_file_path = File.expand_path("#{GoConstants::CONFIG_PATH}/#{pwd_file}")
     

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
      current_config.xpath("//cruise/server").each do |server|
       server['artifactsdir'] = artifact_location
      end
      load_dom(current_config)
    end  

    def add_new_timer_spec_to_file(spec)
      current_config = get_config_from_server
      timer_tag = "<timer>#{spec}</timer>"
       if !current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.self_pipeline}']/timer").empty?
        current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.self_pipeline}']/timer").remove
        current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.self_pipeline}']").children.first.add_previous_sibling timer_tag
       else 
        current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.self_pipeline}']").children.first.add_previous_sibling timer_tag
       end
      file = File.open("#{GoConstants::SERVER_DIR}/config/cruise-config.xml", "w")
         begin
          file.write(current_config.to_xml) 
          rescue IOError => e
          ensure file.close unless file.nil?   
          end
     end

    def set_timer_spec(spec)
      current_config = get_config_from_server
      timer_tag = "<timer>#{spec}</timer>"
      current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.self_pipeline}']").children.first.add_previous_sibling timer_tag
      load_dom(current_config)
    end

    def change_cruise_config_file_to(file)
      config_file = File.open("#{GoConstants::SERVER_DIR}/config/cruise-config.xml", "w")
        begin
         config_file.write(File.read("#{GoConstants::CONFIG_PATH}/#{file}")) 
         rescue IOError => e
         ensure config_file.close unless config_file.nil?
         end
     end

     def allow_known_user_to_login(value)
      current_config = get_config_from_server
      current_config.xpath("//cruise/server/security").each do |security|
        security['allowOnlyKnownUsersToLogin'] = value
      end
      load_dom(current_config)
     end
  end
end
