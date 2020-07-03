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
    element :check_ins, 'div[data-test-id="comparison-result-widget"]'
    element :to_pipeline, 'div[data-test-id="pipeline-to-instance"] input[type="search"]'
    element :from_pipeline, 'div[data-test-id="pipeline-from-instance"] input[type="search"]'
    element :browse_to_timeline, 'div[data-test-id="pipeline-to-instance"] a'
    element :browse_from_timeline, 'div[data-test-id="pipeline-from-instance"] a'
    element :pipeline_instance_list, 'div[data-test-id="matching-instances-results"]'
    element :next_page, 'div[data-test-id="pagination"] a[title="Next"]'
    element :previous_page, 'div[data-test-id="pagination"] a[title="Previous"]'

    def click_on_To_box_for_browse_timeline
      to_pipeline.click
      browse_to_timeline.click
    end

    def click_on_From_box_for_browse_timeline
      from_pipeline.click
      browse_from_timeline.click
    end

    def selected_pipeline_label_is?(label)
      page.has_selector?('div[data-test-id^="instance-"][class*="modal__selected-instance"] span[data-test-id="instance-counter"]', text: label)
    end

    def get_pipeline_labels
      pipeline_labels = []
      page.find('div[data-test-id="left-pane"]').all('span[data-test-id="instance-counter"]', wait: 10).each do |element|
        pipeline_labels.push(element.text.to_i)
      end
      puts "labels found: #{pipeline_labels}"
      pipeline_labels
    end

    def click_page(label)
      page.find('.wrapper a.MB_focusable', text: label).click
      page.has_content?(pipeline_instance_list, wait: 10)
    end

    def select_pipeline_with_label(label)
      instance_div = 'div[data-test-id="instance-' + label + '"]'
      page.find(instance_div).click
      page.find('button[data-test-id="button-select-instance"]').click
    end

    def verify_pipeline_dependency_revision(pipeline_name, revision)
      revisions = []
      pipeline_dependency_material_modifications(pipeline_name).each do |widget|
        widget.find('table').all('tbody tr').each {|tr| revisions.push(tr.all('td').first.text)}
      end
      puts "revisions: #{revisions}"
      true if revisions.include? sanitize_message(revision)
    end

    def verify_pipeline_dependency_label(pipeline_name, label)
      labels = []
      pipeline_dependency_material_modifications(pipeline_name).each do |widget|
        widget.find('table').all('tbody tr').each {|tr| labels.push(tr.all('td')[1].text)}
      end
      puts "labels: #{labels}"
      true if labels.include? label
    end

    def verify_scm_material_revision(material_type, revision)
      revisions = []
      pipeline_scm_material_modifications(material_type).each do |widget|
        widget.find('table').all('tbody tr').each {|tr| revisions.push(tr.all('td').first.text)}
      end
      puts "revisions: #{revisions}"
      true if revisions.include? revision
    end

    def verify_scm_material_comment(material_type, comment)
      comments = []
      pipeline_scm_material_modifications(material_type).each do |widget|
        widget.find('table').all('tbody tr').each {|tr| comments.push(tr.all('td').last.text)}
      end
      puts "comments: #{comments}"
      true if comments.include? comment
    end

    def click_label(label)
      page.find('div[data-test-id="matching-instances-results"]').find('h5', text: label).click
    end

    def label_exists?(label)
      page.find('div[data-test-id="matching-instances-results"]').has_selector?('h5', text: label)
    end

    def number_of_materials?(count)
      check_ins.all('span[data-test-id="material-header"]').size.equal? count
    end

    def checkin_info_message?(message)
      page.find('div[data-test-id="info-msg"]').text.include? message
    end

    def to_instance_error_msg(message)
      page.find('div[data-test-id="pipeline-to-instance"] div[data-test-id="warning"]').text.include? message
    end

    def see_bisect_diff
      check_ins.find('a', text: 'CONTINUE').click
    end

    def click_revision(rev)
      page.find('a', text: sanitize_message(rev)).click
    end

    def unauthorized_message_exist?
      page.has_css?('h3', text: 'Not authorized to view pipeline')
    end

    def click_next_page
      assert_false next_page.disabled?
      next_page.click
    end

    private

    def pipeline_dependency_material_modifications(pipeline_name)
      check_ins.all('div[data-test-id="material-changes"]')
          .select {|mt| mt.find('span[data-test-id="material-header"]')
                            .text.start_with?("Pipeline - #{pipeline_name}")}
    end

    def pipeline_scm_material_modifications(material_type)
      check_ins.all('div[data-test-id="material-changes"]')
          .select {|mt| mt.find('span[data-test-id="material-header"]')
                            .text.start_with?("#{material_type} - ")}
    end
  end
end
