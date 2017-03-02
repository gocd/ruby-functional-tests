ConfigReposPipeline
=================

ConfigReposPipeline
-------------------
tags: config_repo_pipeline

Setup of contexts
* Config repos Configuration - setup
* Using pipeline "simple-upstream" - setup
* With "1" live agents - setup
* Capture go state "ConfigReposPipeline" - setup

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

* Create a new config repo pipeline with name "third-pipeline" on repo "3" as downstream of "non-existing-pipeline"
* Verify pipeline "third-pipeline" do not show up on the dashboard

* Verify server health message is shown
* Verify server health message "Pipeline with name '$non-existing-pipeline$' does not exist, it is defined as a dependency for pipeline '$third-pipeline$'" is shown

* Update config repo pipeline with name "third-pipeline" as downstream of "second-pipeline"
* Verify pipeline "third-pipeline" shows up on the dashboard

* Update config repo pipeline with name "second-pipeline" as downstream of "non-existing-pipeline"
* Wait for server health message
* Verify server health message "Pipeline with name '$non-existing-pipeline$' does not exist, it is defined as a dependency for pipeline '$second-pipeline$'" is shown

teardown
_______________
* Capture go state "ConfigReposPipeline" - teardown
* With "1" live agents - teardown
