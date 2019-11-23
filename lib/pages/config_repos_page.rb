##########################################################################
# Copyright 2019 ThoughtWorks, Inc.
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
  class ConfigReposPage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/config_repos"

    element :panel_config_repo, "[data-test-id='config-repo-details-panel']"
    element :header_config_repo, "[data-test-id='config-repo-header']"

    def verify_config_repo(repo, pipeline)
      assert_true(page.find('[data-test-id="config-repo-header"]', text: repo, exact_text: true).text.eql?(repo))

      page.find('[data-test-id="config-repo-header"]', text: repo, exact_text: true).click

      assert_true(page.find('[data-test-id="config-repo-header"]', text: repo, exact_text: true).ancestor('[data-test-id="config-repo-details-panel"]').find("[data-test-id^='pipeline_#{pipeline.underscore}']").text.include?(pipeline))

    end

    def has_config_repos(repos)
      actual   = find_all_config_repos.sort
      expected = repos.split(/[\s,]+/).map(&:strip).sort
      assert_true (expected - actual).empty?, "Assertion failed. Expected: #{expected}, Actual: #{actual}"
    end

    def has_enabled_action_buttons(repo)
      panel_header = find_collapsible_header(repo)

      assert_false(panel_header.find('[data-test-id="config-repo-refresh"').disabled?)
      assert_false(panel_header.find('[data-test-id="config-repo-edit"').disabled?)
      assert_false(panel_header.find('[data-test-id="config-repo-delete"').disabled?)
    end

    def has_disabled_action_buttons(repo)
      panel_header = find_collapsible_header(repo)

      assert_true(panel_header.find('[data-test-id="config-repo-refresh"').disabled?)
      assert_true(panel_header.find('[data-test-id="config-repo-edit"').disabled?)
      assert_true(panel_header.find('[data-test-id="config-repo-delete"').disabled?)
    end

    private

    def find_collapsible_header(id)
      page.all("div[data-test-id='collapse-header']")
          .find {|widget| widget.find("h4[data-test-id='config-repo-header']").text === id}
    end

    def find_all_config_repos
      page.all('[data-test-id="config-repo-header"]')
          .collect(&:text)
    end

  end
end
