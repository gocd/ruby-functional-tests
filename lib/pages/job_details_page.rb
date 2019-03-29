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
  class JobDetailsPage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/tab/build/detail{/pipeline_name}{/pipeline_counter}{/stage_name}{/stage_counter}{/job_name}"

    element :tabs, '.sub_tabs_container'
    element :console_output, '.buildoutput_pre'
    element :job_completed_time, 'span#build_completed_date'
    element :rerun_seleced, "button[value='RERUN']"
    element :breadcrumb_stage, '.stage_name a'
    element :property_tab, 'a#tab-link-of-properties'
    element :breadcrumb_pipeline, "a[title=\"View this pipeline's activity\"]"
    element :breadcrumb_pipeline_label, ".run_no"
    element :artifact_content, 'pre'



    load_validation { has_add_new_task? }

    def on_tab(type)
      tabs.find('a', text: type).click
    end

    def console_content
      wait_for_console_output
      console_output['innerHTML']
    end

    def console_has_message?(message)
      wait_till_event_occurs_or_bomb 20, "Console does not have message #{message}" do
        wait_for_console_output
        break if console_output['innerHTML'].include? message
      end
    end

    def select_jobs(job)
      page.find("input[type='checkbox'][value=#{job}]").click
    end

    def rerun_button_is_enabled?
      wait_till_event_occurs_or_bomb 60, "RERUN SELECTED button is disabled" do
        break if page.has_selector?("button[value='RERUN']")
      end
    end

    def rerun_button_is_disabled?
      page.has_selector?("button[value='RERUN']")
    end

    def job_has_status?(job,result)
      wait_till_event_occurs_or_bomb 60, "Job #{job} does not have result #{result}" do
        reload_page
        break if result== page.find("td.job_name a",text:job).ancestor('td.job_name').sibling('.job_result').text
          end
    end
    def job_has_state?(job,state)
        wait_till_event_occurs_or_bomb 60, "Job #{job} does not have state #{state}" do
        reload_page
        break if state==page.find("td.job_name a",text:job).ancestor('td.job_name').sibling('.job_state').text
          end
    end

    def job_has_current_value?(value)
      if (page.has_css?("#build_list_#{value}"))
        page.find("#build_list_#{value}")[:class].include?'current'
      else
        page.find(".entity_title.dropdown-arrow-icon").click
        page.find("#build_list_#{value}")[:class].include?'current'
      end
    end

    def job_is_not_copied_job?(value)
      if (page.has_css?("#build_list_#{value} a div"))
        page.find("#build_list_#{value} a div")[:class].include?'copied_job'
      else
        page.find(".entity_title.dropdown-arrow-icon").click
        page.find("#build_list_#{value} a div")[:class].include?'copied_job'
      end
    end

    def get_value_of_property(property)
      page.find('a', text:'Properties').click
      page.find("#build-peroperties-table tbody tr#property-of-#{property} td:nth-child(2)").text
    end

    def job_rerun_failed_message(message)
      page.find('.error').text
    end

    def breadcrumb_contains_link_to_pipeline?(pipeline)
      page.find('a.icon16.setting')[:href].include?pipeline
    end

    def vsm_link_exist?(pipeline,label,counter)
      page.has_link?('a',:href => "/go/pipelines/value_stream_map/#{scenario_state.get(pipeline)}/#{label}")
    end

    def file_exist_in_dir_in_artifacts_tab? file,dir
     if page.has_css?(".opened_directory a",text:dir)
      page.has_css?('.artifact a',text:file)
     else
      page.find(".directory a",text:dir).click
      page.has_css?('.artifact a',text:file)
     end
    end

    def file_exist_in_artifacts_tab? file
      page.has_css?('.artifact a',text:file)
    end

    def click_artifact artifact
      page.find('a',text:artifact).click
    end

    def artifact_contents
      wait_for_artifact_content
      artifact_content['innerHTML']
    end

    def property_exists? property
      page.has_css?("#property-of-#{property}")
    end
  end
end
