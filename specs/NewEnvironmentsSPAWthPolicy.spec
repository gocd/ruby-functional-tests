NewEnvironmentsSPAWithPolicy
===============

Setup of contexts
* Secure Configuration with policy - setup
* Login as "admin" - setup
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

* Verify permissions API shows "environment" "view" list has only "env"
* Verify permissions API shows "environment" "administer" list has only "env"

* Logout and login as "frontend"
* On new environments page
* Add new environment "frontend_env"
* Verify environment "frontend_env" is listed

* Verify permissions API shows "environment" "view" list has only "frontend_env"
* Verify permissions API shows "environment" "administer" list has only "frontend_env"

* Logout and login as "devops"
* On new environments page
* Add new environment "devops_env"
* Verify environment "devops_env" is listed

* Verify permissions API shows "environment" "view" list has only "devops_env"
* Verify permissions API shows "environment" "administer" list has only "devops_env"

* Logout and login as "view"
* On new environments page
* Verify environment "env" is listed
* Verify delete button for "env" is disabled
* Verify edit buttons for "env" are disabled

* Verify permissions API shows "environment" "view" list has only "devops_env, env, frontend_env"
* Verify permissions API shows "environment" "administer" list has only ""


* Logout and login as "bob"
* On new environments page

* Verify environment "frontend_env" is listed
* Verify delete button for "frontend_env" is enabled
* Verify edit buttons for "frontend_env" are enabled

* Verify environment "devops_env" is listed
* Verify delete button for "devops_env" is disabled
* Verify edit buttons for "devops_env" are disabled

* Verify permissions API shows "environment" "view" list has only "frontend_env, devops_env"
* Verify permissions API shows "environment" "administer" list has only "frontend_env"


Teardown of contexts
____________________
* Logout - from any page
* Capture go state "NewEnvironmentsSPAWithPolicy" - teardown
