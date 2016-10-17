AgentResources
=========

AgentResources
-------------------
tags: agents management, agents

Setup of contexts
* Basic Configuration - setup
* Using pipeline "basic-pipeline-with-job-resources" - setup
* With "1" live agents - setup
 Capture go state "AgentResources" - setup

* Looking at pipeline "basic-pipeline-with-job-resources"
* Trigger "basic-pipeline-with-job-resources"
* Verify stage "1" is "Building" on pipeline with label "1"

* Verify agents at state "Building" is "0"
* Select all agents
* Add resources "test_resource"
* Wait for agent to show status "Building"


teardown
_______________
Capture go state "AgentResources" - teardown
* With "1" live agents - teardown
