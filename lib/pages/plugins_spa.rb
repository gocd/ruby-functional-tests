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

    element :plugin_list_wrapper, '[data-test-id="plugins-list"]'
    element :go_server_url, "input[ng-model='go_server_url']"
    element :auto_register_timeout, "input[ng-model='auto_register_timeout']"
    element :max_docker_containers, "input[ng-model='max_docker_containers']"
    element :docker_uri, "input[ng-model='docker_uri']"

    load_validation { has_plugin_list_wrapper? }

    def invalid_plugin_message_exists?(id, message)
      plugin_to_test(id).find('[data-test-id="key-value-value-there-were-errors-loading-the-plugin"]').has_selector?('pre', text: message)
    end

    def plugin_to_test(id)
      if plugin_list_wrapper.has_css?('[data-test-id="plugin-name"]', text: id)
        plugin_list_wrapper.find('[data-test-id="plugin-name"]', text: id).ancestor('[data-test-id="plugin-row"]')
      elsif plugin_list_wrapper.has_css?('[data-test-id="key-value-value-id"]', text: id)
        plugin_list_wrapper.find('[data-test-id="key-value-value-id"]', text: id).ancestor('[data-test-id="plugin-row"]')
      else
        raise "Plugin with identifier #{id} not visible on plugins list"
      end
    end

    def plugin_is_invalid?(id)
      plugin_to_test(id)['data-test-has-error']
    end

    def plugin_is_valid?(id)
      !plugin_to_test(id)['data-test-has-error']
    end

    def collapse_plugin_config(id)
      plugin_to_test(id).click
    rescue StandardError => e
      p "Not a valid plugin, moving ahead without collapsing. #{e.message} "
    end

    def expand_plugin_config(id)
      plugin_to_test(id).click
    rescue StandardError => e
      p "Not a valid plugin, moving ahead without expanding. #{e.message} "
    end

    def is_expected_version?(id, version)
      plugin_to_test(id).find('[data-test-id="key-value-value-version"]').has_selector?('pre', text: version)
    end

    def is_expected_name?(id, name)
      plugin_to_test(id).find('[data-test-id="plugin-name"]').text.eql?(name)
    end

    def is_expected_description?(id, desc)
      plugin_to_test(id).find('[data-test-id="key-value-value-description"]').has_selector?('pre', text: desc)
    end

    def is_expected_author?(id, author)
      plugin_to_test(id).find('[data-test-id="key-value-value-author"]').has_selector?('a', text: author)
    end

    def is_expected_author_link?(id, author, link)
      plugin_to_test(id).find('[data-test-id="key-value-value-author"]').find('a', text: author)[:href] == link
    end

    def is_author_link_disabled?(id, author, _link)
      !plugin_to_test(id).find('[data-test-id="key-value-value-author"]').find('a', text: author)[:href] == link
    end

    def is_expected_installed_path?(id, path)
      plugin_to_test(id).find('[data-test-id="key-value-value-plugin-file-location"]').has_selector?('pre', text: path)
    end

    def is_expected_supported_os?(id, os)
      plugin_to_test(id).find('[data-test-id="key-value-value-supported-operating-systems"]').text.eql?(os)
    end

    def is_expected_go_version?(id, version)
      plugin_to_test(id).find('[data-test-id="key-value-value-target-gocd-version"]').has_selector?('pre', text: version)
    end

    def is_expected_bundled?(id, bundled)
      plugin_to_test(id).find('[data-test-id="key-value-value-bundled"]').has_selector?('pre', text: bundled)
    end

    def is_plugins_settings_enabled?(id)
      !is_plugins_settings_disabled?(id)
    end

    def is_plugins_settings_disabled?(id)
        plugin_to_test(id).find('[data-test-disabled-element]')
        true
      rescue
        false
    end

    def is_plugins_settings_displayed?(id)
      # Using hass_css? in this method results in true even for plugins without settings button, so using find and weird logic of rescue on failure
        plugin_to_test(id).find('[data-test-id="edit-plugin-settings"]')
        true
      rescue
        false
    end

    def open_plugin_setings(id)
      plugin_to_test(id).find('[data-test-id="edit-plugin-settings"]').click
    end

    def save_settings
      page.find('button', text: 'Save').click
    end
  end
end
