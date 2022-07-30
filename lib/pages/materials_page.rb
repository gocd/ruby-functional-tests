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
  class MaterialsPage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/materials"

    def materials_shown
      page.all('div[data-test-id="materials-widget"] > div')
          .count
    end

    def find_all_pipeline_usages_for(material_name)
      selected_header = find_collapsible_header(material_name)
      if selected_header
        selected_header.find("button[data-test-id='show-usages']").click

        page.all('td:first-child')
            .map(&:text)
      end
    end

    def get_attrs_for(material_name)
      selected_header = find_collapsible_header(material_name)
      if selected_header
        selected_header.click

        selected_header
            .sibling('div[data-test-id="collapse-body"]')
            .all('ul[data-test-id="material-attributes"] > li')
            .map {|element| "#{element.find('label').text}:#{element.find('span').text}"
            }
      end
    end

    def latest_mod_details(material_name)
      selected_header = find_collapsible_header(material_name)
      if selected_header
        selected_header
            .find('div[data-test-id="latest-mod-in-header"] > div > span')
            .text
      end
    end

    def no_mod_details(material_name)
      selected_header = find_collapsible_header(material_name)
      if selected_header
        return selected_header
                   .find('div[data-test-id="latest-mod-in-header"]')
                   .text == 'This material was never parsed'
      end
      false
    end

    def open_modifications_modal(material_name)
      selected_header = find_collapsible_header(material_name)
      if selected_header
        selected_header.find("button[data-test-id='show-modifications-material']").click
      end
    end

    def get_comment(index)
      page.find("div[data-test-id='mod-#{index.to_i - 1}'] div[data-test-id='mod-comment']")
          .text
    end

    def trigger_update(material_name)
      selected_header = find_collapsible_header(material_name)
      if selected_header
        selected_header.find("button[data-test-id='trigger-update']").click
      end
    end

    private

    def find_collapsible_header(material_name)
      page.all("div[data-test-id='collapse-header']")
          .find {|widget| widget.find('h4[data-test-id="material-type"]').text === material_name}
    end
  end
end
