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
require 'context/yum_repository'
require 'pages/app_base'
require 'pages/login_page'
require 'pages/data_sharing_spa'
require 'pages/agents_spa'
require 'pages/server_health_messages'
require 'pages/preferences_page'
require 'pages/authorization_config_spa'
require 'pages/role_config_spa'
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
require 'pages/ldap_authorization_plugin'
require 'pages/maintenance_mode_spa'
require 'pages/server_backup_page'
require 'pages/personal_access_token_page'
require 'pages/admin_access_token_page'
require 'pages/elastic_agent_profiles_page'
require 'pages/elastic_profiles_page'
require 'pages/secret_config_spa'
require 'pages/config_repos_page'
require 'pages/server_configuration_page'
require 'pages/new_admin_pipeline_page'
require 'pages/admin_config_xml_page'
require 'pages/config_xml_snippets_page'
require 'pages/admin_templates_page'
require 'pages/new_environments_page'
require 'pages/package_repository_page'
require 'pages/package_material_page'
require 'pages/new_pipeline_group_page'
require 'pages/pluggable_scm_page.rb'

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

    def personal_access_token_page
      Pages::PersonalAccessToken.new
    end

    def elastic_agents_profiles_page
      Pages::ElasticAgentsProfiles.new
    end

    def elastic_profiles_page
      Pages::ElasticProfiles.new
    end

    def new_environments_page
      Pages::NewEnvironments.new
    end

    def admin_access_token_page
      Pages::AdminAccessToken.new
    end

    def data_sharing_spa_page
      Pages::DataSharingSPA.new
    end

    def server_backup_page
      Pages::BackUpPage.new
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


    def authorization_config_page
      Pages::AuthConfigSPA.new
    end

    def maintenance_mode_page
      Pages::MaintenanceModePage.new
    end

    def ldap_authorization_plugin_auth_config_modal
      Pages::LDAPAuthorizationPluginAuthConfigModal.new
    end

    def ldap_authorization_plugin_role_config_modal
      Pages::LDAPAuthorizationPluginRoleConfigModal.new
    end

    def role_config_page
      Pages::RoleConfigSPA.new
    end

    def secret_management_page
      Pages::SecretConfigSPA.new
    end

    def preferences_page
      Pages::Preferences.new
    end

    def new_pipeline_group_page
      Pages::NewPipelineGroupPage.new
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

    def go_state
      Context::GoState.new
    end

    def parameters_page
      Pages::ParametersPage.new
    end

    def config_repos_page
       Pages::ConfigReposPage.new
    end

    def server_configuration_page
      Pages::ServerConfigurationPage.new
    end

    def new_admin_pipeline_page
      Pages::NewAdminPipelinePage.new
    end

    def admin_config_xml_page
      Pages::AdminConfigXMLPage.new
    end

    def config_xml_snippets_page
      Pages::ConfigXMLSnippetsPage.new
    end

    def admin_templates_page
      Pages::AdminTemplatesPage.new
    end

    def yum_repo
      Context::YumRepo.new
    end

    def package_repository_page
      Pages::PackageRepositoryPage.new
    end

    def package_material_page
      Pages::PackageMaterialPage.new
    end

    def pluggable_scm_page
      Pages::PluggableSCMPage.new
    end


  end
end
