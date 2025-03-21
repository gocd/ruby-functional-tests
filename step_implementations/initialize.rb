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

require 'rubygems'
require 'bundler'
require 'test/unit'
require 'ostruct'
require 'singleton'
require 'ladle'
require 'open3'
require 'json'
require 'json_builder'
require 'deep_merge'
require 'uri'
require 'rbconfig'
Bundler.setup(:default)
Bundler.require

require 'fileutils'
require_relative 'go_constants'
require_relative '../lib/helpers/api_builder'

$LOAD_PATH << File.expand_path('../../lib', __FILE__)
require 'helpers/spec_helper'
include Test::Unit::Assertions

Gauge.configure do |config|
  config.include Helpers::SpecHelper
  config.include Helpers::GoUrlHelper
  config.include Helpers::Wait
  config.screengrabber = -> {
    file = File.open(Capybara.page.save_screenshot, 'rb')
    file_content = File.binread(file.path)
    #FileUtils.rm_r 'screenshots', force: true
    return file_content
 }
end

Capybara.configure do |config|
  config.save_path = 'screenshots'
  config.default_max_wait_time = 20
end

Capybara.register_driver :selenium do |app|
  browser = (ENV['browser'] || 'firefox').to_sym
  config = case browser
           when :firefox
             ::Selenium::WebDriver::Firefox::Service.driver_path = `which geckodriver`.chomp
             options = ::Selenium::WebDriver::Firefox::Options.new
             options.args << "--headless" if RbConfig::CONFIG['host_os'] =~ /linux/
             { browser: browser, options: options }
           else
             chromedriver_path = `which chromedriver`.chomp
             ::Selenium::WebDriver::Chrome::Service.driver_path = chromedriver_path
             ::Selenium::WebDriver::Chromium::Service.driver_path = chromedriver_path
             ::Selenium::WebDriver::Edge::Service.driver_path = chromedriver_path
             { browser: browser }
           end
  Capybara::Selenium::Driver.new(app, **config)
end

Capybara.default_driver = :selenium

RestClient::Request.class_eval do
  def self.execute(args, & block)
    request_new = RestClient::Request.new(args)
    APIBuilder.build_tested(request_new)
    CurlBuilder.build(request_new)
    request_new.execute(& block)
  end
end


before_suite do
  go_server.start
  go_server.wait_to_start
end

after_suite do
  write_to_file("non_tested_apis.json", APIBuilder.build_non_tested)
  go_server.stop
  %x(rm -rf target/go_state) unless ENV['GO_PIPELINE_NAME']
  if !GoConstants::DEVELOPMENT_MODE && GoConstants::RUN_ON_DOCKER
    # Try and keep docker usage down on DINDed agents
    sh %(docker image prune -a -f || true)
  end
end

def write_to_file(filename, data)
begin
  file = File.open("reports/#{filename}", "w+")
  file.chmod(0755)
  file.write(data)
rescue IOError => e
ensure
  file.close unless file.nil?
end
end

after_scenario do
  app_base_page.logout
  basic_configuration.reset_config
end
