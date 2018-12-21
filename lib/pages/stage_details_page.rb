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
  class StageDetailsPage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/pipelines{/pipeline_name}{/label}{/stage_name}{/counter}{/tab_name}"

    element :build_cause_box, '.build_cause'
    elements :materials, '.material'
    elements :material_names, '.material_name'
    element :locked_instance, '.locked_instance'
    element :page_status_bar, '.page_status_bar'
    element :jobs_passed, '.jobs_passed>span'
    elements :passed_job_list, 'li.job a span.wrapped_word'

    def verify_latest_revision_for_modification(modification_number)
      latest_revision = Context::GitMaterials.new(basic_configuration.material_url_for(scenario_state.self_pipeline)).latest_revision
      latest_revision == getRevisionForModification(modification_number)
    end

    def verify_revision_for_modification(modification_number, expected_revision)
      getRevisionForModification(modification_number) == expected_revision
    end

    def verify_material_has_changed(material_type, material_name)
      material_section = material_header_for(material_type, material_name).first(:xpath, './/..')
      material_section[:class].include?('changed')
    end

    def verify_comment_in_modification(modification_number, comment)
      modification = modification_section_for(modification_number)
      modification.find('.comment').text.include?(comment)
    end

    def verify_modification_triggered_by(modification_number, user_name)
      modification = modification_section_for(modification_number)
      modified_by_text = modification.find('.modified_by').text
      commit_author = modified_by_text.split('on')[0]
      commit_author.include?(user_name)
    end

    def locked_status?(status)
      wait_till_event_occurs_or_bomb 20, "Pipeline is not in Locked state #{status}" do
        reload_page
        break if locked_instance.text.include?(status)
      end
      locked_instance.text.include?(status)
    end

    def unlock_pipeline
      wait_for_locked_instance(5)
      locked_instance.click
    end

    def rerun_stage(stage)
      page.find("#stage_bar_rerun_#{stage}").click
    end

    def cancel_stage(stage)
      page.find("#stage_bar_cancel_#{stage}").click
    end

    def verify_stage_rerun_is_enabled?(stage_name)
      page.has_selector?("#stage_bar_rerun_#{stage_name}")
    end

    def verify_jobs_can_rerun?
      page.has_selector?('span', text: "RERUN SELECTED")
    end

    def check_pipeline_status(status) 
      page_status_bar.find('.run_results').find('.result').text.include?(status)
    end

    def verify_status_with_job(status,job)
      jobs_passed.text.include?status  and is_job_in_passed_list?(job)         
    end      
  
    def is_job_in_passed_list?(job)
      passed_job_list.each { |jobs| 
        return true if jobs.text.include?job
       }  
    end

    def  verify_stage_trigger_is_enabled?(stage)
      page.has_selector?("#stage_bar_trigger_#{stage}")
    end  

    def verify_stage_has_no_actions(stage)
      page.has_selector?("a#stage_bar_trigger_#{stage}") and page.has_selector?("a#stage_bar_rerun_#{stage}") and page.has_selector?("a#stage_bar_cancel_#{stage}")
    end  

    def verify_stage_has_action?(stage,action)
      page.has_selector?("a#stage_bar_#{action}_#{stage}")
    end 

    def verify_stage_does_not_has_action?(stage,action)
      page.has_selector?("a#stage_bar_#{action}_#{stage}")
    end 

    def trigger_stage(stage)
      page.find("a#stage_bar_trigger_#{stage}").click
    end


    private

    def getRevisionForModification(modification_number)
      modification = modification_section_for(modification_number)
      modification.find('.revision dl dd').text
    end

    def modification_section_for(modification_number)
      material_header = material_header_for(scenario_state.get('current_material_type'), scenario_state.get('current_material_name'))
      material_header.first(:xpath, './/..').all('.change')[modification_number.to_i]
    end

    def material_header_for(material_type, material_name)
      material_names.select { |name| name.text.include? "#{material_type} - #{material_name}" }.first
    end

  end
end
