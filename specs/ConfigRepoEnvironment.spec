ConfigRepoEnvironment
=================

ConfigRepoEnvironment
-------------------
tags: config_repo_environment

Setup of contexts
* Config repos Configuration - setup
* Using pipeline "simple-upstream, main-config-pipeline" - setup
* With "1" live agents - setup
* Capture go state "ConfigReposEnvironment" - setup

* Looking at pipeline "simple-upstream" - On Swift Dashboard page

* Create a new config repo pipeline with name "config-repo-pipeline" on repo "1" as downstream of "simple-upstream"
* Verify pipeline "config-repo-pipeline" shows up - On Swift Dashboard page

* Create a new config repo environment with name "config-repo-environment" on repo "2"
* Add pipelines "simple-upstream, config-repo-pipeline" to config repo environment "config-repo-environment"
* Wait for config repo changes to sync

* On new environments page
* Verify environment "config-repo-environment" is listed
* Open collapsible panel for "config-repo-environment"
* Verify pipeline "simple-upstream, config-repo-pipeline" associated to environment "config-repo-environment"

* Click on edit pipeline for "config-repo-environment"
* Associate pipeline "main-config-pipeline" to environment

* Verify pipeline "simple-upstream, config-repo-pipeline, main-config-pipeline" associated to environment "config-repo-environment"


* Click on edit pipeline for "config-repo-environment"
* Verify removing pipelines "simple-upstream, config-repo-pipeline" is not allowed - On Environments SPA

* Remove pipelines "main-config-pipeline" and save environment - On Environments SPA

* Verify pipeline "simple-upstream, config-repo-pipeline" associated to environment "config-repo-environment"
* Verify pipeline "main-config-pipeline" not associated to environment "config-repo-environment"

teardown
_______________
* With "1" live agents - teardown
* Capture go state "ConfigReposEnvironment" - teardown
