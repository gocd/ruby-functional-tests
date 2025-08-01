AdminPermissionsNewUsers
===================================

AdminPermissionsNewUsers
------------------------

tags: admin_permissions, with_security

Setup of contexts
* Basic Configuration - setup
* With "1" live agents - setup
* Capture go state "AdminPermissionsNewUsers" - setup

* Enable security with password file
* Login as "admin" - setup

Verify if user is admin
* VerifyIfUserHasRole
     |login as user|admin?|
     |-------------|------|
     |pavan        |true  |
     |raghu        |true  |
     |admin        |true  |

* Logout and login as "admin"
* On User Summary page
* Verify users "pavan,raghu,admin" are enabled


teardown
_______________
* As user "admin" for teardown
* Logout - from any page
* With "1" live agents - teardown
* Capture go state "AdminPermissionsNewUsers" - teardown
