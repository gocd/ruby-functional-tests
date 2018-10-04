AdminPermissionsNewUsers
===================================

AdminPermissionsNewUsers
------------------------

tags: admin_permissions

Setup of contexts
* Basic Configuration - setup
* With "1" live agents - setup
* Capture go state "AdminPermissionsNewUsers" - setup

* Enable security with password file
* Login as "admin" - setup

Verify if user is admin
* VerifyIfUserIsAdmin 
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
* Capture go state "AdminPermissionsNewUsers" - teardown
* With "1" live agents - teardown

