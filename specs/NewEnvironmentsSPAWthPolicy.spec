NewEnvironmentsSPAWithPolicy
===============

Setup of contexts
* Secure Configuration with policy - setup
* Login as "admin" - setup
* Update toggle "show_new_environments_spa" to value "ON"
* Capture go state "NewEnvironmentsSPAWithPolicy" - setup

NewEnvironmentsSPAWithPolicy
-------------------
tags: new-environments-spa, policy, spa

* On new environments page
* Verify no environments present message

* Add new environment "env"
* Verify environment "env" is listed
* Verify delete button for "env" is enabled
* Verify edit buttons for "env" are enabled

* Logout and login as "frontend"
* On new environments page
* Add new environment "frontend_env"
* Verify environment "frontend_env" is listed

* Logout and login as "devops"
* On new environments page
* Add new environment "devops_env"
* Verify environment "devops_env" is listed

* Logout and login as "view"
* On new environments page
* Verify environment "env" is listed
* Verify delete button for "env" is disabled
* Verify edit buttons for "env" are disabled


* Logout and login as "bob"
* On new environments page

* Verify environment "frontend_env" is listed
* Verify delete button for "frontend_env" is enabled
* Verify edit buttons for "frontend_env" are enabled

* Verify environment "devops_env" is listed
* Verify delete button for "devops_env" is disabled
* Verify edit buttons for "devops_env" are disabled


Teardown of contexts
____________________
* Logout - from any page
* Capture go state "NewEnvironmentsSPAWithPolicy" - teardown
