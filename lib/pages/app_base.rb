##########################################################################
# Copyright 2016 ThoughtWorks, Inc.
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
require 'Capybara/dsl'

module Pages
  class AppBase < SitePrism::Page
    include Helpers::Wait

    def resize()
      page.driver.browser.manage.window.resize_to(1240, 1024)
    end

    def reload_page
      page.driver.browser.navigate.refresh
      sleep 5
    end
  end
end
