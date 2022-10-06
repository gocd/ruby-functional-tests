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
  class StageSettingsPage < GeneralSettingsPage
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/pipelines{/pipeline_name}/edit#!{pipeline_name}{/stage_name}/stage_settings"

    element :stage_name, 'input[data-test-id="stage-name-input"]'
    element :add_new_user_permission, 'button[data-test-id="add-user-permission-button"]'
    element :add_new_role_permission, 'button[data-test-id="add-role-permission-button"]'
    element :permission_user_name, 'input.permissions_user_name'
    element :permission_role_name, 'input.permissions_role_name'

    element :add_new, 'button[data-test-id="add-jobs-button"]'

    element :job_name_on_popup, 'input[data-test-id="form-field-input-job-name"]'
    element :task_on_stage_popup, 'select[data-test-id="form-field-input-task-type"]'

    element :command_on_stage_popup, "input[data-test-id='form-field-input-command']"
    element :command_args_on_stage_popup, "textarea[data-test-id='form-field-input-arguments']"

    element :save_job, "button[data-test-id='save-job']"

    def job_resources(job)
      page.find('td a', text: job).ancestor('tr').find('td:nth-child(2)').text
    end

    def run_on_all(job)
      page.find('td a', text: job).ancestor('tr').find('td:nth-child(3)').text
    end

    def open_job(job)
      page.find('td a', text: job).click
    end

    def delete_job(job)
      page.find("i[data-test-id='#{job.downcase}-delete-icon']").click
      page.find("button[data-test-id='primary-action-button']").click
    end

    def job_present?(job)
      page.has_css?('td a', text: job)
    end

    def option_is_selected?(option)
      if option.eql? 'Inherit from the pipeline group'
        page.find('input[data-test-id="radio-inherit"]').checked?
      else
        page.find('input[data-test-id="radio-local"]').checked?
      end
    end

    def has_message?(message)
      page.has_css?('div', text: message)
    end

    def select_permission_option(option)
      if option.eql? 'Inherit from the pipeline group'
        page.find('input[data-test-id="radio-inherit"]').click
      else
        page.find('input[data-test-id="radio-local"]').click
      end
    end

    def select_from_automlete(item)
      page.find('.ac_results li', text: item).click
    end

    def set_permission_user(user)
      page.find('div[data-test-id="users"]')
          .all('input[data-test-id="form-field-input-"]').each do |input_element|
        input_element.set(user, rapid: false) if input_element.value.blank?
      end
    end

    def set_permission_role(role)
      page.find('div[data-test-id="roles"]')
          .all('input[data-test-id="form-field-input-"]').each do |input_element|
        input_element.set(role, rapid: false) if input_element.value.blank?
      end
    end

    def inherited_users
      users = []
      page.find('div[data-test-id="users"]')
          .all('input[data-test-id="form-field-input-"]').each do |element|
        users.push(element.value) if element.disabled?
      end
      users
    end

    def inherited_roles
      roles = []
      page.find('div[data-test-id="roles"]')
          .all('input[data-test-id="form-field-input-"]').each do |element|
        roles.push(element.value) if element.disabled?
      end
      roles
    end

    def specified_users
      users = []
      page.find('div[data-test-id="users"]')
          .all('input[data-test-id="form-field-input-"]').each {|element| users.push(element.value)}
      users
    end

    def specified_roles
      roles = []
      page.find('div[data-test-id="roles"]')
          .all('input[data-test-id="form-field-input-"]').each {|element| roles.push(element.value)}
      roles
    end

    def auto_selected?
      page.find('input[data-test-id="approval-checkbox"]', visible: false).checked?
    end

    def set_approval_type(type)
      page.find("##{type}").click
    end

    def stage_has_approval_type?(stage, type)
      page.all('tbody tr')
          .find {|element| element.find('a').text === stage}
          .find("td:nth-child(3)").text === type
    end

    def stage_has_jobs?(stage, jobs)
      page.all('tbody tr')
          .find {|element| element.find('a').text === stage}
          .find("td:nth-child(4)").text === jobs
    end

    def add_new_task(task)
      page.find('select[data-test-id="form-field-input-"]').select task
    end

    def error_message_for_stage_name
      error_message_for_field(stage_name)
    end

    def set_trigger_type(value)
      page.find('input[data-test-id="approval-checkbox"]', visible: false)
          .sibling('label[data-test-id="switch-paddle"]').set(value)
    end
  end
end
