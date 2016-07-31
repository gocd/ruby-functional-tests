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

require 'rubygems'
require 'bundler'
Bundler.setup(:default)
Bundler.require

require 'fileutils'

$LOAD_PATH << File.expand_path('../../lib', __FILE__)
require 'helpers/spec_helper'

Gauge.configure do |config|
  config.include Helpers::SpecHelper
  config.include Helpers::GoUrlHelper
  config.include Helpers::Wait
end

Capybara.register_driver :selenium do |app|
  browser = (ENV['browser'] || 'chrome').to_sym
  Capybara::Selenium::Driver.new(app, browser: browser)
end

Capybara.default_driver = :selenium

module GoCDInitialize
  before_suite do
    go_server.start
    go_server.wait_to_start
  end

  after_suite do
    go_server.stop
  end

  after_scenario do
    basic_configuration.reset_config
  end
end
