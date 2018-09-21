PipelineLockingBehavior
=========

PipelineLockingBehavior
-------------------
tags: pipeline_locking_behavior

Setup of contexts
* Basic Configuration - setup
* Using pipeline "pipeline-unlock-onComplete" - setup
* With "1" live agents - setup
* Capture go state "PipelineLockingBehavior" - setup

* Turn off AutoRefresh - On Swift Dashboard page

* Looking at pipeline "pipeline-unlock-onComplete" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "firstStage" is "Building" - On Swift Dashboard page

* Verify pipeline "pipeline-unlock-onComplete" is locked and not schedulable - Using api
* Verify pipeline is locked - On Swift Dashboard page
* Create a "stopjob" file
* Verify stage "firstStage" is "Passed" - On Swift Dashboard page

* Verify pipeline "pipeline-unlock-onComplete" is not locked and is schedulable - Using api

* Verify pipeline is not locked - On Swift Dashboard page

* Trigger stage "secondStage" run "1"

* Verify pipeline "pipeline-unlock-onComplete" is locked and not schedulable - Using api

* On Swift Dashboard Page
* Verify pipeline is locked - On Swift Dashboard page
* Create a "failjob" file
* Verify stage "secondStage" is "Failed" - On Swift Dashboard page

* Verify pipeline "pipeline-unlock-onComplete" is not locked and is schedulable - Using api

* Verify pipeline is not locked - On Swift Dashboard page

* Trigger stage "lastStage" run "1"

* Verify pipeline "pipeline-unlock-onComplete" is locked and not schedulable - Using api

* Verify pipeline is locked - On Swift Dashboard page
* Cancel stage "lastStage" of pipeline "pipeline-unlock-onComplete"
* Verify stage "lastStage" is "Cancelled" - On Swift Dashboard page

* Verify pipeline "pipeline-unlock-onComplete" is not locked and is schedulable - Using api

* Verify pipeline is not locked - On Swift Dashboard page

teardown
_______________
* Capture go state "PipelineLockingBehavior" - teardown
* With "1" live agents - teardown
