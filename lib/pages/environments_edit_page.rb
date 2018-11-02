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

    attr_reader :environment

    element :save_button, "button[value='Save']"
    element :agents_list, '.added_item.added_agents'
    element :pipelines_list, '.added_item.added_pipelines'
    element :env_vars_list, '.added_item.added_environment_variables'
    element :save_message, '#message_pane'
    element :all_agents, '#select_all_agents'
    elements :list_of_agents, 'td.selector'
    elements :agent_row, 'td.hostname'
    elements :vars_edit_row, '.environment-variable-edit-row'
    elements :add_item, '.add_item'

    def initialize(environment)
      SitePrism::Page.set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/environments/#{environment}/show"
      @environment = environment
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

    def edit_pipeline
      page.find("#edit_pipelines_for_#{@environment}").click
    end

    def edit_agents
      page.find("#edit_agents_for_#{@environment}").click
    end

    def edit_environment_variables
      page.find("#edit_environment_variables_for_#{@environment}").click
    end

    def add_pipeline(pipeline)
      SitePrism::Page.element :pipeline_checkbox, "#pipeline_#{pipeline}"
      pipeline_checkbox.set(true)
    end

    def add_agent(agent)
      page.find('.agent_hostname', text: agent).ancestor('.hostname').sibling('.selector').find("input[type='checkbox']").set(true)
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
      list_of_agents.all? { |agent| agent.find("input[type='checkbox']").checked? }
    end

    def set_vars_at(row, var, value)
      page.all('.environment_variable_name')[row.to_i].set(var)
      page.all('.environment_variable_value')[row.to_i].set(value)
    end

    def add_new_var
      add_item[0].click
    end
  end
end
