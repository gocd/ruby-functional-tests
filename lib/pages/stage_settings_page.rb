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
  class StageSettingsPage < GeneralSettingsPage
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/pipelines{/pipeline_name}/stages{/stage_name}/settings"

    element :stage_name, '#stage_name'
    element :permission_user_name, 'input.permissions_user_name'
    element :permission_role_name, 'input.permissions_role_name'

    element :add_new, 'a.add_link'

    element :job_name_on_popup, '#job_name'
    element :job_name_on_stage_popup, "input[name='stage[jobs][][name]']"

    element :command_on_popup, "input[name='job[tasks][exec][command]']"
    element :resources_on_popup, '#job_resources'
    element :job_name_popup, "input[name='stage[jobs][][name]']"
    element :command_on_stage_popup, "input[name='stage[jobs][][tasks][exec][command]']"
    element :command_args_on_stage_popup, "textarea[name='stage[jobs][][tasks][exec][argListString]']"

    element :trigger_type_auto, '#auto'
    element :trigger_type_manual, '#manual'

    element :stage_on_popup, "input[name='stage[name]']"

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
      page.find('td a', text: job).ancestor('tr').find('td.remove').find('form span.icon_remove').click
      page.find("button[value='Proceed']").click
    end

    def job_present?(job)
      page.has_css?('td a', text: job)
    end

    def option_is_selected?(option)
      if option.eql? 'Inherit from the pipeline group'
        page.find('input#inherit_permissions').checked?
      else
        page.find('input#define_permissions').checked?
      end
    end

    def has_message?(message)
      page.has_css?('div', text: message)
    end

    def selecct_permission_option(option)
      if option.eql? 'Inherit from the pipeline group'
        page.find('input#inherit_permissions').click
      else
        page.find('input#define_permissions').click
      end
    end

    def select_from_automlete(item)
      page.find('.ac_results li', text: item).click
    end

    def set_permission_user(user)
      page.all('input.permissions_user_name').each do |input_element|
        input_element.set user if input_element.value.blank?
      end
    end

    def set_permission_role(role)
      page.all('input.permissions_role_name').each do |input_element|
        input_element.set role if input_element.value.blank?
      end
    end

    def inherited_users
      users = []
      page.all("input[name='stage[operateUsers][][name]']").each do |element|
        users.push(element.value) if element.disabled?
      end
      users
    end

    def inherited_roles
      roles = []
      page.all("input[name='stage[operateRoles][][name]']").each do |element|
        roles.push(element.value) if element.disabled?
      end
      roles
    end

    def specified_users
      users = []
      page.all('.permissions_user_name').each do |element|
        users.push(element.value) unless element.value.blank?
      end
      users
    end

    def specified_roles
      users = []
      page.all('.permissions_role_name').each do |element|
        users.push(element.value) unless element.value.blank?
      end
      users
    end

    def auto_selected?
      page.find('#auto').checked?
    end

    def set_approval_type(type)
      page.find("##{type}").click
    end

    def stage_has_approval_type?(stage, type)
      page.find(".stage_#{stage}").has_css?('.approval_type', text: type)
    end

    def stage_has_jobs?(stage, jobs)
      page.find(".stage_#{stage}").has_css?('.number_of_jobs', text: jobs)
    end

    def add_new_task(task)
      page.find('#job_task_options').find(:option, task).select_option
    end

  end
end
