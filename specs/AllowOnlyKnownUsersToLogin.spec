
AllowOnlyKnownUsersToLogin
==========================

Setup of contexts
* With no users - setup
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "basic-pipeline" - setup
* Capture go state "AllowOnlyKnownUsersToLogin" - setup

AllowOnlyKnownUsersToLogin
--------------------------

tags: Allow_Users

* Allow only known users to login
* Logout and Login as "view" should fail with message "Please ask the administrator to add you to GoCD. Help Topic: Authentication"
* Login as "admin"
* Allow unknown users to login
* Logout and login as "view"


Teardown of contexts
____________________
* Capture go state "AllowOnlyKnownUsersToLogin" - teardown


