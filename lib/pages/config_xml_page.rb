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
  class ConfigXMLPage < AppBase
    element :edit_link, '.edit.link_as_button'
    element :content_container_for_edit, '#content_container_for_edit'
    element :content_container, '#content_container'
    element :save, '#save_config'

    def verify_group_links_visible(groups)
      actual = page.find('#modifiable_groups').all('.modifiable_group_link').collect(&:text)
      expected = groups.split(',').collect(&:strip)
      assert_true (expected - actual).empty?
    end

    def verify_selected_group_is(group)
      page.find('.selected').all('.modifiable_group_link').each do |link|
        assert_true group.eql?(link.text), "Expected group #{group} to be selected, but actual selected is #{link.text}"
      end
    end

    def modify_group_name(old_name, new_name)
      new_content = content_container_for_edit.text.gsub! old_name, new_name
      content_container_for_edit.set(new_content, rapid: false)
      save.click
    end

    def config_xml_include?(text)
      content_container.text.include? text
    end

    def save_successful?
      wait_till_event_occurs_or_bomb 20, 'Expected config xml save successful message by now' do
        break if page.find('#message_pane', wait: 10).has_css?('.success', text: 'Saved configuration successfully.')
      end
    end

    def error_message_displayed?(message)
      wait_till_event_occurs_or_bomb 20, 'Expected config xml save error message by now' do
        break if page.find('#message_pane', wait: 10).has_css?('.error', text: message)
      end
    end

    def open_config_from_admin_menu
      hover_on_admin
      page.find('#app-menu').find('a', text: 'Config XML').click
    end
  end
end
