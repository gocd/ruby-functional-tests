PluginInfoAPI
=========

PluginInfoAPI
-------------------
tags: plugin_info, api

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Capture go state "PluginInfoAPI" - setup

* As user "admin"
* Get plugins info for plugin "cd.go.authentication.passwordfile"
* Plugin info response should have "extensions" of "type" value "authorization"
* Plugin info response should have "extensions" with "auth_config_settings"
* Plugin info response should have "extensions" with "capabilities"

* Get plugins info for plugin "json.config.plugin"
* Plugin info response should have "extensions" of "type" value "configrepo"
* Plugin info response should have "extensions" with "plugin_settings"
* Plugin info response should have "extensions" with "capabilities"

* Get all plugins info should return info for details of "test.donothing.plugin, test.valid.innerclass.plugin"


teardown
_______________
* As user "admin" for teardown
* Logout - from any page
* Capture go state "PluginInfoAPI" - teardown
