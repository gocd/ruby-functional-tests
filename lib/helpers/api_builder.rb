##########################################################################
# Copyright 2022 ThoughtWorks, Inc.
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
module APIBuilder

  class GoCDApi
    attr_reader :method
    attr_reader :path

    def initialize(method, path)
      @method = method
      @path = path
    end

    def eql? that
      self.method == that.method && !that.path.match(self.path).nil?
    end

    def hash
      1
    end
  end

  @all = []
  @tested = []
  @non_tested = []

  def self.build_tested(request)
    unless request.url.include? '/api/admin/config.xml'
      @tested <<  GoCDApi.new(request.method,request.url.split('/go').last)
    end
  end

  def self.all_apis
    response = RestClient.get http_url("/api/internal/apis"), { accept: 'application/vnd.go.cd+json' }
    json_response = JSON.parse(response.body)
    json_response.select { |api|
                            if api['version'] == "application/vnd.go.cd+json"
                              api['path_params'].each {|pp|
                                api['path'].sub!(pp, '[a-zA-Z0-9\-_]*') if api['path'].include? pp
                              }
                              api.delete('path_params')
                              api.delete('version')
                            end
                          }
  end

  def self.all_deprecated_apis
    response = RestClient.get http_url("/api/apis"), { accept: 'application/vnd.go.cd+json' }
    json_response = JSON.parse(response.body)
    json_response.select { |api| api['deprecation_info']['is_deprecated']}
  end

  def self.build_non_tested
    all_apis.each do |api|
      @all << GoCDApi.new(api['method'], api['path'])
    end
    (@all - @tested).each do |nt|
      @non_tested << {'method': nt.method, 'path': nt.path.gsub('[a-zA-Z0-9\-_]*', '<param>')}
    end
    JSON.pretty_generate(@non_tested)
  end

end
