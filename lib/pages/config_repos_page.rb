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
    element :confirm_delete, "button[data-test-id='button-delete']"

    def verify_config_repo(repo, pipeline)
      assert_true(page.find('[data-test-id="config-repo-header"]', text: repo, exact_text: true).text.eql?(repo))
      page.find('[data-test-id="config-repo-header"]', text: repo, exact_text: true).click
      assert_true(page.find('[data-test-id="config-repo-header"]', text: repo, exact_text: true).ancestor('[data-test-id="config-repo-details-panel"]').find("[data-test-id^='pipeline_#{pipeline.underscore}']").text.include?(pipeline))

    end

    def has_config_repos(repos)
      actual   = find_all_config_repos.sort
      expected = repos.split(/[\s,]+/).map(&:strip).sort
      assert_true difference(expected, actual).empty?, "Assertion failed. Expected: #{expected}, Actual: #{actual}"
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

    def click_edit_config_repo(repo)
      panel_header = find_collapsible_header(repo)
      panel_header.find('[data-test-id="config-repo-edit"]').click
    end

    def click_on_add_config_repo
      page.find('[data-test-id="pageActions"] button').click
    end

    def click_save_config_repo
      page.find('[data-test-id="button-ok"]', text: "Save").click
    end

    def does_not_contain_repo(repo)
      actual = find_all_config_repos.sort
      assert_not_includes(actual, repo)
    end

    def click_delete_config_repo(repo)
      panel_header = find_collapsible_header(repo)
      panel_header.find('[data-test-id="config-repo-delete"]').click
    end

    def click_confirm_delete
      confirm_delete.click
    end

    def enter_config_repo_name(name)
      page.find('[data-test-id="form-field-input-config-repository-name"]').set name
    end

    def enter_config_repo_url(url)
      page.find('[data-test-id="form-field-input-url"]').set url
    end

    def repo_failed_parsing(repo, entity, entity_name)
      panel = find_collapsible_panel(repo)
      assert_not_nil panel.find("div[data-test-id='collapse-header']")[:class].include?'index__error__'
      assert_not_nil panel.find("div[data-test-id='flash-message-alert']")

      error_span = panel.find("span[data-test-id='key-value-value-error']")
      assert_not_nil error_span

      err_msg = "Not allowed to refer to #{entity} '#{entity_name}'. Check the 'Rules' of this config repository."
      assert_true error_span.text.include?(err_msg), "Assertion failed. Expected to contain '#{err_msg}' but was '#{error_span.text}'"
    end

    def repo_successfully_parsed(repo)
      panel_header = find_collapsible_header(repo)
      assert_not_nil panel_header
      assert_not_nil panel_header.find("span[data-test-id='repo-success-state']")
    end

    def repo_has_env(repo, env)
      panel     = find_collapsible_panel(repo)
      data_node = panel.find("dt[data-test-id^='tree-node-#{env}']")
      assert_not_nil data_node

      text = data_node.find("a").text
      assert_true text.start_with?(env), "Assertion failed. Expected to start with '#{env}' but was '#{text}'"
    end

    private

    def difference(arr1, arr2)
      (arr1 + arr2) - (arr1 & arr2)
    end

    def find_collapsible_header(id)
      page.all("div[data-test-id='collapse-header']")
          .find {|widget| widget.find("h4[data-test-id='config-repo-header']").text === id}
    end

    def find_collapsible_panel(id)
      page.all("div[data-test-id='config-repo-details-panel']")
          .find {|widget| widget.find("h4[data-test-id='config-repo-header']").text === id}
    end

    def find_all_config_repos
      page.all('[data-test-id="config-repo-header"]')
          .collect(&:text)
    end
  end
end
