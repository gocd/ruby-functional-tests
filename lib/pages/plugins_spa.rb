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
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/plugins"

    element :plugin_settings, '.plugins-settings'

    load_validation { has_plugin_settings? }

    def invalid_plugin_message_exists?(id, message)
      plugin_config_element_of(id).has_selector?('dd', text: message)
    end

    def plugin_by_id_is_invalid?(id)
      plugin_settings.find('.plugin-id', text: id)..ancestor('.plugin-header')[:class].include?('plugin disabled')
    end

    def plugin_by_id_is_valid?(id)
      plugin_settings.find('.plugin-id', text: id).ancestor('.plugin-header')[:class].include?('plugin active')
    end

    def collapse_plugin_config(id)
      return if plugin_settings.find('.plugin-id', text: id)..ancestor('.plugin-header')[:class].include?('collapsed')
      plugin_settings.find('.plugin-id', text: id).click
    rescue StandardError => e
      p "Not a valid plugin, moving ahead without collapsing. #{e.message} "
    end

    def expand_plugin_config(id)
      return if plugin_settings.find('.plugin-id', text: id)..ancestor('.plugin-header')[:class].include?('expanded')
      plugin_settings.find('.plugin-id', text: id).click
      rescue StandardError => e
        p "Not a valid plugin, moving ahead without expanding. #{e.message} "
    end

    def is_expected_version?(id, version)
      plugin_settings.find('.plugin-id', text: id)
                     .ancestor('.plugin-header').find('.plugin-version').has_selector?('.value', text: version)
    end

    def is_expected_name?(id, name)
      plugin_settings.find('.plugin-id', text: id)
                     .ancestor('.plugin-header').has_selector?('div', text: name)
    end

    def is_expected_description?(id, desc)
      parent_for_given_label(id,'Description').find('span').text == desc
    end

    def is_expected_author?(id, author)
      parent_for_given_label(id,'Author').find('span').text == author
    end

    def is_expected_author_link?(id, author, link)
     parent_for_given_label(id,'Author').find('a', text: author)[:href] == link
    end

    def is_author_link_disabled?(id, author, _link)
      !plugin_config_element_of(id).has_selector?('a', text: author)
    end

    def is_expected_installed_path?(id, path)
      parent_for_given_label(id,'Plugin file location').find('span').has_text?(path)
    end

    def is_expected_supported_os?(id, os)
      parent_for_given_label(id,'Supported operating systems').find('span').text == os
    end

    def is_expected_go_version?(id, version)
      parent_for_given_label(id,'Target Go Version').find('span').text == version
    end

    def is_expected_bundled?(id, bundled)
      parent_for_given_label(id,'Bundled').find('span').text == bundled
    end

    def plugin_config_element_of(id)
      plugin_settings.find('.plugin-id', text: id)
                     .ancestor('.plugin.expanded').find('.plugin-config-read-only')
    end

    def plugin_actions_of(id)
      plugin_settings.find('.plugin-id', text: id)
                     .ancestor('.plugin-header').find('.plugin-actions')
    end

    def is_plugins_settings_enabled?(id)
      plugin_actions_of(id).has_selector?('.edit-plugin')
    end

    def is_plugins_settings_disabled?(id)
      plugin_actions_of(id).has_selector?('.edit-plugin.disabled')
    end

    def is_plugins_settings_displayed?(id)
      plugin_settings.find('.plugin-id', text: id)..ancestor('.plugin-header').has_selector?('.plugin-actions', visible: true)
    end

    def parent_for_given_label(id,label_text)
      plugin_config_element_of(id).find('label' , text: label_text).find(:xpath , '..')
    end
  end
end
