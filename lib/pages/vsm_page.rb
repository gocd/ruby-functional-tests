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

module Pages

  class VSMAnalyticsTrend < AppBase
  end

  class VSMPage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/pipelines/value_stream_map{/pipeline_name}{/pipeline_counter}"
    element :enable_analytics, '.enable-analytics'
    element :material, '.material'
    element :view_analytics, '.view-vsm-analytics'
    iframe :vsm_analytics_trend, VSMAnalyticsTrend, 0 

    def click_analytics
      enable_analytics.click
    end

    def select_source(source_type, source_name = 'git')
      material.click if source_type == 'material'
    end

    def vsm_analytics_visible?
      vsm_analytics_trend do |frame|
        frame.has_css?('.vsm-trends-container')
        frame.has_css?('.workflow-metrics')
        frame.has_css?('.vsm-trends')
      end
    end

  end
end