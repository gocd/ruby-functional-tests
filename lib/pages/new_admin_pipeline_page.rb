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
  class NewAdminPipelinePage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/pipeline_new"

    element :create_new_pipeline_group, "[data-test-id='create-new-pipeline-group']"
    element :all_pipeline_groups, "[data-test-id='pipeline-groups']"

    load_validation { has_create_new_pipeline_group? }



  end
end
