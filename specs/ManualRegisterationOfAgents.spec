ManualRegistrationOfAgents
===========================

ManualRegistrationOfAgents
-------------------
tags: agent_manual_registration

Setup of contexts
* SmokeConfiguration - setup
* Login as "admin" - setup
* Using pipeline "basic-pipeline-with-git-material" - setup
* With "1" pending agents - setup
* Capture go state "SmokeTest" - setup

* Verify agent summary shows "Pending" agent count as "1"
* Verify agent summary shows "Enabled" agent count as "0"
* Approve a pending agent
* Verify agents at state "Idle" is "1"
* Verify agents at state "Pending" is "0"

* Looking at pipeline "basic-pipeline-with-git-material"
* Trigger "basic-pipeline-with-git-material"
* Wait till pipeline completed stage "1"
* Verify stage "1" is "Passed" on pipeline with label "1"

teardown
_______________
* Capture go state "SmokeTest" - teardown
* With "1" live agents - teardown
