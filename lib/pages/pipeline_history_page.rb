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
  class PipelineHistoryPage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/tab/pipeline/history{/pipelinename}"

    element :pipeline_history_group, '.pipeline-history-group'
    element :current_page, '.page-num.highlight-warning'
    element :page_next, '#page-next'
    element :page_previous, '#page-previous'
    element :filter_history, '#labelFilterField'
    element :label_filter_clear, '.filter-clear-icon'
    element :build_cause_summary, '.build-cause-summary-container'

    def verify_current_pagination_number(page_number)
      assert_true current_page.text.include?(page_number)
    end

    def click_for_next_page
      page_next.click
    end

    def click_for_previous_page
      page_previous.click
    end

    def verify_stage_history_has(pipeline_histories)
      array = pipeline_histories.split(/\s*,\s*/)
      all_history_tags = page.all('a', text: 'VSM').map { |a| a[:href] }
      array.each do |history|
        assert_true all_history_tags.include?("#{GoConstants::GO_SERVER_BASE_URL}/pipelines/value_stream_map/#{scenario_state.self_pipeline}/#{history}")
      end
    end

    def search_given_pipeline(search_string)
      filter_history.set(search_string)
    end

    def click_on_pagenumber(page_number)
      find("#page_#{page_number}").click
    end

    def clear_label_filter_selection
      label_filter_clear.click
    end

    def open_build_cause(pipeline_name, label)
      page.find('.pipeline-label', text: label).find(:xpath, '../..').find('.pipeline-info', text: /Triggered by/).click

    end

    def shows_build_cause_message?(message)
      build_cause_summary.text.include? message
    end

    def triggered_by?(pipeline_name, label, user)
      page.find('.pipeline-label', text: label).find(:xpath, '../..').find('.pipeline-info', text: /Triggered by/).text.equal? "Triggered by #{user}"
    end

    def pause_pipeline
      page.find('span', text: "Pause").click
    end
  end
end
