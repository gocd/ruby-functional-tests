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
  class JobSettings < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/pipelines{/pipeline_name}/stages{/stage_name}/job{/job_name}/tasks"

    element :add_new_task, '#add_new_task_dropdown_link'
    element :new_task_list, '#new_task_popup'
    element :external_artifact, "input[title='External']"
    element :task_pipeline, '#task_pipelineName'
    element :task_stage, '#task_stage'
    element :task_job, '#task_job'
    element :task_artifactId, '#task_artifactId'
    element :task_save, "button[value='SAVE']"
    element :publish_artifact_type, '#select_artifact_type'
    element :add_artifact, '#add_artifact'
    element :artifact_source, '.artifact_source'
    element :store_id, "input[name='job[artifactConfigs][][storeId]']"
    element :task_configuration_path, "input[name='task[configuration][Path]']"


    load_validation { has_add_new_task? }

    def add_new_task_of_type(type)
      add_new_task.click
      add_new_task.click
      new_task_list.find('a', text: type).click
    end

    def on_tab(tab_name)
      page.find('a', text: tab_name).click
    end
  end
end
