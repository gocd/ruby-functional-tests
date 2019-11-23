NewEnvironmentsSPA
===============

Setup of contexts
* Environment Configuration - setup
* Login as "admin" - setup
* With "1" live agents - setup
* Using pipeline "basic-pipeline-with-job-resources" - setup
* Capture go state "NewEnvironmentsSPA" - setup

NewEnvironmentsSPA
-------------------
tags: new-environments-spa, spa, wip

* On new environments page
* Verify no environments present message

* Add new environment "env1"
* Verify if environment "env1" is added

* Open collapsible panel for "env1"

* Click on edit pipeline for "env1"
* Associate pipeline "basic-pipeline-fast-with-job-properties" to environment
* Verify pipeline "basic-pipeline-fast-with-job-properties" associated to environment "env1"

//* Click on edit agent for "env1"
//* Associate agent "agent1" to environment
//* Verify agent "agent1" associated to environment "env1"


Teardown of contexts
____________________
* Logout - from any page
* With "1" live agents - teardown
* Capture go state "NewEnvironmentsSPA" - teardown
