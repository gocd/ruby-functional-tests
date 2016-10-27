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

require 'helpers/go_url_helper'
require 'helpers/page_helper'
require 'helpers/spec_helper'
require 'helpers/wait_helper'
require 'context/go_state'
require 'context/agents'
require 'context/basic_configuration'
require 'context/materials'
require 'context/scenario_state'
require 'context/secure_configuration'
require 'context/server'
require 'pages/app_base'
require 'pages/login'
require 'pages/agents_spa'
require 'pages/pipelinedashboard'

module Helpers
  module SpecHelper
    def app_base_page
      Pages::AppBase.new
    end

    def login_page
      Pages::Login.new
    end

    def agents_spa_page
      Pages::AgentsSPA.new
    end

    def pipeline_dashboard_page
      Pages::PipelineDashboard.new
    end

    def basic_configuration
      Context::BasicConfiguration.new
    end

    def secure_configuration
      Context::SecureConfiguration.new
    end

    def scenario_state
      Context::ScenarioState.new
    end

    def config_helper
      Helpers::ConfigHelper.new
    end

    def go_urls
      Helpers::GoUrlHelper.new
    end

    def go_agents
      Context::Agents.new
    end

    def go_server
      Context::Server.new
    end

    def git_materials
      Context::GitMaterials.new
    end

    def go_state
      Context::GoState.new
    end
  end
end
