
EnableDisableUsers
==================

EnableDisableUsers
------------------

tags: Security

Setup of contexts

* With no users - setup
* Secure Configuration - setup
* Login as "admin" - setup
* Capture go state "EnableDisableUsers" - setup

* On User Summary page

* Search for "user1" and add user "1" in the search result
* Search for "user2" and add user "1" in the search result
* Verify users "user1,user2" are enabled

* Disable users "user2"
* Verify users "user2" are disabled

* Logout and Login as "user2" should fail with message "Your account has been disabled by the administrator Help Topic: Authentication"
* Login as "admin"

* On User Summary page

* Enable users "user2"
* Verify users "user2" are enabled

* Logout and login as "user2"

* Logout and login as "admin"

* On User Summary page

* Disable users "user2,user1"
* Verify users "user2,user1" are disabled

* Enable users "user2,user1"
* Verify users "user2,user1" are enabled

* Promote "user2" an admin user

* Disable users "admin,user2,user1"
* Verify error message "Did not disable any of the selected users. Ensure that all configured admins are not being disabled." is displayed



Teardown of contexts
____________________
* Capture go state "EnableDisableUsers" - teardown
* Logout - from any page
