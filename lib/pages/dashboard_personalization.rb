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
  class DashboardPersonalization < NewPipelineDashboard
    element :dashboard_tabs, '.dashboard-tabs'
    element :personalization_modal, '.overlay-personalize-editor'
    element :delete_tab_modal, '.overlay-delete-view'
    element :personalization_editor, '.personalize-editor-controls'

    def deselect_all_pipelines
      personalization_editor.find('button', text: 'None').click
    end

    def select_all_pipelines
      personalization_editor.find('button', text: 'All').click
    end

    def all_pipelines_selected?
      personalization_editor.find('.pipeline-selections').has_unchecked_field?()
    end

    def no_pipelines_selected?
      personalization_editor.find('.pipeline-selections').has_checked_field?()
    end

    def select_pipeline_group(pipeline_group_name)
      unless pipeline_group_checkbox_for(pipeline_group_name).checked?
        pipeline_group_checkbox_for(pipeline_group_name).click
      end
    end

    def deselect_pipeline_group(pipeline_group_name)
      if pipeline_group_checkbox_for(pipeline_group_name).checked?
        pipeline_group_checkbox_for(pipeline_group_name).click
      end
    end

    def expand_pipeline_group(pipeline_group_name)
      dropdown_arrow = pipeline_group_checkbox_for(pipeline_group_name).first(:xpath, '../..').find('.pipeline-list-toggle')
      dropdown_arrow.click
    end

    def are_all_pipelines_selected_for?(pipeline_group_name)
      pipeline_checkboxes_for_pgroup = get_pipeline_checkboxes_for(pipeline_group_name)

      pipeline_checkboxes_for_pgroup.each do |checkbox|
        return false unless checkbox.checked?
      end
      true
    end

    def are_all_pipelines_deselected_for?(pipeline_group_name)
      pipeline_checkboxes_for_pgroup = get_pipeline_checkboxes_for(pipeline_group_name)

      pipeline_checkboxes_for_pgroup.each do |checkbox|
        return false if checkbox.checked?
      end
      true
    end

    def select_pipeline(pipeline_name)
      pipeline_checkbox = pipeline_checkbox_for(pipeline_name)
      pipeline_checkbox.click unless pipeline_checkbox.checked?
    end

    def deselect_pipeline(pipeline_name)
      pipeline_checkbox = pipeline_checkbox_for(pipeline_name)
      pipeline_checkbox.click if pipeline_checkbox.checked?
    end

    def apply_selection
      personalization_modal.find_button('Save').click
    end

    def current_view_name
      dashboard_tabs.find(".dashboard-tab.current .tab-name").text
    end

    def switch_to_tab(tab_name)
      dashboard_tabs.find(".dashboard-tab[title=\"#{tab_name}\"]").click
    end

    def delete_tab
      personalization_modal.find("button", text: "Delete View").click
      delete_tab_modal.find('button', text: 'Yes').click
    end

    def set_view_name(view_name)
      personalization_editor.find("section.filter-name input").set(view_name, clear: :backspace, rapid: false)
    end

    def pipeline_group_selected?(group_name)
      pipeline_group_checkbox_for(group_name).checked?
    end

    def is_pipeline_group_indeterminate?(group_name)
      pipeline_group_checkbox_for(group_name)[:indeterminate] == true
    end

    def edit_view
      dashboard_tabs.find(".edit-tab").click
    end

    def show_new_pipelines?
      show_new_pipelines_checkbox.checked?
    end

    def check_show_new_pipelines
      show_new_pipelines_checkbox.click unless show_new_pipelines?
    end

    def uncheck_show_new_pipelines
      show_new_pipelines_checkbox.click if show_new_pipelines?
    end

    def filter_by_state(state)
      personalization_editor.find(".stage-state-selector")
        .find("span", text: state)
        .sibling("input").click
    end

    private

    def show_new_pipelines_checkbox
      personalization_editor.find(".show-pipelines")
        .find("input[name='include-new-pipelines']")
    end

    def pipeline_checkbox_for(pipeline_name)
      personalization_editor.find("ul.selected-pipelines_pipeline-list li span",
                                 text: pipeline_name).
                                 sibling("input")
    end

    def get_pipeline_checkboxes_for(pipeline_group_name)
      begin
        expand_pipeline_group(pipeline_group_name)
      rescue StandardError
        # do nothing the group is already expanded.
      end
      expanded_section = pipeline_group_checkbox_for(pipeline_group_name).first(:xpath, '../..')
      expanded_section.all('ul.selected-pipelines_pipeline-list li input')
    end

    def pipeline_group_checkbox_for(pipeline_group_name)
      personalization_editor.first(".selected-pipelines li span", text: pipeline_group_name)
        .sibling('input')
    end
  end
end
