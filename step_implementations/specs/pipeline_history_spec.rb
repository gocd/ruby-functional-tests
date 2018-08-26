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
@auto_refresh = false
step 'Verify pipeline activity page is shown' do |_tmp|
  assert_true pipeline_history_page.has_pipeline_history_group?
end

step 'Verify pipeline history page <page_number> is shown' do |page_number|
  # pipeline_history_page.load(pipeline_name: scenario_state.self_pipeline)
  pipeline_history_page.verify_current_pagination_number page_number
end

step 'Navigate to next pipeline history page' do
  pipeline_history_page.click_for_next_page
end

step 'Navigate to previous pipeline history page' do
  pipeline_history_page.click_for_previous_page
end

step 'Verify pipeline history page has <pipeline_histories>' do |pipeline_histories|
  pipeline_history_page.verify_stage_history_has pipeline_histories
end

step 'Search for <seacrch_string> on pipeline history page' do |seacrch_string|
  pipeline_history_page.search_given_pipeline seacrch_string
end

step 'Click on page number <clickable_page_number>' do |clickable_page_number|
  pipeline_history_page.click_on_pagenumber clickable_page_number
end

step 'Clear label filter selection field' do
  pipeline_history_page.clear_label_filter_selection
end

step 'Approve stage <stage> with label <label>' do |stage, label|
  # Since there is javascript alert on history page during stage approval handling stage approval via API
  begin
    RestClient.post http_url("/run/#{scenario_state.self_pipeline}/#{label}/#{stage}"),{}, basic_configuration.header
  rescue RestClient::ExceptionWithResponse => err
    p "Stage #{stage} approval on history page failed with response code #{err.response.code} and the response body - #{err.response.body}"
  end
end
