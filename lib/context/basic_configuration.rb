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

module Context
  class BasicConfiguration

    attr_accessor :config_dom

    def load_dom(xml)
      RestClient.post admin_config_url, {xmlFile: xml.to_s, md5: @md5}, header
    rescue RestClient::ExceptionWithResponse => err
      raise "Update config xml api call failed. Error message #{err.response.body}"
    end

    def get_dom(file)
      get_current_config
      self.config_dom = Nokogiri::XML(File.read("#{GoConstants::CONFIG_PATH}/#{file}"))
      config_dom.xpath('//server').first['serverId'] = @serverId
    end

    def get_current_config
      response = RestClient.get admin_config_url, header
      current_config = Nokogiri::XML(response.body)
      @md5 = response.headers[:x_cruise_config_md5]
      @serverId = current_config.xpath('//server').first['serverId']
      current_config
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
        scenario_state.add_pipeline initial_name, pipeline['name']
      end
    end

    def set_material_path_for_pipeline(pipeline, material_path)
      current_config = get_current_config
      current_config.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.get_pipeline(pipeline)}']/materials/git").each do |material|
        material['url'] = material_path
      end
      load_dom(current_config)
    end

    def set_config_repo(config_repo_path, idx)
      current_config = get_current_config
      current_config.xpath("//cruise/config-repos/config-repo[#{idx}]/git").each do |config_repo|
        config_repo['url'] = config_repo_path
      end
      load_dom(current_config)
    end

    def reset_config
      self.config_dom = get_current_config
      config_dom.search('//pipelines', '//environments', '//agents', '//security', '//scms', '//security', '//templates', '//config-repos').each(&:remove)
      load_dom(config_dom)
    end

    def reset_config_environment
      self.config_dom = get_current_config
      config_dom.search('//environments').each(&:remove)
      load_dom(config_dom)
    end

    def reset_config_pipeline
      self.config_dom = get_current_config
      config_dom.search('//pipelines').each(&:remove)
      load_dom(config_dom)
    end

    def remove_environments_except(except_environments)
      self.config_dom = get_current_config

      except_environments_names = except_environments.map { |except_env|
        scenario_state.get_environment(except_env)
      }

      config_dom.xpath('//cruise/environments/environment').each do |env|
        env.remove unless except_environments_names.include?(env['name'])
      end

      load_dom(config_dom)
    end

    def remove_pipelines_except(except_pipelines)
      self.config_dom = get_current_config

      except_pipelines_names = except_pipelines.map { |except_pipeline|
        scenario_state.get_pipeline(except_pipeline)
      }

      config_dom.xpath('//cruise/pipelines/pipeline').each do |pipeline|
        pipeline.remove unless except_pipelines_names.include?(pipeline['name'])
      end
      config_dom.xpath('//environments/environment/pipelines/pipeline').each do |env|
        env.remove unless except_pipelines_names.include?(env['name'])
      end

      load_dom(config_dom)
    end

    def header
      return {Confirm: true} unless scenario_state.current_user
      basic_auth = Base64.encode64([scenario_state.current_user, 'badger'].join(':'))
      {Authorization: "Basic #{basic_auth}", Confirm: true}
    end

    def setup(config_file)
      get_dom(config_file)
      replace_pipeline_names
      load_dom(config_dom)
    end

  end
end
