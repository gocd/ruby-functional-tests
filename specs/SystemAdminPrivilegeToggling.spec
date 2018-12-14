SystemAdminPrivilegeToggling
============================

Setup of contexts
* With no users - setup
* Secure Configuration - setup
* Login as "admin" - setup
* Capture go state "SystemAdminPrivilegeToggling" - setup

SystemAdminPrivilegeToggling
----------------------------

tags: admin, role, user_summary

* Add user "pavan" - Using user API
* Add user "raghu" - Using user API

* On User Summary page

* Add Roles as "admins" to users "pavan"
* Verify message displayed as "Role(s)/Admin-Privilege modified for" after applying roles to users.
* Verify users "pavan" are assigned role "admins"

* Toggle selection of users "pavan"
 Verify role state "Go System Administrator" is disabled with message "The selected users have administrative privilege via other roles. To remove this privilege, remove them from all administrative roles."
* Toggle selection of users "pavan,raghu"
 Verify role state "Go System Administrator" is enabled
* Add roles "Go System Administrator, viewer"
* Apply changes to roles
* Verify message displayed as "Role(s)/Admin-Privilege modified for" after applying roles to users.
* Verify users "raghu" are assigned role "viewer"
* Verify users "pavan,raghu" are administrators

* Toggle selection of users "pavan,raghu"
* Verify role state "Go System Administrator" is disabled with message "The selected users have administrative privilege via other roles. To remove this privilege, remove them from all administrative roles."
* Toggle selection of users "pavan"
* Verify role state "Go System Administrator" is enabled
* Add roles "Go System Administrator"
* Apply changes to roles
* Verify message displayed as "Role(s)/Admin-Privilege modified for" after applying roles to users.
* Verify users "raghu" are assigned role "viewer"
* Verify users "pavan" are assigned role "admins"
* Verify users "raghu" are not administrators

* Toggle selection of users "pavan"
* Verify role state "Go System Administrator" is disabled with message "The selected users have administrative privilege via other roles. To remove this privilege, remove them from all administrative roles."
* Remove roles "admins"
* Add roles "viewer"
* Apply changes to roles
* Verify message displayed as "Role(s)/Admin-Privilege modified for" after applying roles to users.
* Verify users "pavan,raghu" are assigned role "viewer"
* Verify users "pavan,raghu" are not administrators

* Toggle selection of users "pavan,raghu"
* Verify role state "Go System Administrator" is enabled
* Select role states "admins:add, viewer:remove"
* Apply changes to roles
* Verify message displayed as "Role(s)/Admin-Privilege modified for" after applying roles to users.
* Verify users "pavan, raghu" are assigned role "admins"





Teardown of contexts
____________________
* Capture go state "SystemAdminPrivilegeToggling" - teardown
* Logout - from any page


