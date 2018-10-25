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
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/compare{/pipeline_name}{/from_pipeline}/with{/to_pipeline}"
    element :check_ins, '#tab-content-of-checkins'
    element :to_pipeline, '#to_pipeline'
    element :from_pipeline, '#from_pipeline'
    element :browse_to_timeline,'a#browse_timeline_link_to'
    element :browse_from_timeline,'a#browse_timeline_link_from'

     def click_on_To_box_for_browse_timeline
      to_pipeline.click
      browse_to_timeline.click
     end

     def click_on_From_box_for_browse_timeline
      from_pipeline.click
      browse_from_timeline.click
     end

     def selected_pipeline_label_is?(label)
      page.has_selector?('li.pim_list.clear_float.selected .pipeline_label', text: label)
     end

     def get_pipeline_labels
      @pipeline_labels=[]
      page.all('li.pim_list .pipeline_label').each {|element| 
        @pipeline_labels.push(element.text.to_i)}
      return @pipeline_labels
     end

     def click_page(label)  
       page.find('.wrapper a.MB_focusable', text: label).click
     end  

     def select_pipeline_with_label(label)
      page.find('li.pim_list .pipeline_label', text: label).click
      page.find('a', text:'SELECT THIS PIPELINE').click
     end 

    def verify_pipeline_dependency_revision(pipeline_name, revision)
      pipeline_dependency_material_modifications(pipeline_name)
        .find('.change').find('.revision').text.include? sanitize_message(revision)
    end

    def verify_pipeline_dependency_label(pipeline_name, label)
      pipeline_dependency_material_modifications(pipeline_name)
        .find('.change').find('.label').text.include? label
    end

    def verify_scm_material_revision(material_type, revision)
      pipeline_scm_material_modifications(material_type).all('.change').collect do |change|
        change.find('.revision').text
      end.include? revision
    end

    def verify_scm_material_comment(material_type, comment)
      pipeline_scm_material_modifications(material_type).all('.change').collect do |change|
        change.find('.comment').text
      end.include? comment
    end

    def click_label(label)
      page.find('.ac_results').find('h3', text: label).click
    end

    def label_exists?(label)
      page.find('.ac_results').has_selector?('h3', text: label)
    end

    def number_of_materials?(count)
      check_ins.all('.material_title').size.equal? count
    end

    def checkin_info_message?(message)
      check_ins.find('.message').text.include? message
    end

    def checkin_warn_message?(message)
      check_ins.find('.warning').text.include? message
    end

    def see_bisect_diff
      check_ins.find('a', text: 'CONTINUE').click
    end

    private

    def pipeline_dependency_material_modifications(pipeline_name)
      materials = check_ins.all('.material_title').select { |mt| mt if mt.text.start_with?("Pipeline - #{pipeline_name}") }
      materials.first.sibling('.list_table.dependency_material_modifications')
    end

    def pipeline_scm_material_modifications(material_type)
      materials = check_ins.all('.material_title').select { |mt| mt if mt.text.start_with?("#{material_type} - ") }
      materials.first.sibling('.list_table.material_modifications')
    end
  end
end
