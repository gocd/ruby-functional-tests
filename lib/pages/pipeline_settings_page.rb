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
  class PipelineSettingsPage < GeneralSettingsPage
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/pipelines{/pipeline_name}/general"

    element :message, '#success'
    element :add_variables, '#add_variables'
    element :save, "button[value='SAVE']"
    element :material_url_field, "input[name='material[url]']"
    element :material_dest_directory, "input[name='material[folder]']"
    element :check_connection, "button[value='CHECK CONNECTION']"
    element :cron_timer, 'input#pipeline_timer_timerSpec'
    element :label_template, 'input#pipeline_labelTemplate'
    element :material_name, "input[name='material[materialName]']"
    element :stage_name, "input[name='material[pipelineStageName]']"
    element :pipeline_locking, '#pipeline_lockBehavior_lockonfailure'
    element :project_path, "input[name='material[projectPath]']"

    # mingle project management
    element :mingle_URL, '#pipeline_mingleConfig_baseUrl'
    element :mingle_identifier, '#pipeline_mingleConfig_projectIdentifier'
    element :mingle_mqa, '#pipeline_mingleConfig_mqlCriteria_mql'

    def message_displayed?(message)
      page.has_css?('.success', text: message, exact_text: true)
    end

    def partial_message_displayed?(message)
      page.find('.success').text.include?(message)
    end

    def get_pipeline_stages
      stages = []
      page.all('a.stage_name_link').each do |stage|
        stages.push(stage.text)
      end
      stages
    end

    def add_parameter(name, value)
      params_row = page.find('.params.variables').find('.params').all('tr').last
      params_row.find("input[name='pipeline[params][][name]']").set name
      params_row.find("input[name='pipeline[params][][valueForDisplay]']").set new_pipeline_dashboard_page.sanitize_message(value)
      add_variables.click
    end

    def add_env(name, value)
      env_row = page.find('#variables').all('tr').last
      env_row.find("input[name='pipeline[variables][][name]']").set name
      env_row.find("input[name='pipeline[variables][][valueForDisplay]']").set value
      page.find('#variables').find('#add_variables').click
    end

    def select_material(material_name)
      page.find('td a', text: material_name).click
    end

    def material_exist?(material_name)
      page.find('td a', text: material_name).click
    end

    def connection_ok?
      page.has_css?('.ok_message')
    end

    def set_material_url(url)
      page.find('.url').set url
    end

    def select_add_new_material(type)
      page.find('.menu_link', text: 'Add Material').click
      page.find('#new_material_popup ul li a', text: type, exact_text: true).click
    end

    def delete_material(material_name)
      page.find('.material_name', text: material_name, exact_text: true).ancestor('tr').find('.icon_remove').click
      page.find("button[value='Proceed']").click
    end

    def set_material_blacklist(blacklist)
      page.find("textarea[name='material[filterAsString]']").set blacklist
    end

    def only_on_changes_checkbox_disabled?
      page.find('input#pipeline_timer_onlyOnChanges').disabled?
    end

    def set_only_on_changes_checkbox
      page.find('input#pipeline_timer_onlyOnChanges', wait: 10).set(true)
    end

    def url_exist_for_material?(material, url)
      page.find('td a', text: material).ancestor('tr').has_css?('td', text: url)
    end

    def can_material_be_deleted?(material)
      page.find("tbody tr:nth-child(#{page.find('.material_name', text: material, exact_text: true).ancestor('tr').path[-2].to_i})").has_css?('span.delete_parent')
    end

    def make_material_auto_update(flag)
      page.find('#material_autoUpdate').set(flag)
    end

    def invert_material
      page.find('#material_invertFilter').set(true)
    end

    def clean_work_dir
      page.find('#stage_cleanWorkingDir').set(true)
    end

    def can_move_stage?(stage, direction)
      page.find(".stage_#{stage}").has_css?(".promote_#{direction}")
    end

    def move_stage(stage, direction)
      page.find(".stage_#{stage}").find("button[title='Move #{direction.capitalize}']").click
    end

    def select_tracking_tool(tool)
      page.find("input[title='#{tool.capitalize}']").click
    end

    def select_stage(stage)
      page.find('.stage_name_link', text: stage).click
    end

  end
end
