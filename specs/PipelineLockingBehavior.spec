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

* Turn off AutoRefresh - Dashboard page

* Looking at pipeline "pipeline-unlock-onComplete"
* Trigger "pipeline-unlock-onComplete"
* Verify stage "firstStage" is "Building"
* Verify pipeline "pipeline-unlock-onComplete" is locked and not schedulable - Using api
* Verify pipeline "pipeline-unlock-onComplete" is locked - On dashboard page
* Create a "stopjob" file
* Wait till stage "firstStage" completed
* Verify stage "firstStage" is "Passed"
* Verify pipeline "pipeline-unlock-onComplete" is not locked and is schedulable - Using api
* Verify pipeline "pipeline-unlock-onComplete" is not locked - On dashboard page

* Trigger stage "secondStage" run "1"
* Verify pipeline "pipeline-unlock-onComplete" is locked and not schedulable - Using api
* Verify pipeline "pipeline-unlock-onComplete" is locked - On dashboard page
* Create a "failjob" file
* Wait till stage "secondStage" completed
* Verify stage "secondStage" is "Failed"
* Verify pipeline "pipeline-unlock-onComplete" is not locked and is schedulable - Using api
* Verify pipeline "pipeline-unlock-onComplete" is not locked - On dashboard page

* Trigger stage "lastStage" run "1"
* Verify pipeline "pipeline-unlock-onComplete" is locked and not schedulable - Using api
* Verify pipeline "pipeline-unlock-onComplete" is locked - On dashboard page
* Cancel stage "lastStage" of pipeline "pipeline-unlock-onComplete"
* Wait till stage "lastStage" completed
* Verify stage "lastStage" is "Cancelled"
* Verify pipeline "pipeline-unlock-onComplete" is not locked and is schedulable - Using api
* Verify pipeline "pipeline-unlock-onComplete" is not locked - On dashboard page

teardown
_______________
* Capture go state "PipelineLockingBehavior" - teardown
* With "1" live agents - teardown
