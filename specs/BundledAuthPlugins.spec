BundledAuthPlugins
=========

BundledAuthPlugins
-------------------
tags: bundled-auth-plugins

Setup of contexts
* Ldap server - start
* Auth Plugins Configuration - setup
* Login as "admin" - setup
* Using pipeline "basic-pipeline" - setup
* With "1" live agents - setup
* Capture go state "BundledAuthPlugins" - setup

* Start to add a new authorization config with id as "pwd_file" for plugin "Password File Authentication Plugin for GoCD"
* Set password file path as "password_plugin.properties"
* Save authorization config

* On Swift Dashboard Page
* Logout and login as "pwdadmin"

* Start to add a new authorization config with id as "ldap_auth" for plugin "LDAP Authentication Plugin for GoCD"
* Set LDAP Url
* Set Search Bases as "ou=People,dc=tests,dc=com"
* Set User Login Filter as "(uid={0})"
* Set Display Name Attribute as "uid"
* Save authorization config

* Start to add a GoCD config role "guest"
* Add user "view_user" to the role
* Save role

* On Admin pipeline page
* Edit pipeline group "basic"
* Add role "guest" as view user
* Add user "user1" as admin user
* Save pipeline group permissions

* On Swift Dashboard Page
* Logout and login as "view_user"

* Looking at pipeline "basic-pipeline" - On Swift Dashboard page

* Verify pipeline is not editable - On Swift Dashboard page

* Logout and Login as "user1" with password as "pass_user1"

* Verify pipeline is editable - On Swift Dashboard page

* Logout and login as "admin"

* Start to add a new authorization config with id as "invalid_file" for plugin "Password File Authentication Plugin for GoCD"
* Set password file path as "non_existent_file"
* Save authorization config

* On Swift Dashboard Page
* Logout and Login as "user1" with password as "pass_user1"

* Verify pipeline is editable - On Swift Dashboard page

* Logout and login as "view_user"

* Verify pipeline is not editable - On Swift Dashboard page

* Logout and login as "admin"

* Verify pipeline is editable - On Swift Dashboard page

Steps to verify login with different case

* Logout and Login as "USER1" with password as "pass_user1"

* Verify pipeline is editable - On Swift Dashboard page

* Logout and login as "View_User"

* Verify pipeline is not editable - On Swift Dashboard page


teardown
_______________
* As user "admin" for teardown
* Logout - from any page
* Ldap server - stop
* With "1" live agents - teardown
* Capture go state "BundledAuthPlugins" - teardown
