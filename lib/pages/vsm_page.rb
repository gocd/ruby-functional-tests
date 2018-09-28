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

    def select_pipeline_on_VSM(pipeline)
      pipeline_name = scenario_state.actual_pipeline_name(pipeline)
      page.find(:xpath,"//div[@id='#{pipeline_name}']").click
    end

    def select_material_on_VSM(material)
      material_url= scenario_state.retrieve(material)
      page.find(:xpath,"//h3[contains(text(),'#{material_url}')]").click
    end

    def verify_workflow_count_vsm_chart(workflow_count)
      vsm_analytics_trend do |frame|
      count=frame.all('.vsm-trends-table tbody tr').length
      assert_equal workflow_count.to_i ,count , "Expected workflow Count should be #{workflow_count.to_i} , but actual is #{count}"
    end
  end
  
    def verify_throughput_value(throughput_val)
      vsm_analytics_trend do |frame|
      actual_throughput=frame.find('.throughput dd').text
      assert_equal throughput_val ,actual_throughput , "Expected throughput should be #{throughput_val} , but actual is #{actual_throughput}"
    end
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