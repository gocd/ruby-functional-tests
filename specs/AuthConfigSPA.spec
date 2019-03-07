AuthorizationConfigurationSPA
=========

AuthorizationConfigurationSPA
-------------------
tags: authorization-configuration-spa, spa

Setup of contexts
* Ldap server - start
* Auth Plugins Configuration - setup
* Login as "admin" - setup
* Capture go state "BundledAuthPlugins" - setup


* Start to add a new authorization config with id as "new_auth_config" for plugin "Password File Authentication Plugin for GoCD"
* Set password file path as "password.properties"
* Perform check connection
* Verify flash message "Connection ok"
* Save authorization config
* Go to auth config page
* Verify if auth config "new_auth_config" is added

* Go to auth config page
* Edit auth config "new_auth_config"
* Set password file path as "foobar"
* Perform check connection
* Verify flash message "No password file at path"
* Save authorization config
* Verify flash message "The authorization configuration new_auth_config was updated successfully!"
* Go to auth config page

* Go to auth config page
* Clone auth config "new_auth_config"
* Set auth config id as "cloned_auth_config"
* Set password file path as "password.properties"
* Perform check connection
* Verify flash message "Connection ok"
* Save authorization config
* Verify flash message "The authorization configuration cloned_auth_config was created successfully!"
* Go to auth config page

Detele auth config
* Go to auth config page
* Delete auth config "new_auth_config"
* Confirm delete auth config
* Verify flash message "The authorization configuration new_auth_config was deleted successfully!"
* Go to auth config page


teardown
_______________
* As user "admin" for teardown
* Capture go state "BundledAuthPlugins" - teardown
* With "1" live agents - teardown
* Logout - from any page
* Ldap server - stop
