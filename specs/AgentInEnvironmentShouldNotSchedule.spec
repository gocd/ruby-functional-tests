AgentInEnvironmentShouldNotSchedule
===================================

AgentInEnvironmentShouldNotSchedule
-----------------------------------

tags: agents management, agents_spa, spa

Setup of contexts
* Basic Configuration - setup
* Using pipeline "basic-pipeline-fast" - setup
* With "1" live agents - setup
* Capture go state "AgentInEnvironmentShouldNotSchedule" - setup

* Select agent "1"
* Set environments "uat"
* Verify agent "1" assigned environments "uat"

* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Building" - On Swift Dashboard page

* On Agents page
* Verify agents at state "Building" is "0"
* Select agent "1"
* Remove environments "uat"

* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" - On Swift Dashboard page

Wait for agents to entirely complete
* Wait "5" seconds
* On Agents page
* Verify agents at state "Building" is "0"

teardown
_______________
* With "1" live agents - teardown
* Capture go state "AgentInEnvironmentShouldNotSchedule" - teardown
