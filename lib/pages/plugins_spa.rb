##########################################################################
# Copyright 2017 ThoughtWorks, Inc.
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
  class PluginsSPA < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/new_plugins"

    element :plugin_settings, '.plugins-settings'

    load_validation { has_plugin_settings? }

    def invalid_plugin_message_exists?(id, message)
      plugin_config_element_of(id).has_selector?('dd', :text => message)
    end

    def plugin_by_id_is_invalid?(id)
      plugin_config_element_of(id).has_selector?('dt', :text => "There were errors loading the plugin")
    end

    def plugin_by_id_is_valid?(id)
      plugin_settings.find('.plugin-id', :text => id).find(:xpath, "../../..")[:class] == "plugin active"
    end

    def expand_collapse_plugin_config(id)
      begin
        plugin_settings.find('.plugin-id', :text => id).click
      rescue => e
        p "Not a valid plugin, moving ahead without expanding or collapsing. #{e.message} "
      end
    end

    def is_expected_version?(id, version)
      plugin_settings.find('.plugin-id', :text => id)
                      .find(:xpath, "../../..").find('.plugin-version').has_selector?(".value", :text => version)
    end

    def is_expected_name?(id, name)
      plugin_settings.find('.plugin-id', :text => id)
                      .find(:xpath, "../../..").has_selector?('div', :text => name)
    end

    def is_expected_description?(id, desc)
      plugin_config_element_of(id).has_selector?('dd', :text => desc)
    end

    def is_expected_author?(id, author)
      plugin_config_element_of(id).has_selector?('dd', :text => author)
    end

    def is_expected_author_link?(id, author, link)
      plugin_config_element_of(id).find('a', :text => author)[:href] == link
    end

    def is_author_link_disabled?(id, author, link)
      !plugin_config_element_of(id).has_selector?('a', :text => author)
    end

    def is_expected_installed_path?(id, path)
      plugin_config_element_of(id).has_selector?('dd', :text => path)
    end

    def is_expected_supported_os?(id, os)
      plugin_config_element_of(id).has_selector?('dd', :text => os)
    end

    def is_expected_go_version?(id, version)
      plugin_config_element_of(id).has_selector?('dd', :text => version)
    end

    def is_expected_bundled?(id, bundled)
      plugin_config_element_of(id).has_selector?('dd', :text => bundled)
    end

    def plugin_config_element_of(id)
      plugin_settings.find('.plugin-id', :text => id)
                      .find(:xpath, "../../..").find('.plugin-config-read-only')
    end

    def plugin_actions_of(id)
      plugin_settings.find('.plugin-id', :text => id)
                      .find(:xpath, "../../..").find('.plugin-actions')
    end

    def is_plugins_settings_enabled?(id)
      plugin_actions_of(id).has_selector?('.edit-plugin')
    end

    def is_plugins_settings_disabled?(id)
      plugin_actions_of(id).has_selector?('.edit-plugin.disabled')
    end

    def is_plugins_settings_displayed?(id)
      plugin_settings.find('.plugin-id', :text => id).find(:xpath, "../../..").has_selector?('.plugin-actions', visible: true)
    end

  end
end
