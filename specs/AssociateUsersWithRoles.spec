
AssociateUsersWithRoles
=======================

Setup of contexts
* With no users - setup
* Secure Configuration - setup
* Login as "admin" - setup
* Capture go state "AssociateUsersWithRoles" - setup

AssociateUsersWithRoles
-----------------------

tags: admin, role

* Add user "pavan" - Using user API
* Add user "raghu" - Using user API
* Add user "operate" - Using user API

* On User Summary page

* Add Roles as "viewer" to users "pavan,raghu"
* Verify message displayed as "Role(s)/Admin-Privilege modified for 2 user(s) successfully." after applying roles to users.
* Verify users "pavan,raghu,operate" are assigned role "viewer"
* Add Roles as "viewer" to users "operate"
* Verify message displayed as "Role(s)/Admin-Privilege modified for 1 user(s) successfully." after applying roles to users.
* Verify users "pavan,raghu" are assigned role "viewer"
* Add new role as "new-role" to users "pavan"
* Verify users "pavan" are assigned role "new-role | viewer"
* Add new role as ".new*$%role" to users "pavan"
* Verify message displayed as "Failed to add role. Reason - " after applying roles to users.

* Add Roles as "operator" to users "pavan,raghu"
* Verify message displayed as "Role(s)/Admin-Privilege modified for 2 user(s) successfully." after applying roles to users.
* Verify users "pavan" are assigned role "new-role | operator | viewer"
* Verify users "raghu" are assigned role "operator | viewer"
* Verify users "raghu" does not have the role "new-role"


Teardown of contexts
____________________
* Capture go state "AssociateUsersWithRoles" - teardown
* Logout - from any page



