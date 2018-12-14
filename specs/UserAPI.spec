UserAPI
=======

Setup of contexts
* With no users - setup
* Secure Configuration - setup
* Login as "admin" - setup
* Capture go state "UserAPI" - setup

UserAPI
-------

tags: api, users

* Add user "operate" - Using user API
* Add user "operatorUser" - Using user API
* Add user "notInAnyRoleA" - Using user API

* On User Summary page

* Attempt to delete "operate" user and should return "400"
* Attempt to delete "operatorUser" user and should return "400"

* Disable users "operate, operatorUser"
* Verify users "operate, operatorUser" are disabled

* Attempt to delete "operate" user and should return "200"
* Attempt to delete "operatorUser" user and should return "200"
* Attempt to delete "non_existent-user" user and should return "404"

* Logout and login as "view"

* Attempt to delete "notInAnyRoleA" user and should return "403"

* Logout - from any page


Teardown of contexts
____________________
* Capture go state "UserAPI" - teardown
* Logout - from any page


