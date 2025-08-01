DisabledUserAccess
==================

Setup of contexts
* With no users - setup
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "basic-pipeline-fast" - setup
* With "1" live agents - setup
* Capture go state "DisabledUserAccess" - setup

DisabledUserAccess
------------------

tags: Admin, Security

* Add user "operate" - Using user API
* Add user "group1View" - Using user API

* On User Summary page

* Verify users "operate, group1View" are enabled

* Logout and login as "operate"

* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "passed" - On Swift Dashboard page

* Logout and login as "admin"

* On User Summary page

* Disable users "operate"
* Verify users "operate" are disabled

* Logout and Login as "operate" should fail with message "Your account has been disabled by the administrator"

* As user "operate"

* Trigger pipeline "basic-pipeline-fast" and verify response code "401" - Using api


Teardown of contexts
____________________
* As user "admin" for teardown
* Logout - from any page
* With no users - teardown
* With "1" live agents - teardown
* Capture go state "DisabledUserAccess" - teardown
