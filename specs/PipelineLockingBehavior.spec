PipelineLockingBehavior
=========

PipelineLockingBehavior
-------------------
tags: pipeline_locking_behavior

Setup of contexts
* SmokeConfiguration - setup
* Login as "admin" - setup
* Using pipeline "pipeline-unlock-onComplete" - setup
* With "1" live agents - setup
* Capture go state "PipelineLockingBehavior" - setup

* Looking at pipeline "pipeline-unlock-onComplete"
* Trigger "pipeline-unlock-onComplete"
* Wait till stage "firstStage" completed
* Verify stage "firstStage" is "Passed"
* Verify stage "secondStage" is "Building"
* Verify pipeline "pipeline-unlock-onComplete" is locked and not schedulable - Using api
* Verify pipeline "pipeline-unlock-onComplete" is locked - On dashboard page
* Create a "stopjob" file
* Wait till stage "secondStage" completed
* Verify stage "secondStage" is "Passed"
* Verify pipeline "pipeline-unlock-onComplete" is not locked and is schedulable - Using api
* Verify pipeline "pipeline-unlock-onComplete" is not locked - On dashboard page

teardown
_______________
* Capture go state "PipelineLockingBehavior" - teardown
* With "1" live agents - teardown
