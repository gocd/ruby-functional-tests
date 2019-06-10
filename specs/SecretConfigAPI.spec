SecretConfigAPI
================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Capture go state "SecretConfigAPI" - setup

SecretConfigAPI
----------------
tags: secret_config, admin, api, secret_management

* Add secret config "secret_config_1" should return code "200"
* Update secret config "secret_config_1" to "allow" usage only in pipeline group "DevPipeline"
* Secret config "secret_config_1" should contain rule to "allow" usage in pipeline group "DevPipeline"

* Add secret config "secret_config_2" should return code "200"
* Update secret config "secret_config_2" to "deny" usage only in pipeline group "ProdPipeline"
* Secret config "secret_config_2" should contain rule to "deny" usage in pipeline group "ProdPipeline"

* Add secret config "secret_config_3" should return code "200"
* Adding duplicate secret config "secret_config_3" should fail with error code "422"

* Get all API should return all secret configs "secret_config_1,secret_config_2,secret_config_3"

* Delete secret config "secret_config_1" should return "200"
* Get secret config "secret_config_1" should return "404"

Teardown
_______________
* As user "admin" for teardown
* Capture go state "SecretConfigAPI" - teardown
* Logout - from any page
