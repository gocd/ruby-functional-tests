EnvironmentsAPIUserPermissionUsingPolicy
============================

Setup of contexts
* Secure Configuration with policy - setup
* Using pipeline "pipeline-in-environment" - setup
* Capture go state "EnvironmentsAPIUserPermissionUsingPolicy" - setup

EnvironmentsSparkAPI
----------------------------

tags: environment_api, policy

~~~~~~~~ create environment ~~~~~~~~

* As user "admin"
* Create environment "from-api"

* As user "frontend"
* Create environment "frontend_env_1"
* Create environment "env_1" should return forbidden
* Create environment "backend_env_1" should return forbidden

* As user "backend"
* Create environment "backend_env_1"
* Create environment "env_1" should return forbidden
* Create environment "frontend_env_1" should return forbidden

* As user "devops"
* Create environment "devops_env_1"
* Create environment "env_1" should return forbidden
* Create environment "frontend_env_1" should return forbidden

* As user "developer"
* Create environment "env_1"
* Create environment "frontend_env_2"
* Create environment "backend_env_2"
* Create environment "devops_env_2" should return forbidden

~~~~~~~~ get environment ~~~~~~~~

* As user "view"
* Get environment "from-api" should return success
* Get environment "frontend_env_1" should return success
* Get environment "backend_env_1" should return success
* Get environment "devops_env_1" should return success
* Get environment "env_1" should return success
* Get environment "frontend_env_2" should return success
* Get environment "backend_env_2" should return success

* As user "frontend"
* Get environment "from-api" should return forbidden
* Get environment "frontend_env_1" should return success
* Get environment "backend_env_1" should return forbidden
* Get environment "devops_env_1" should return forbidden
* Get environment "env_1" should return forbidden
* Get environment "frontend_env_2" should return success
* Get environment "backend_env_2" should return forbidden

* As user "developer"
* Get environment "from-api" should return success
* Get environment "frontend_env_1" should return success
* Get environment "backend_env_1" should return success
* Get environment "devops_env_1" should return forbidden
* Get environment "env_1" should return success
* Get environment "frontend_env_2" should return success
* Get environment "backend_env_2" should return success


~~~~~~~~ get all environments ~~~~~~~~

* As user "view"
* Get all environments should have "from-api, frontend_env_1, backend_env_1, devops_env_1, env_1, frontend_env_2, backend_env_2"

* As user "frontend"
* Get all environments should have "frontend_env_1, frontend_env_2"
* Get all environments should not have "from-api, backend_env_1, devops_env_1, env_1, backend_env_2"

* As user "backend"
* Get all environments should have "backend_env_1, backend_env_2"
* Get all environments should not have "from-api, frontend_env_1, devops_env_1, env_1, frontend_env_2"

* As user "devops"
* Get all environments should have "devops_env_1"
* Get all environments should not have "from-api, frontend_env_1, backend_env_1, backend_env_2, env_1, frontend_env_2"

* As user "developer"
* Get all environments should have "from-api, frontend_env_1, backend_env_1, env_1, frontend_env_2, backend_env_2"
* Get all environments should not have "devops_env_1"


~~~~~~~~ update environment ~~~~~~~~

* As user "admin"
* Update environment "from-api" should return success

* As user "frontend"
* Update environment "frontend_env_1" should return success
* Update environment "env_1" should return forbidden
* Update environment "backend_env_1" should return forbidden

* As user "backend"
* Update environment "backend_env_1" should return success
* Update environment "env_1" should return forbidden
* Update environment "frontend_env_1" should return forbidden

* As user "devops"
* Update environment "devops_env_1" should return success
* Update environment "env_1" should return forbidden
* Update environment "frontend_env_1" should return forbidden

* As user "developer"
* Update environment "env_1" should return success
* Update environment "frontend_env_2" should return success
* Update environment "backend_env_2" should return success
* Update environment "devops_env_2" should return forbidden

~~~~~~~~ multiple role user ~~~~~~~~

* As user "multiple.role.user"
* Create environment "env_1" should return forbidden
* Get environment "env_1" should return forbidden
* Get all environments should not have "from-api, frontend_env_1, backend_env_1, devops_env_1, env_1, frontend_env_2, backend_env_2"
* Update environment "env_1" should return forbidden
* Delete environment "env_1" should return forbidden


~~~~~~~~ delete environment ~~~~~~~~

* As user "admin"
* Delete environment "from-api" should return success

* As user "frontend"
* Delete environment "frontend_env_1" should return success
* Delete environment "env_1" should return forbidden
* Delete environment "backend_env_1" should return forbidden

* As user "backend"
* Delete environment "backend_env_1" should return success
* Delete environment "env_1" should return forbidden
* Delete environment "frontend_env_1" should return forbidden

* As user "devops"
* Delete environment "devops_env_1" should return success
* Delete environment "env_1" should return forbidden
* Delete environment "frontend_env_1" should return forbidden

* As user "developer"
* Delete environment "env_1" should return success
* Delete environment "frontend_env_2" should return success
* Delete environment "backend_env_2" should return success
* Delete environment "devops_env_2" should return forbidden

Teardown of contexts
____________________

* Capture go state "EnvironmentsAPIUserPermissionUsingPolicy" - teardown
