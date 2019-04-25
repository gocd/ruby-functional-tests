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
    element :stage_bar_run, '#current_stage_run'
    element :stage_triggered_user, '.who'
    element :automatically_triggered,'.schedule_info span.label'
    element :stage_cancelled_user, '.result .message'
    element :compare_pipeline_link, '#stage_run_details .compare_pipeline a'
    element :compare,"a[title='Compare with the previous build']"



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

    def status_with_job?(status,job)
      jobs_passed.text.include?status  and is_job_in_passed_list?(job)
    end

    def is_job_in_passed_list?(job)
      passed_job_list.each { |jobs|
        return true if jobs.text.include?job
       }
    end

    def  stage_trigger_is_enabled?(stage)
      page.has_selector?("#stage_bar_trigger_#{stage}")
    end

    def stage_has_no_actions?(stage)
      page.has_selector?("a#stage_bar_trigger_#{stage}") and page.has_selector?("a#stage_bar_rerun_#{stage}") and page.has_selector?("a#stage_bar_cancel_#{stage}")
    end

    def stage_has_action?(stage,action)
      page.has_selector?("a#stage_bar_#{action.downcase}_#{stage}")
    end

    def trigger_stage(stage)
      page.find("a#stage_bar_trigger_#{stage}").click
    end

    def click_other_runs(run)
      page.find('#show_other_stage_runs').click
      page.find('span', text:run).ancestor('a').click
    end

    def stage_has_other_runs?
        page.has_css?('#other_stage_runs ul')
    end

    def job_status_in_collapsed_state
      all_status=[]
      page.all(".job_grouping .hidereveal_expander").each {|state|
        job_status=state.text
      all_status.push(job_status)
      }
      all_status
    end

    def open_jobs(job,status)
      page.find("#jobs_#{status.gsub(" ","_")}").find('ul.hidereveal_content').has_css?('span', text:job)
    end

    def history_runs
      all_history_runs=[]
      if(page.all('.label_counter_wrapper span').count>1)
        page.all('.label_counter_wrapper span').each {|job|
        all_history_runs.push(job.text)}
      return format_all_history_runs(all_history_runs)
      else
      all_history_runs.push(page.all('.label_counter_wrapper span').text)
      return all_history_runs
      end
    end

    def format_all_history_runs(all_history_runs)
      final_history_runs=[]
      for i in 0..all_history_runs.length-1 do
        if all_history_runs[i].start_with?('(')
          final_history_runs[i-1]= final_history_runs[i-1]+' '+all_history_runs[i]
        else
          final_history_runs[i]=all_history_runs[i]
        end
      end
      final_history_runs.compact
    end

    def selected_history_entry
      all_history_runs=[]
      if(page.find('a.selected.alert').all('span').count>1)
         page.find('a.selected.alert').all('span').each {|job|
           all_history_runs.push(job.text)
          }
        return format_all_history_runs(all_history_runs)
      else
          all_history_runs.push(page.find('a.selected.alert').find('span').text)
         return  all_history_runs
        end
    end

    def click_stage_history_of_page_number(number)
      page.find("#stage_history_#{number}").click
    end

    def verify_total_history_runs runs
      runs.split(',').each{|run|
        assert_true page.has_css?('.pipeline_label',text:run)}
    end

    def has_history_page_number?(page_number)
      page.has_css?("a#stage_history_#{page_number}")
    end

   def config_changed_marker_exists?pipeline_counter,stage_counter
    page.has_css?(".config_change.counter_#{pipeline_counter}_#{stage_counter} span a")
   end

   def click_config_changed_link pipeline_counter,stage_counter
    page.find(".config_change.counter_#{pipeline_counter}_#{stage_counter}").click
   end

   def config_changed_added_contains?line
    page.all(".add td pre").each{|lines|
        return true if lines.text.include?line
      }
   end

   def config_changed_removed_contains?line
    page.all(".remove td pre").each{|lines|
      return true if lines.text.include?line
      }
   end

   def history_shows_status? status
    page.find('#stage_history').has_css?(".#{status}")
   end

   def stage_bar_has_date?
    page.has_css?(".schedule_info span.time")
   end

   def stage_bar_has_time?
    page.has_css?(".duration span.time")
   end

   def wait_for_stage_bar_to_show_run
     wait_till_event_occurs_or_bomb 60, "Stage bar does not shows run" do
       break if page.has_css?('#show_other_stage_runs')
     end
   end

   def select_counter_from_history counter
      page.find('span.pipeline_label.wrapped_word',text:counter).hover
      page.find('#stage_history').all('.compare_pipeline a')[counter.to_i - 1].click
   end

   def click_revision_link(rev)
    page.find('a', text: rev).click
   end


   def material_rev_concatinated_label?counter,modification_number
    page.has_css?('a.selected.alert span.pipeline_label', text: "#{counter}-#{getRevisionForModification modification_number}")
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
