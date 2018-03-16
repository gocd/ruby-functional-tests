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

require 'rubygems'
require 'bundler'
require 'owasp_zap'
require 'pry'
require 'test/unit'
require 'ostruct'
Bundler.setup(:default)
Bundler.require

require 'fileutils'
require_relative 'go_constants'

$LOAD_PATH << File.expand_path('../../lib', __FILE__)
require 'helpers/spec_helper'
include OwaspZap
include Test::Unit::Assertions

ZAP_PROXY = ENV['ZAP_PROXY'].to_s || nil

Gauge.configure do |config|
  config.include Helpers::SpecHelper
  config.include Helpers::GoUrlHelper
  config.include Helpers::Wait
  config.screengrabber = -> {
    Capybara.page.save_screenshot
    file = File.open(Dir.glob('screenshots/*.png').first, 'rb')
    file_content = File.binread(file.path)
    FileUtils.rm_r 'screenshots', force: true
    return file_content
  }
end

Capybara.configure do |config|
  config.save_path = 'screenshots'
end

Capybara.register_driver :selenium do |app|
  browser = (ENV['browser'] || 'firefox').to_sym
  if ZAP_PROXY
    profile = Selenium::WebDriver::Firefox::Profile.new
    profile['network.proxy.type'] = 1
    profile['network.proxy.http'] = ZAP_PROXY
    profile['network.proxy.http_port'] = 8081
    profile['network.proxy.ssl'] = ZAP_PROXY
    profile['network.proxy.ssl_port'] = 8081
  end
  cap = case browser
        when :firefox
          { browser: browser, profile: profile }
        else
          { browser: browser }
        end
  Capybara::Selenium::Driver.new(app, cap)
end

Capybara.default_driver = :selenium

module GoCDInitialize
  before_suite do
    go_server.start
    go_server.wait_to_start
    if ZAP_PROXY && ['localhost', '127.0.0.1'].include?(ZAP_PROXY)
      $zap = Zap.new(target: "http://#{GoConstants::GO_SERVER_BASE_URL}", zap: GoConstants::OWASP_ZAP_PATH.to_s, base: 'http://localhost:8081')
      unless $zap.running?
        $zap.start(daemon: true)
        wait_till_event_occurs_or_bomb 60, 'Expected ZAP Proxy to be listening by now' do
          break if $zap.running?
        end
      end
    end
  end

  after_suite do
    go_server.stop
    %x(rm -rf target/go_state)
    if $zap
      response = RestClient.get 'http://localhost:8081/OTHER/core/other/htmlreport'
      File.open('target/zap_report.html', 'w') { |file| file.write(response.body) }
      $zap.shutdown
    end
  end

  after_scenario do
    basic_configuration.reset_config
  end
end
