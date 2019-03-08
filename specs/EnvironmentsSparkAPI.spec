EnvironmentsSparkAPI
============================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline-in-environment" - setup
* Capture go state "EnvironmentsSparkAPI" - setup

EnvironmentsSparkAPI
----------------------------

tags: environment_api

* Create environment "from-api"
* Update environment "from-api" to add pipeline "pipeline-in-environment"
 Encrypt value "=qh^Gl3tcN&?gF;a^FG," and store encrypted value as "encryptedValue"
 Update environment "from-api" to add secure environment variable "secured" with value as "encryptedValue"
* Update environment "from-api" to add environment variable "non-secured" with value as "non-secured-value"


* Get environment "from-api" should return entity "pipelines" with "name: pipeline-in-environment"
* Get environment "from-api" should return entity "environment_variables" with "name: non-secured, value: non-secured-value"
 Get environment "from-api" should return entity "environment_variables" with "name: secured, value: encryptedValue"

* Create a new config repo environment with name "config-repo-environment" on repo "1"
* Verify environment "config-repo-environment" shows up on the environments page

* Get all environments should have "config-repo-environment, from-api"


Teardown of contexts
____________________
* As user "admin" for teardown
* Logout - from any page
* Capture go state "EnvironmentsSparkAPI" - teardown
