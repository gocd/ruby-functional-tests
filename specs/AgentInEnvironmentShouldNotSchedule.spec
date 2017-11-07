AgentInEnvironmentShouldNotSchedule
=========

AgentInEnvironmentShouldNotSchedule
-------------------
tags: agents management, agents_spa, test

Setup of contexts
* Basic Configuration - setup
* Using pipeline "basic-pipeline-fast" - setup
* With "1" live agents - setup
* Capture go state "AgentInEnvironmentShouldNotSchedule" - setup

* Select agent "1"
* Set environments "uat"
* Verify agent "1" assigned environments "uat"

* Looking at pipeline "basic-pipeline-fast"
* Trigger "basic-pipeline-fast"
* Verify stage "defaultStage" is "Building"

* On Agents page
* Verify agents at state "Building" is "0"
* Select agent "1"
* Remove environments "uat"

* Looking at pipeline "basic-pipeline-fast"
* Wait till pipeline completed
* Verify stage "defaultStage" is "Passed"

teardown
_______________
* Capture go state "AgentInEnvironmentShouldNotSchedule" - teardown
* With "1" live agents - teardown
