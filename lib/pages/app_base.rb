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
require 'capybara/dsl'

module Pages
  class AppBase < SitePrism::Page
    include Helpers::Wait
    include Helpers::GeneralHelper

    def resize()
      page.driver.browser.manage.window.resize_to(1240, 1024)
    end

    def reload_page
      page.driver.browser.navigate.refresh
      sleep 5
    end

    def logout
      if page.has_css? ('.current_user_name')
        page.find('.current_user_name').hover
        page.find('.logout').click
      else
        new_pipeline_dashboard_page.load
        page.find('.current-user.opens-left').hover
        page.find('a', text: 'Sign out').click
      end
    end

    def verify_footer()
      footer = page.find('p[class="copyright"]')
      assert_true footer.text.include?("Copyright © #{Time.now.strftime('%Y')} ThoughtWorks, Inc. Licensed under Apache License, Version 2.0. Go includes third-party software. Go Version: #{ENV['GO_VERSION']}")
      assert_true footer.has_link?(nil, href: "https://www.thoughtworks.com/products")
      assert_true footer.has_link?(nil, href: "https://www.apache.org/licenses/LICENSE-2.0")
      assert_true footer.has_link?(nil, href: "/go/NOTICE/cruise_notice_file.pdf")

      social = page.find('span[class="inline-list social"]')
      assert_true social.has_link?(nil, href: "https://twitter.com/goforcd")
      assert_true social.has_link?(nil, href: "https://github.com/gocd/gocd")
      assert_true social.has_link?(nil, href: "https://groups.google.com/d/forum/go-cd")
      assert_true social.has_link?(nil, href: "https://docs.gocd.org/#{GoConstants::GO_VERSION}")
      assert_true social.has_link?(nil, href: "https://www.gocd.org/plugins/")
      assert_true social.has_link?(nil, href: "https://api.gocd.org/#{GoConstants::GO_VERSION}")
      assert_true social.has_link?(nil, href: "/go/about")
      assert_true social.has_link?(nil, href: "/go/cctray.xml")

    end

    def menu_item_visible(item)
      page.all('ul', :class => 'menu').first.has_css?('a', :text => item.upcase)
    end
  end
end
