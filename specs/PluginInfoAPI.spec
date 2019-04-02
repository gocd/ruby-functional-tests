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

* Get all plugins info should return info for "15" valid plugins


teardown
_______________
* As user "admin" for teardown
* Capture go state "ArtifactStoreAPI" - teardown
* Logout - from any page
