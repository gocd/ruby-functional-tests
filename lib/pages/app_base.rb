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

require 'site_prism'
require 'capybara/dsl'

module Pages
  class AppBase < SitePrism::Page
    include Helpers::Wait
    include Helpers::GeneralHelper
    include Helpers::GoUrlHelper

    def resize()
      page.driver.browser.manage.window.resize_to(1240, 1024)
    end

    def reload_page
      page.driver.browser.navigate.refresh
    end

    def logout
      page.driver.browser.navigate.to(http_url('/auth/logout'))
      sleep 5 # waiting for the logout redirect is easier than elsewhere
    end

    def menu_item_visible(item)
      page.find('#app-menu').has_css?('a', text: item.upcase)
    end

    def hover_on_admin
      page.find('#app-menu').find('a', text: 'ADMIN').hover
    end

    def replace_element_value(element_to_be_replaced, replace_by_value)
      element_to_be_replaced.send_keys [:control , 'a']  #use :command when testing on a mac box
      element_to_be_replaced.send_keys :backspace
      element_to_be_replaced.send_keys replace_by_value
    end
  end
end
