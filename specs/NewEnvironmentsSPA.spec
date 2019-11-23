NewEnvironmentsSPA
===============

Setup of contexts
* Environment Configuration - setup
* Login as "admin" - setup
* With "1" live agents - setup
* Using pipeline "basic-pipeline-fast-with-job-properties" - setup
* Update toggle "show_new_environments_spa" to value "ON"
* Capture go state "NewEnvironmentsSPA" - setup

NewEnvironmentsSPA
-------------------
tags: new-environments-spa, spa, wip

* On new environments page
* Verify no environments present message

* Add new environment "env1"
* Verify environment "env1" is listed

* Open collapsible panel for "env1"

* Click on edit pipeline for "env1"
* Associate pipeline "basic-pipeline-fast-with-job-properties" to environment
* Verify pipeline "basic-pipeline-fast-with-job-properties" associated to environment "env1"

* Click on edit agent for "env1"
* Associate all agents to the environment

* Click on edit environment variable for "env1"
* Add plain text environment variable name "OSTYPE" value "Linux"
* Verify environment variable "OSTYPE = Linux" are available for environment "env1"

* Click on edit environment variable for "env1"
* Add secure environment variable name "secret" value "value"
* Verify environment variable "secret = *****" are available for environment "env1"

* Add new environment "env2"
* Verify environment "env2" is listed

* Delete environment "env1"
* Verify environment "env1" is not listed

* Verify environment "env2" is listed



Teardown of contexts
____________________
* Logout - from any page
* With "1" live agents - teardown
* Capture go state "NewEnvironmentsSPA" - teardown
