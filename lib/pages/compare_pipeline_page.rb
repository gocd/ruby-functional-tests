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
  class ComparePipelinePage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/compare{/pipeline_name}{/from_pipeline}}/with{/to_pipeline}}"
    element :check_ins, '#tab-content-of-checkins'
    element :to_pipeline, '#to_pipeline'
    element :from_pipeline, '#from_pipeline'

    def verify_pipeline_dependency_revision(pipeline_name, revision)
      pipeline_dependency_material_modifications(pipeline_name)
        .find('.revision').a.text.contains(sanitize_message(revision))
    end

    def verify_pipeline_dependency_label(pipeline_name, label)
      pipeline_dependency_material_modifications(pipeline_name)
        .find('.label').a.text.contains(label)
    end

    def verify_scm_material_revision(material_type, revision)
      pipeline_dependency_material_modifications(material_type)
        .find('.revision').a.text.contains(revision)
    end

    def verify_scm_material_comment(material_type, comment)
      pipeline_dependency_material_modifications(material_type)
        .find('.comment').p.text.contains(comment)
    end

    def click_label(label)
      page.find('.ac_results').find('h3', text: label).click
    end

    private

    def pipeline_dependency_material_modifications(pipeline_name)
      materials = check_ins.all('.material_title').each { |mt| return mt if mt.text.start_with?("Pipeline - #{pipeline_name}") }
      materials.first.find(:xpath, '..').find('.list_table.material_modifications')
    end

    def pipeline_scm_material_modifications(material_type)
      materials = check_ins.all('.material_title').each { |mt| return mt if mt.text.start_with?("#{material_type} - ") }
      materials.first.find(:xpath, '..').find('.list_table.material_modifications')
    end

  end
end
