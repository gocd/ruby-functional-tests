AccessTokenCreateUseRevoke
============================

Setup of contexts
* Auth Plugins Configuration - setup
* Login as "admin" - setup
* Using pipeline "basic-pipeline-with-auth" - setup
* With "1" live agents - setup
* Capture go state "AccessTokenCreateUseRevoke" - setup

AccessTokenCreateUseRevoke
----------------------------

tags: access_tokens

* On Swift Dashboard Page
* Looking at pipeline "basic-pipeline-with-auth" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till stage "firstStage" completed - On Swift Dashboard page
* Verify stage "firstStage" is "Failed" - On Swift Dashboard page

* On personal access token page
* Create access token with description as "Manage users and roles" and remember it as "admin_token_1"

* Add user "operatorUser" using access token "admin_token_1" - Using user API
* Add user "operatorUser" to role "G1_Operate" using access token "admin_token_1" - Using roles API
* Add user "view" using access token "admin_token_1" - Using user API
* Add user "view" to role "G1_View" using access token "admin_token_1" - Using roles API

* Logout and login as "view"
* On personal access token page
* Create access token with description as "View pipelines" and remember it as "view_token_1"

* Logout and login as "operatorUser"
* On personal access token page
* Create access token with description as "Operate pipelines" and remember it as "operatorUser_token_1"

* Verify unauthorized to unlock "basic-pipeline-with-auth" using access token "view_token_1"
* Verify can unlock "basic-pipeline-with-auth" using access token "operatorUser_token_1"

* Logout and login as "admin"
* On admin access token page
* Revoke token of user "operatorUser" with description "Operate pipelines" given revoke reason as "test"

* Logout and login as "operatorUser"
* On personal access token page
* On revoked tokens tab
* Token with description "Operate pipelines" should be listed



Teardown of contexts
____________________
* As user "admin" for teardown
* Logout - from any page
* With "1" live agents - teardown
* Capture go state "AccessTokenCreateUseRevoke" - teardown
