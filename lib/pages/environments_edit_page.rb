##########################################################################
# Copyright 2016 ThoughtWorks, Inc.
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
  class EnvironmentsEditPage < AppBase
    element :pipeline_edit_button, "#edit_pipelines"
    element :agents_edit_button, "#edit_agents"
    element :save_button, "#MB_content > div > form > div.form_buttons.actions > button.primary.finish.submit.MB_focusable"
    element :agents_list, "div[class='added_item added_agents']"
    element :pipelines_list, "#body_content > div.content_wrapper_outer > div > div > div > div > div.added_item.added_pipelines > ul"
    element :env_vars_list, "div[class='added_item added_environment_variables']"
    element :save_message, "#message_pane > p"
    element :all_agents, "#select_all_agents"
    elements :list_of_agents, "td.selector"
    elements :agent_row, "td.hostname"
    element :vars_edit_button, "#edit_environment_variables"
    elements :vars_edit_row, "tr[class='environment-variable-edit-row']"
    elements :add_item, "a[class='add_item']"

    def initialize(environment)
      SitePrism::Page.set_url "#{GoConstants::GO_SERVER_BASE_URL}/environments/#{environment}/show"
    end

    def is_pipeline_exists?(pipeline)
      pipelines_list.text.include? pipeline
    end

    def is_agent_exists?(agent)
      agents_list.text.include? agent
    end

    def is_env_vars_exists?(var)
      env_vars_list.text.include? var
    end

    def select_all_agents
      all_agents.click
    end

    def click_pipeline_edit
      pipeline_edit_button.click
    end

    def click_agents_edit
      agents_edit_button.click
    end

    def click_vars_edit
      vars_edit_button.click
    end

    def add_pipeline(pipeline)
      SitePrism::Page.element :pipeline_checkbox, "#pipeline_#{pipeline}"
      pipeline_checkbox.set(true)
    end

    def add_agent(agent)
      page.find(:xpath, "//td[@title='missing-agent']").find(:xpath, "..").find("td[class='selector']").find("input[type='checkbox']").set(true)
    end

    def remove_pipeline(pipeline)
      SitePrism::Page.element :pipeline_checkbox, "#pipeline_#{pipeline}"
      pipeline_checkbox.set(false)
    end

    def save
      save_button.click
    end

    def can_edit_pipeline?(pipeline)
      SitePrism::Page.element :pipeline_checkbox, "#pipeline_#{pipeline}"
      !pipeline_checkbox.disabled?
    end

    def get_message
      save_message.text
    end

    def all_agents_checked
      binding.pry
      list_of_agents.all? {|agent| agent.find("input[type='checkbox']").checked?}
    end

    def set_vars_at(row, var, value)
      page.find(:xpath, "(//input[@class='form_input environment_variable_name MB_focusable'])[#{row.to_i}]").set(var)
      page.find(:xpath, "(//input[@class='form_input environment_variable_value MB_focusable'])[#{row.to_i}]").set(value)
    end

    def add_new_var
      add_item[0].click
    end

  end
end
