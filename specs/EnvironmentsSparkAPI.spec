EnvironmentsSparkAPI
============================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline-in-environment" - setup
* Capture go state "EnvironmentsSparkAPI" - setup

EnvironmentsSparkAPI
----------------------------

tags: environment_api, api

* Create environment "from-api"
* Create environment "from-api-with-secure-env"
* Update environment "from-api" to add pipeline "pipeline-in-environment"
* Encrypt value "=qh^Gl3tcN&?gF;a^FG," and store encrypted value as "encryptedValue"
* Update environment "from-api-with-secure-env" to add secure environment variable "secured" with value as "encryptedValue"
* Update environment "from-api" to add environment variable "non-secured" with value as "non-secured-value"


* Get environment "from-api" should return entity "pipelines" with "name: pipeline-in-environment"
* Get environment "from-api" should return entity "environment_variables" with "name: non-secured, value: non-secured-value"
* Get environment "from-api-with-secure-env" should return entity "environment_variables" with "name: secured, encrypted_value: encryptedValue"

* Create a new config repo environment with name "config-repo-environment" on repo "1"
* Wait for config repo changes to sync

* On new environments page
* Verify environment "config-repo-environment" is listed

* Get all environments should have "config-repo-environment, from-api, from-api-with-secure-env"


Teardown of contexts
____________________
* As user "admin" for teardown
* Logout - from any page
* Capture go state "EnvironmentsSparkAPI" - teardown
