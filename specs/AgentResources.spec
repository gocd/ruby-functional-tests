AgentResources
=========

AgentResources
-------------------
tags: agents management, agents_spa

Setup of contexts
* Basic Configuration - setup
* Using pipeline "basic-pipeline-with-job-resources" - setup
* With "1" live agents - setup
* Capture go state "AgentResources" - setup

* Looking at pipeline "basic-pipeline-with-job-resources"
* Trigger "basic-pipeline-with-job-resources"
* Verify stage at "1" is "Building" on pipeline with label "1"

* On Agents page
* Verify agents at state "Building" is "0"
* Select All agents
* Set resources "test_resource"
* Wait till agent "1" status is "Building"


teardown
_______________
* Capture go state "AgentResources" - teardown
* With "1" live agents - teardown
