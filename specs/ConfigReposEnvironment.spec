ConfigReposEnvironment
=================

ConfigReposEnvironment
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

* Verify environment "config-repo-environment" shows up on the environments page

* Open Environment edit page for environment "config-repo-environment"
* Verify pipelines "simple-upstream, config-repo-pipeline" are available on "config-repo-environment" edit page

* Edit pipelines
* Add pipeline "main-config-pipeline" and save environment
* Open Environment edit page for environment "config-repo-environment"
* Verify pipelines "simple-upstream, config-repo-pipeline, main-config-pipeline" are available on "config-repo-environment" edit page

* Edit pipelines
* Verify removing pipelines "simple-upstream, config-repo-pipeline" is not allowed

* Remove pipelines "main-config-pipeline" and save environment
* Open Environment edit page for environment "config-repo-environment"
* Verify pipelines "simple-upstream, config-repo-pipeline" are available on "config-repo-environment" edit page
* Verify pipelines "main-config-pipeline" are not available on "config-repo-environment" edit page

teardown
_______________
* Capture go state "ConfigReposEnvironment" - teardown
* With "1" live agents - teardown
