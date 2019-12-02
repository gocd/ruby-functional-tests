ConfigRepoEnvironmentMerge
=================

ConfigRepoEnvironmentMerge
-------------------
tags: config_repo_environment_merge

Setup of contexts
* Config repos Configuration - setup
* Using pipeline "simple-upstream, main-config-pipeline" - setup
* Using environment "test-environment" - setup
* With "1" live agents - setup
* Capture go state "ConfigReposEnvironmentMerge" - setup

* Looking at pipeline "simple-upstream" - On Swift Dashboard page

* On new environments page
* Verify environment "test-environment" is listed

* Create a partial config repo environment with name "test-environment" on repo "1"
* Add pipelines "main-config-pipeline" to config repo environment "test-environment"
* Wait for config repo changes to sync

* On new environments page
* Open collapsible panel for "test-environment"
* Verify pipeline "main-config-pipeline" associated to environment "test-environment"

teardown
_______________
* Capture go state "ConfigReposEnvironmentMerge" - teardown
* With "1" live agents - teardown
