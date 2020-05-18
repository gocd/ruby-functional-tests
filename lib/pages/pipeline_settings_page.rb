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
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/pipelines{/pipeline_name}/edit#!{pipeline_name}/general"

    element :message, '#success'
    element :save, "button[value='SAVE']"
    element :material_url_field, "input[name='material[url]']"
    element :material_dest_directory, "input[name='material[folder]']"
    element :check_connection, "button[data-test-id='test-connection-button']"
    element :cron_timer, 'input[data-test-id="cron-timer"]'
    element :label_template, 'input[data-test-id="label-template"]'
    element :material_name, "input[data-test-id='form-field-input-material-name']"
    element :pipeline_name, "input[data-test-id='form-field-input-upstream-pipeline']"
    element :stage_name, "select[data-test-id='form-field-input-upstream-stage']"
    element :pipeline_locking, '#pipeline_lockBehavior_lockonfailure'
    element :project_path, "input[name='material[projectPath]']"

    # mingle project management
    element :mingle_URL, '#pipeline_mingleConfig_baseUrl'
    element :mingle_identifier, '#pipeline_mingleConfig_projectIdentifier'
    element :mingle_mqa, '#pipeline_mingleConfig_mqlCriteria_mql'

    element :add_new_stage, 'button[data-test-id="add-stage-button"]'
    element :select_package_repo, 'select[data-test-id="form-field-input-package-repository"]'
    element :select_package, 'select[data-test-id="form-field-input-package"]'

    def partial_message_displayed?(message)
      page.find('.success').text.include?(message)
    end

    def get_pipeline_stages
      stages = []
      page.all('div[data-test-id="stages-container"] table td:nth-child(2)').each do |stage|
        stages.push(stage.text)
      end
      stages
    end

    def select_material(material_name)
      page.find('td a', text: material_name).click
    end

    def material_exist?(material_name)
      page.find('td a', text: material_name).click
    end

    def connection_ok?
      page.has_css?('div[class^="test_connection__test-connection-result___"] div[data-test-id="flash-message-success"]')
    end

    def set_material_url(url)
      p "url: #{url}"
      page.find('input[data-test-id="form-field-input-repository-url"]').set url
    end

    def select_add_new_material(type)
      page.find('button[data-test-id="add-material-button"]').click
      page.find('select[data-test-id="form-field-input-material-type"]').select type
    end

    def delete_material(material_name)
      get_delete_material_icon(material_name).click
      page.find("button[data-test-id='primary-action-button']").click
    end

    def set_material_blacklist(blacklist)
      page.all('dt')
          .find {|element| element.text === "Advanced Settings"}
          .click
      page.find("input[data-test-id='form-field-input-blacklist']").set blacklist
    end

    def only_on_changes_checkbox_disabled?
      page.find('input[data-test-id="run-only-on-new-material"]').disabled?
    end

    def set_only_on_changes_checkbox
      page.find('input[data-test-id="run-only-on-new-material"]', wait: 10).set(true)
    end

    def url_exist_for_material?(material, url)
      page.find('td a', text: material).ancestor('tr').has_css?('td', text: url)
    end

    def can_material_be_deleted?(material)
      get_delete_material_icon(material)['disabled'] === nil
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

    def select_tracking_tool(tool)
      page.find("input[title='#{tool.capitalize}']").click
    end

    def select_stage(stage)
      page.all('div[data-test-id="stages-container"] a')
          .find {|element| element.text === stage}
          .click
    end

    def has_template? template
      page.find('a[data-test-id="template-name"]', text: template)
    end

    def open_template(template)
      page.find('a[data-test-id="template-name"]', text: template)
          .click
    end

    def set_auto_scheduling(value = true)
      auto_schedule_element = page.find("input[data-test-id='automatic-pipeline-scheduling']")
      auto_schedule_element.set(value) if auto_schedule_element.checked?
    end

    def auto_scheduling_selected?
      page.find("input[data-test-id='automatic-pipeline-scheduling']").checked?
    end

    def auto_scheduling_enabled?
      page.find("input[data-test-id='automatic-pipeline-scheduling']").disabled?
    end

    def set_material_name(mat_name)
      page.all('dt')
          .find {|element| element.text === "Advanced Settings"}
          .click
      material_name.set mat_name
    end

    def save_material
      page.find('button[data-test-id="button-save"]').click
    end

    def error_message_for_cron
      error_message_for_field(cron_timer)
    end

    def landed_on_pipeline_edit_page?(pipeline)
      page.has_css?('label[data-test-id="step-pipeline-name"]', text: pipeline)
    end

    private

    def get_delete_material_icon(material)
      page.all('a[data-test-id="edit-material-button"]')
          .find {|element| element.text === material}
          .ancestor('td') # td element
          .ancestor('tr') # tr element
          .find('td:nth-child(4)')
          .find('i[data-test-id="delete-material-button"]')
    end

  end
end
