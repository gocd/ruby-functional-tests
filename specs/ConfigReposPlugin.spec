ConfigReposPlugin
=================

ConfigReposPlugin
-------------------
tags: config_repo_plugin

Setup of contexts
* Config repos Configuration - setup
* Using pipeline "simple-upstream" - setup
* With "1" live agents - setup
* Capture go state "ConfigReposPlugin" - setup

* Looking at pipeline "simple-upstream"
* Trigger "simple-upstream"
* Wait till pipeline completed stage "1"
* Verify stage "1" is "Passed" on pipeline with label "1"

* Create a new config repo pipeline with name "first-pipeline" on repo "1" as downstream of "simple-upstream"
* Verify pipeline "first-pipeline" shows up on the dashboard

* Looking at pipeline "first-pipeline"
* Trigger "first-pipeline"
* Wait till pipeline completed stage "1"
* Verify stage "1" is "Passed" on pipeline with label "1"

* Create a new config repo pipeline with name "second-pipeline" on repo "2" as downstream of "first-pipeline"
* Verify pipeline "second-pipeline" shows up on the dashboard

* Looking at pipeline "second-pipeline"
* Trigger "second-pipeline"
* Wait till pipeline completed stage "1"
* Verify stage "1" is "Passed" on pipeline with label "1"

teardown
_______________
* Capture go state "ConfigReposPlugin" - teardown
* With "1" live agents - teardown
