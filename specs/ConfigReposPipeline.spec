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


* Looking at pipeline "simple-upstream" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" - On Swift Dashboard page


* Create a new config repo pipeline with name "first-pipeline" on repo "1" as downstream of "simple-upstream"

* Verify pipeline "first-pipeline" shows up - On Swift Dashboard page
* Looking at pipeline "first-pipeline" - On Swift Dashboard page
* Verify pipeline is not editable - On Swift Dashboard page

* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" - On Swift Dashboard page

* On Config repo page
* Wait for config repo changes to sync
* Verify config repo with name "config-repo" has pipeline with name "first-pipeline"

* Create a new config repo pipeline with name "second-pipeline" on repo "2" as downstream of "first-pipeline"
* Verify pipeline "second-pipeline" shows up - On Swift Dashboard page

* Looking at pipeline "second-pipeline" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" - On Swift Dashboard page

* Create a new config repo pipeline with name "third-pipeline" on repo "3" as downstream of "non-existing-pipeline"
* Verify pipeline "third-pipeline" do not show up - On Swift Dashboard page

* Verify server health message "Pipeline with name '$non-existing-pipeline$' does not exist, it is defined as a dependency for pipeline '$third-pipeline$'" is shown

* Update config repo pipeline with name "third-pipeline" as downstream of "second-pipeline"
* Verify pipeline "third-pipeline" shows up - On Swift Dashboard page

* Update config repo pipeline with name "second-pipeline" as downstream of "non-existing-pipeline"

* Verify server health message "Pipeline with name '$non-existing-pipeline$' does not exist, it is defined as a dependency for pipeline '$second-pipeline$'" is shown

teardown
_______________
* Capture go state "ConfigReposPipeline" - teardown
* With "1" live agents - teardown
