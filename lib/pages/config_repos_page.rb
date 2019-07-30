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
    element :panel_config_repo1,"[data-test-id='collapse-header']"


      def verify_config_repo(repo, pipeline)
      puts "***********************repo*******************"
      puts (page.find_all("[data-test-id='config-repo-details-panel'] > div > div h4")[0].text)
      puts repo
      assert_true(page.find_all("[data-test-id='config-repo-details-panel'] > div > div h4")[0].text.include?(repo))
      sleep 5

      page.find("div.index__collapse___NdWzo:nth-child(1) > div:nth-child(1)").click

      puts "***********************Pipeline*******************"
      puts page.find(".defined_structs__pipeline-datum___uBHjV > a:nth-child(1)").text
      puts pipeline
      assert_true(page.find(".defined_structs__pipeline-datum___uBHjV > a:nth-child(1)").text.include?(pipeline))
      page.find(".defined_structs__pipeline-datum___uBHjV > a:nth-child(1)").click
      sleep 5



    end

  end
end
