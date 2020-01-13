ConfigRepoAPIUserPermissionUsingPolicy
============================

Setup of contexts
* Secure Configuration with policy for config repo - setup
* Capture go state "ConfigRepoAPIUserPermissionUsingPolicy" - setup

ConfigRepoAPI
----------------------------

tags: config_repo_api, policy, api

~~~~~~~~ create config repo ~~~~~~~~

* As user "admin"
* Create config repo "cr"

* As user "user1"
* Create config repo "cr1_1"
* Create config repo "cr_1" should return forbidden
* Create config repo "cr2_1" should return forbidden

* As user "user2"
* Create config repo "cr2_2"
* Create config repo "cr_2" should return forbidden
* Create config repo "cr3_2" should return forbidden

* As user "user3"
* Create config repo "cr3_3"
* Create config repo "cr_3" should return forbidden
* Create config repo "cr4_3" should return forbidden

* As user "user4"
* Create config repo "cr1_4"
* Create config repo "cr2_4"
* Create config repo "cr4_4"
* Create config repo "cr3_4" should return forbidden

~~~~~~~~ get config_repo ~~~~~~~~

* As user "view"
* Get config repo "cr" should return success
* Get config repo "cr1_1" should return success
* Get config repo "cr2_2" should return success
* Get config repo "cr3_3" should return success
* Get config repo "cr1_4" should return success
* Get config repo "cr2_4" should return success
* Get config repo "cr4_4" should return success

* As user "user1"
* Get config repo "cr" should return forbidden
* Get config repo "cr1_1" should return success
* Get config repo "cr2_2" should return forbidden
* Get config repo "cr3_3" should return forbidden
* Get config repo "cr4_4" should return forbidden
* Get config repo "cr1_4" should return success
* Get config repo "cr2_4" should return forbidden

* As user "user4"
* Get config repo "cr" should return success
* Get config repo "cr1_1" should return success
* Get config repo "cr2_2" should return success
* Get config repo "cr3_3" should return forbidden
* Get config repo "cr4_4" should return success
* Get config repo "cr1_4" should return success
* Get config repo "cr4_4" should return success

~~~~~~~~ get all config repos ~~~~~~~~

* As user "view"
* Get all config repos should have "cr, cr1_1, cr2_2, cr3_3, cr4_4, cr1_4, cr2_4"

* As user "user1"
* Get all config repos should have "cr1_1, cr1_4"
* Get all config repos should not have "cr, cr2_2, cr3_3, cr4_4, cr2_4"

* As user "user2"
* Get all config repos should have "cr2_2, cr2_4"
* Get all config repos should not have "cr, cr1_1, cr3_3, cr4_4, cr1_4"

* As user "user3"
* Get all config repos should have "cr3_3"
* Get all config repos should not have "cr, cr1_1, cr2_2, cr2_4, cr4_4, cr1_4"

* As user "user4"
* Get all config repos should have "cr, cr1_1, cr2_2, cr4_4, cr1_4, cr2_4"
* Get all config repos should not have "cr3_3"

* Get status of config repo "cr" should return success
* Trigger update of config repo "cr4_4" should return success


~~~~~~~~ update config repo ~~~~~~~~

* As user "admin"
* Update config repo "cr" should return success


* As user "user1"
* Update config repo "cr1_1" should return success
* Update config repo "cr4_4" should return forbidden
* Update config repo "cr2_2" should return forbidden

* As user "user2"
* Update config repo "cr2_2" should return success
* Update config repo "cr4_4" should return forbidden
* Update config repo "cr1_1" should return forbidden

* As user "user3"
* Update config repo "cr3_3" should return success
* Update config repo "cr4_4" should return forbidden
* Update config repo "cr1_1" should return forbidden

* As user "user4"
* Update config repo "cr4_4" should return success
* Update config repo "cr1_4" should return success
* Update config repo "cr2_4" should return success
* Update config repo "cr3_3" should return forbidden





~~~~~~~~ delete config repo ~~~~~~~~

* As user "admin"
* Delete config repo "cr" should return success

* As user "user1"
* Delete config repo "cr1_1" should return success
* Delete config repo "cr4_4" should return forbidden
* Delete config repo "cr2_2" should return forbidden

* As user "user2"
* Delete config repo "cr2_2" should return success
* Delete config repo "cr4_4" should return forbidden
* Delete config repo "cr1_1" should return forbidden

* As user "user3"
* Delete config repo "cr3_3" should return success
* Delete config repo "cr4_4" should return forbidden
* Delete config repo "cr1_1" should return forbidden

* As user "user4"
* Delete config repo "cr4_4" should return success
* Delete config repo "cr1_4" should return success
* Delete config repo "cr2_4" should return success
* Delete config repo "cr3_3" should return forbidden

~~~~~~~~ multiple role user ~~~~~~~~

* As user "multiple.role.user"
* Create config repo "cr4_4" should return forbidden
* Get config repo "cr4_4" should return forbidden
* Get all config repos should not have "cr, cr1_1, cr2_2, cr3_3, cr4_4, cr1_4, cr2_4"
* Update config repo "cr4_4" should return forbidden
* Delete config repo "cr4_4" should return forbidden


Teardown of contexts
____________________

* Capture go state "ConfigRepoAPIUserPermissionUsingPolicy" - teardown
