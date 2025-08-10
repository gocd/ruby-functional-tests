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

module Pages
  class PipelineHistoryPage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/pipeline/activity{/pipelinename}"

    element :pipeline_activity_page, '#pipeline_activity-page'
    element :current_page, 'a[data-test-current-page]'
    element :page_next, 'a[data-test-id="pagination-next-page"]'
    element :page_previous, 'a[data-test-id="pagination-previous-page"]'
    element :filter_history, 'input[data-test-id="search-field"]'
    element :build_cause_summary, 'div[data-test-id=build-details]'

    def verify_current_pagination_number(page_number)
      assert_true page.find("a[data-test-id='pagination-page-#{page_number}']")['class'].include? 'current-page'
    end

    def click_for_next_page
      page_next(wait: 10).click
    end

    def click_for_previous_page
      page_previous.click
    end

    def verify_stage_history_has(pipeline_histories)
      history_counters = pipeline_histories.split(/\s*,\s*/)
      all_vsm_hrefs = page.all('a', text: 'VSM').map { |a| a[:href] }
      history_counters.each do |history_counter|
        assert_true all_vsm_hrefs.any? { |href| href.end_with?("/pipelines/value_stream_map/#{scenario_state.self_pipeline}/#{history_counter}") }
      end
    end

    def search_given_pipeline(search_string)
      filter_history.set(search_string, rapid: false)
      sleep 20
    end

    def click_on_pagenumber(page_number)
      by_test_id("a", "pagination-page-#{page_number}").click
    end

    def clear_label_filter_selection
      reload_page
    end

    def open_build_cause(_pipeline_name, label)
      by_test_id("tr", "pipeline-instance-#{label}")
        .find(test_id("a", "trigger-with-changes-button")).click
    end

    def shows_build_cause_message?(message)
      build_cause_summary.text.include? message
    end

    def triggered_by?(_pipeline_name, label, user)
      by_test_id("tr", "pipeline-instance-#{label}")
        .find(test_id("a", "trigger-with-changes-button")).text == "Triggered by #{user}"
    end

    def pause_pipeline
      by_test_id("button", "page-header-pause-btn").click
      by_test_id("button", "primary-action-button").click
    end

    def verify_stage_can_rerun?(label, stage_name)
      by_test_id("tr", "pipeline-instance-#{label}")
        .find(test_id("td", "stage-status"))
        .find(test_id("div", "stage-status-container-#{stage_name}"))
        .has_selector?(test_id("i", "rerun-stage-icon"), visible: false)
      # visibility is set to false for on-hover functionality of the button
    end

    def verify_stage_can_cancel?(label, stage_name)
      by_test_id("tr", "pipeline-instance-#{label}")
        .find(test_id("td", "stage-status"))
        .find(test_id("div", "stage-status-container-#{stage_name}"))
        .has_selector?(test_id("i", "cancel-stage-icon"), visible: false)
      # visibility is set to false for on-hover functionality of the button
    end

    def verify_stage_can_be_approved?(stage_name, label)
      by_test_id("tr", "pipeline-instance-#{label}")
        .find(test_id("td", "stage-status"))
        .find(test_id("div", "stage-status-container-#{stage_name}"))
        .has_selector?(test_id("i", "gate-icon"))
    end

    def approve_stage(stage_name, label)
      by_test_id("tr", "pipeline-instance-#{label}")
        .find(test_id("td", "stage-status"))
        .find(test_id("div", "stage-status-container-#{stage_name}"))
        .find(test_id("i", "gate-icon")).click

      by_test_id("button", "primary-action-button").click
    end

    def verify_stage_cannot_rerun?(label, stage_name)
      by_test_id("tr", "pipeline-instance-#{label}")
        .find(test_id("td", "stage-status"))
        .find(test_id("div", "stage-status-container-#{stage_name}"))
        .has_no_selector?(test_id("i", "rerun-stage-icon"), visible: false)
      # visibility is set to false for on-hover functionality of the button
    end

    def verify_cannot_approve_stage?(stage_name, label)
      by_test_id("tr", "pipeline-instance-#{label}")
        .find(test_id("td", "stage-status"))
        .find(test_id("div", "stage-status-container-#{stage_name}"))
        .has_no_selector?(test_id("i", "gate-icon"))
    end

    def stage_rerun(current_label, stage_name)
      by_test_id("tr", "pipeline-instance-#{current_label}")
        .find(test_id("td", "stage-status"))
        .find(test_id("div", "stage-status-container-#{stage_name}"))
        .find(test_id("i", "rerun-stage-icon"), visible: false)
    end

    def triggered_by_on_history_page?(user)
      page.find('table')
        .find(test_id("td", "meta"))
        .find(test_id("a", "trigger-with-changes-button"), text: "Triggered by #{user}") != nil
    end

    def open_stage_overview(stage)
      by_test_id("span", "stage-status-#{stage}").click
    end

    def by_test_id(tag, test_id)
      page.find(test_id(tag, test_id))
    end

    def test_id(tag, test_id)
      "#{tag}[data-test-id=\"#{slugify(test_id)}\"]"
    end

    def slugify(value)
      value.downcase.strip.gsub(/[ _]+/, '-').gsub(/[^\w-]/, '')
    end
  end
end
