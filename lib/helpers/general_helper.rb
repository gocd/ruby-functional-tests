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

module Helpers
  module GeneralHelper

    def interpolate_from_scenario_state(msg)
      msg.gsub(/\$(.*?)\$/) {|name| scenario_state.get(name.delete! '$') }
    end

    def running_server_full_version
      res = RestClient.get http_url('/api/version'),
                            { accept: GoConstants::VERSIONS_API_VERSION }.merge(basic_configuration.header)
      JSON.parse(res.body)['full_version']
    end


  end
end
