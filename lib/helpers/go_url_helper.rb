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
  module GoUrlHelper

    def http_url(url)
      "#{GoConstants::GO_SERVER_BASE_URL}#{url}"
    end

    def admin_config_url
      http_url('/api/admin/config.xml')
    end

    def health_message_url
      http_url('/api/server_health_messages')
    end

    def agents_spa_url
      http_url('/admin/agents')
    end
  end
end
