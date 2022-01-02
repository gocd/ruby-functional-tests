SystemAdminPrivilegeToggling
============================

Setup of contexts
* With no users - setup
* Secure Configuration - setup
* Login as "admin" - setup
* Capture go state "SystemAdminPrivilegeToggling" - setup

SystemAdminPrivilegeToggling
----------------------------

tags: admin, role, user_summary, wip

This spec needs to be modified according to the changes in admin privilege toggle using the switch paddle on new user management page

* Add user "pavan" - Using user API
* Add user "raghu" - Using user API

* On User Summary page

* Add Roles as "admins" to users "pavan"
* Verify message displayed as "Roles are updated successfully!" after applying roles to users.
* Verify users "pavan" are assigned role "admins"

* Select users "pavan"
* Open roles menu
* Verify role state "Go System Administrator" is disabled with message "The selected users have administrative privilege via other roles. To remove this privilege, remove them from all administrative roles."
* Select users "raghu"
* Open roles menu
* Add roles "Go System Administrator, viewer"
* Apply changes to roles
* Verify message displayed as "Roles are updated successfully!" after applying roles to users.
* Verify users "raghu" are assigned role "viewer"
* Verify users "pavan,raghu" are administrators

* Select users "pavan,raghu"
* Open roles menu
* Verify role state "Go System Administrator" is disabled with message "The selected users have administrative privilege via other roles. To remove this privilege, remove them from all administrative roles."
* Select users "raghu"
* Open roles menu
* Verify role state "Go System Administrator" is enabled
* Remove roles "Go System Administrator"
* Apply changes to roles
* Verify message displayed as "Roles are updated successfully!" after applying roles to users.
* Verify users "raghu" are assigned role "viewer"
* Verify users "pavan" are assigned role "admins"
* Verify users "raghu" are not administrators

* Select users "pavan"
* Open roles menu
* Verify role state "Go System Administrator" is disabled with message "The selected users have administrative privilege via other roles. To remove this privilege, remove them from all administrative roles."
* Remove roles "admins"
* Add roles "viewer"
* Apply changes to roles
* Verify message displayed as "Roles are updated successfully!" after applying roles to users.
* Verify users "pavan,raghu" are assigned role "viewer"
* Verify users "pavan,raghu" are not administrators

* Select users "pavan,raghu"
* Open roles menu
* Verify role state "Go System Administrator" is enabled
* Remove roles "viewer"
* Add roles "admins"
* Apply changes to roles
* Verify message displayed as "Roles are updated successfully!" after applying roles to users.
* Verify users "pavan, raghu" are assigned role "admins"


Teardown of contexts
____________________
* As user "admin" for teardown
* Capture go state "SystemAdminPrivilegeToggling" - teardown
* Logout - from any page
