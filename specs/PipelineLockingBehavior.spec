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
* Create a "stopjob" file
* Wait till stage "secondStage" completed
* Verify stage "secondStage" is "Passed"

teardown
_______________
* Capture go state "PipelineLockingBehavior" - teardown
* With "1" live agents - teardown
