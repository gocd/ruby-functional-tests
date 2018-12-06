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

require 'helpers/go_url_helper'
require 'helpers/page_helper'
require 'helpers/spec_helper'
require 'helpers/curl_builder'
require 'helpers/wait_helper'
require 'helpers/general_helper'
require 'context/go_state'
require 'context/agents'
require 'context/basic_configuration'
require 'context/materials'
require 'context/scenario_state'
require 'context/secure_configuration'
require 'context/server'
require 'context/pipeline'
require 'context/ldap'
require 'pages/app_base'
require 'pages/login_page'
require 'pages/data_sharing_spa'
require 'pages/agents_spa'
require 'pages/environments_page'
require 'pages/environments_edit_page'
require 'pages/server_health_messages'
require 'pages/preferences_page'
require 'pages/authorization_config_spa'
require 'pages/role_config_spa'
require 'pages/pipeline_group_edit_page'
require 'pages/plugins_spa'
require 'pages/user_summary'
require 'pages/new_pipeline_dashboard_page'
require 'pages/dashboard_personalization'
require 'pages/pipeline_history_page'
require 'pages/admin_pipeline_page'
require 'pages/stage_details_page'
require 'pages/global_analytics_page'
require 'pages/artifacts_store_page'
require 'pages/general_settings_page'
require 'pages/job_settings_page'
require 'pages/publish_artifacts_view'
require 'pages/job_details_page'
require 'pages/compare_pipeline_page'
require 'pages/stage_settings_page'
require 'pages/pipeline_settings_page'
require 'pages/vsm_page'
require 'pages/pipeline_creation_wizard'
require 'pages/parameters_page'
require 'pages/config_xml_page'

module Helpers
  module SpecHelper
    def app_base_page
      Pages::AppBase.new
    end

    def general_settings_page
      Pages::GeneralSettingsPage.new
    end

    def login_page
      Pages::Login.new
    end

    def data_sharing_spa_page
      Pages::DataSharingSPA.new
    end

    def agents_spa_page
      Pages::AgentsSPA.new
    end

    def dashboard_personalization
      Pages::DashboardPersonalization.new
    end

    def new_pipeline_dashboard_page
      Pages::NewPipelineDashboard.new
    end

    def global_analytics_page
      Pages::GlobalAnalyticsPage.new
    end

    def stage_details_page
      Pages::StageDetailsPage.new
    end

    def environments_dashboard_page
      Pages::EnvironmentsPage.new
    end

    def authorization_config_page
      Pages::AuthConfigSPA.new
    end

    def role_config_page
      Pages::RoleConfigSPA.new
    end

    def preferences_page
      Pages::Preferences.new
    end

    def environments_edit_page(environment)
      Pages::EnvironmentsEditPage.new(environment)
    end

    def pipeline_group_edit_page
      Pages::PipelineGroupEditPage.new
    end

    def plugins_spa_page
      Pages::PluginsSPA.new
    end

    def user_summary_page
      Pages::UserSummary.new
    end

    def pipeline_history_page
      Pages::PipelineHistoryPage.new
    end

    def server_health_message
      Pages::ServerHealthMessage.new
    end

    def admin_pipeline_page
      Pages::AdminPipelinePage.new
    end

    def artifacts_store_page
      Pages::ArtifactsStore.new
    end

    def job_settings_page
      Pages::JobSettings.new
    end

    def publish_artifacts_view
      Pages::PublishArtifactsView.new
    end

    def job_details_page
      Pages::JobDetailsPage.new
    end

    def compare_pipeline_page
      Pages::ComparePipelinePage.new
    end

    def vsm_page
      Pages::VSMPage.new
    end

    def pipeline_creation_wizard
      Pages::PipelineCreationWizard.new
    end

    def stage_settings_page
      Pages::StageSettingsPage.new
    end

    def config_xml_page
      Pages::ConfigXMLPage.new
    end

    def pipeline_settings_page
      Pages::PipelineSettingsPage.new
    end

    def basic_configuration
      Context::BasicConfiguration.new
    end

    def ldap_server
      Context::LdapServer.new
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

    def go_agents
      Context::Agents.instance
    end

    def go_server
      Context::Server.new
    end

    def git_materials
      Context::GitMaterials.new
    end

    def svn_materials
      Context::SVNMaterials.new
    end

    def go_state
      Context::GoState.new
    end
    
    def parameters_page
      Pages::ParametersPage.new
    end

  end
end
