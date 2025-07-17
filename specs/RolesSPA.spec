RolesSPA
=========

RolesSPA
-------------------
tags: roles-spa, spa

Setup of contexts
* Ldap server - start
* Auth Plugins Configuration - setup
* Login as "admin" - setup
* Capture go state "RolesSPA" - setup

* Go to roles page
* Create a new gocd role "gocd"
* Add user "view_user" to the role
* Add permission
* Update permission with "Allow", action "View", type "All" and resource "env*"
* Save role
* Verify flash message for role "The role gocd was created successfully!"
* Verify if role "gocd" is added

* Edit role "gocd"
* Add user "user 2" to the role
* Update permission: type "Environment"
* Save role
* Verify flash message for role "The role gocd was updated successfully!"

* Clone role "gocd"
* Set role name as "cloned_gocd"
* Add user "user1" to the role
* Remove permission
* Save role
* Verify flash message for role "The role cloned_gocd was created successfully!"
* Verify if role "cloned_gocd" is added

* Delete role "cloned_gocd"
* Confirm delete role
* Verify flash message for role "The role cloned_gocd was deleted successfully!"
* Verify if role "cloned_gocd" is not present

//Plugin role test

* Go to auth config page
* ldap - start creating new auth config with id "new_ldap"
* ldap - set manager dn ""
* ldap - set password ""
* ldap - set search bases "ou=People,dc=tests,dc=com"
* ldap - set login filter "(uid={0})"
* ldap - set user name attribute "uid"
* Perform check connection
* Verify flash message "Connection ok"
* Save authorization config
* Go to auth config page
* Verify if auth config "new_ldap" is added

* Go to roles page
* ldap - start creating a new plugin role "operate" with auth config "new_ldap"
* ldap - set group membership attribute "uid"
* ldap - set group identifiers "bob"
* Save role
* Verify flash message for role "The role operate was created successfully!"
* Verify if role "operate" is added

* Edit role "operate"
* ldap - set group membership attribute "sAMAccountName"
* ldap - set group identifiers "bob"
* Save role
* Verify flash message for role "The role operate was updated successfully!"

* Clone role "operate"
* Set role name as "super_admin"
* ldap - set group membership attribute "sAMAccountName"
* ldap - set group identifiers "admin"
* Save role
* Verify flash message for role "The role super_admin was created successfully!"
* Verify if role "super_admin" is added

* Delete role "super_admin"
* Confirm delete role
* Verify flash message for role "The role super_admin was deleted successfully!"
* Verify if role "super_admin" is not present

teardown
_______________
* As user "admin" for teardown
* Capture go state "RolesSPA" - teardown
* Logout - from any page
* Ldap server - stop
