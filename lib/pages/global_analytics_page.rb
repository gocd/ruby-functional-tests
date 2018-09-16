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

  class PipelineWaitTime < AppBase
  end

  class AgentUtilizationTime < AppBase
  end

  class GlobalAnalyticsPage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/analytics"

    element :global_charts, '.dashboard-charts global'
    element :dashboard_tabs, '.dashboard-tabs'
    element :pipelines_selector, '.chart-pipeline-selector'
    iframe :pipeline_wait_time_chart, PipelineWaitTime, 0
    iframe :agent_utilization_chart, AgentUtilizationTime, 1
    iframe :build_time_chart, PipelineBuildTime, 0

    def pipeline_with_highest_wait_time
      pipeline_wait_time_chart do |frame|
        frame.find('.highcharts-xaxis-labels').all('text').first.text
      end
    end

    def drilldown_to_job_with_highest_wait_time
      pipeline_wait_time_chart do |frame|
        frame.all('.highcharts-point').first.click
        frame.find('.highcharts-title').text
      end
    end

    def drilldown_to_job_build_time
      pipeline_wait_time_chart do |frame|
        frame.all('.highcharts-point').first.click
        frame.find('.highcharts-title').text
      end
    end

    def drilldown_to_job_waited_longest_for_agent
      agent_utilization_chart do |frame|
        frame.all('.highcharts-point').first.click
        frame.find('.highcharts-title').text
      end
    end

    def visit_pipelines_tab
      dashboard_tabs.find('li', :text => 'Pipeline').click
      wait_for_pipelines_selector
    end

    def pipeline_listed(pipeline)
      pipelines_selector.has_css?('option', :text => pipeline)
    end

    def pipeline_build_time_visible_on_selection(pipeline)
      pipelines_selector.find('option', :text => pipeline).select_option
      build_time_chart do |frame|
        frame.find('#chart-container').has_css?('.highcharts-series-group')
      end
    end


  end
end