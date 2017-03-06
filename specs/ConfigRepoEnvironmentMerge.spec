ConfigReposEnvironmentMerge
=================

ConfigReposEnvironmentMerge
-------------------
tags: config_repo_environment_merge

Setup of contexts
* Config repos Configuration - setup
* Using pipeline "simple-upstream, main-config-pipeline" - setup
* Using environment "test-environment" - setup
* With "1" live agents - setup
* Capture go state "ConfigReposEnvironmentMerge" - setup

* Looking at pipeline "simple-upstream"

* Verify environment "test-environment" shows up on the environments page

* Create a partial config repo environment with name "test-environment" on repo "1"
* Add pipelines "main-config-pipeline" to config repo environment "test-environment"
* Wait for config repo changes to sync

* Open Environment edit page for environment "test-environment"
* Verify pipelines "main-config-pipeline" are available on "test-environment" edit page

teardown
_______________
* Capture go state "ConfigReposEnvironmentMerge" - teardown
* Using pipeline "simple-upstream, main-config-pipeline" - teardown
* Using environment "test-environment" - teardown
* With "1" live agents - teardown