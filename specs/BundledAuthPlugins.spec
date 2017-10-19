BundledAuthPlugins
=========

BundledAuthPlugins
-------------------
tags: bundled-auth-plugins

Setup of contexts
* AuthPluginsConfiguration - setup
* Login as "admin" - setup
* Using pipeline "basic-pipeline" - setup
* With "1" live agents - setup
* Capture go state "BundledAuthPlugins" - setup

* Start to add a new authorization config with id as "pwd_file" for plugin "Password File Authentication Plugin for GoCD"
* Set password file path as "password_plugin.properties"
* Save authorization config

* Login as "pwdadmin"

* Start to add a new authorization config with id as "ldap_auth" for plugin "LDAP Authentication Plugin for GoCD"
* Set LDAP Url
* Set Search Bases as "ou=People,dc=tests,dc=com"
* Set User Login Filter as "(uid={0})"
* Set Display Name Attribute as "uid"
* Save authorization config

* Start to add a GoCD config role "guest"
* Add user "view_user" to the role
* Save role config

* Edit pipeline group "basic"
* Add role "guest" as view user
* Add user "user1" as admin user
* Save pipeline group permissions

* Login as "view_user"

* Verify pipeline "basic-pipeline" is not editable

* Login as "user1" with password as "pass_user1"
* Verify pipeline "basic-pipeline" is editable

* Login as "admin"

* Start to add a new authorization config with id as "invalid_file" for plugin "Password File Authentication Plugin for GoCD"
* Set password file path as "non_existent_file"
* Save authorization config


* Login as "user1" with password as "pass_user1"
* Verify pipeline "basic-pipeline" is editable

* Login as "view_user"
* Verify pipeline "basic-pipeline" is not editable

* Login as "admin"
* Verify pipeline "basic-pipeline" is editable

Steps to verify login with different case

* Login as "USER1" with password as "pass_user1"
* Verify pipeline "basic-pipeline" is editable

* Login as "group1view"
* Verify pipeline "basic-pipeline" is not editable


teardown
_______________
* Capture go state "BundledAuthPlugins" - teardown
* With "1" live agents - teardown
* As user "admin" for teardown
* Configuration - teardown
