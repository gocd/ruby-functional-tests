@@ -0,0 +1,52 @@
AdminRolesAndUsers
===================================

AdminRolesAndUsers
------------------------

tags: admin_permissions

Setup of contexts
* Secure Configuration - setup
* Using pipeline "viewable-pipeline" - setup
* Login as "admin" - setup
* With "1" live agents - setup
* Capture go state "AdminPermissionsNewUsers" - setup


* Making "pavan" an admin user
* Making "raghu" an admin user

Verify if user is admin

* VerifyIfUserHasRole
     |login as user|admin?|
     |-------------|------|
     |view         |false |
     |operate      |false |
     |pavan        |true  |
     |raghu        |true  |
     |admin        |true  |

* Logout - from any page
* Login as "admin"
* Removing "raghu" as an admin user
* VerifyIfUserHasRole
     |login as user|admin?|
     |-------------|------|
     |raghu        |false |

* On Swift Dashboard Page
* Verify pipeline "admin-pipeline" is not visible - On Swift Dashboard page
* Logout - from any page
* Login as "pavan"
* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" - On Swift Dashboard page

teardown
_______________
* Capture go state "AdminPermissionsNewUsers" - teardown
* With "1" live agents - teardown

