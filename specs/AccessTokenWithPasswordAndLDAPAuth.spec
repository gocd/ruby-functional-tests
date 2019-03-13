AccessTokenWithPasswordAndLDAPAuth
============================

Setup of contexts
* Auth Plugins Configuration - setup
 Ldap server - stop
 Ldap server - start
* Login as "admin" - setup
* Using pipeline "basic-pipeline-fast" - setup
* Capture go state "AccessTokenAPI" - setup

AccessTokenWithPasswordAndLDAPAuth
----------------------------

tags: access_tokens

 Go to auth config page
 ldap - start creating new auth config with id "new_ldap"
 ldap - set manager dn ""
 ldap - set password ""
 ldap - set search bases "ou=People,dc=tests,dc=com"
 ldap - set login filter "(uid={0})"
 ldap - set user name attribute "uid"
 Perform check connection
 Verify flash message "Connection ok"
 Save authorization config
 Go to auth config page
 Verify if auth config "new_ldap" is added

* On personal access token
 Create access token with description as "Manage thru APIs" and remember it as "admin_token_1"

 Add user "groupAdmin" using access token "admin_token_1"
 Add role "G1_Admin" to user "groupAdmin" using access token "admin_token_1"
 Add user "Operator" using token "admin_token_1"
 Add role "G1_Operate" to user "Operator" using access token "admin_token_1"


 Login as "groupAdmin"
 On personal access token
 Create access token with description as "Manage pipelines" and remember it as "groupadmin_token_1"

 Create pipeline "P1" in group "G1" using token "groupadmin_token_1" should return response code "200"
 Create pipeline "P2" in group "G2" using token "groupadmin_token_1" should return response code "401"










Teardown of contexts
____________________
* As user "admin" for teardown
 Ldap server - stop
* Logout - from any page
* Capture go state "AccessTokenAPI" - teardown
