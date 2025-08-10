PipelineActivityStageOverview
============

Setup of contexts
* Basic Configuration - setup
* Using pipeline "pipeline-with-3-jobs" - setup
* With "2" live agents - setup
* Capture go state "PipelineActivityStageOverview" - setup

PipelineActivityStageOverview
------------

tags: stage-overview, UI, refresh, PipelineActivityStageOverview

* Looking at pipeline "pipeline-with-3-jobs" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Failing" on pipeline with label "1" - On Swift Dashboard page

* Click on history - On Swift Dashboard page
* Verify pipeline activity page is shown

* Open stage overview for stage "defaultStage" - On Pipeline Activity page

* Verify rerun failed jobs is "disabled"
* Verify rerun selected jobs is "disabled"

Wait for the quick jobs to complete
* Wait for "5" seconds
* On Swift Dashboard Page
* Verify stage "defaultStage" is "Failing" on pipeline with label "1" - On Swift Dashboard page

* Click on history - On Swift Dashboard page
* Open stage overview for stage "defaultStage" - On Pipeline Activity page

* Verify failed job count is "1"
* Verify passed job count is "1"
* Verify building job count is "1"

* Verify "second" job is in "failed" state
* Verify "first" job is in "unknown" state
* Verify "third" job is in "passed" state

* On Swift Dashboard Page
* Create a "stopjob" file and validate pipeline completed
* Verify stage "defaultStage" is "Failed" on pipeline with label "1" - On Swift Dashboard page

* Click on history - On Swift Dashboard page
* Verify pipeline activity page is shown

* Open stage overview for stage "defaultStage" - On Pipeline Activity page

* Verify rerun failed jobs is "enabled"
* Verify rerun selected jobs is "disabled"

* Verify failed job count is "1"
* Verify passed job count is "2"
* Verify building job count is "0"

* Verify "second" job is in "failed" state
* Verify "first" job is in "passed" state
* Verify "third" job is in "passed" state

* Rerun failed jobs

Wait for the re-run to be scheduled
* On Swift Dashboard Page
* Verify stage "defaultStage" is "Building" on pipeline with label "1" - On Swift Dashboard page

* Click on history - On Swift Dashboard page
* Open stage overview for stage "defaultStage" - On Pipeline Activity page
* Verify failed job count is "0"
* Verify passed job count is "2"
* Verify building job count is "1"

* Verify "second" job is in "unknown" state
* Verify "first" job is in "passed" state
* Verify "third" job is in "passed" state

* Cancel stage from stage overview

Wait for the cancel
* On Swift Dashboard Page
* Verify stage "defaultStage" is "Cancelled" on pipeline with label "1" - On Swift Dashboard page

* Click on history - On Swift Dashboard page
* Open stage overview for stage "defaultStage" - On Pipeline Activity page
* Verify rerun selected jobs is "disabled"
* Select "first" job for rerun
* Verify rerun selected jobs is "enabled"

* Rerun selected jobs

Wait for the re-run to be scheduled
* On Swift Dashboard Page
* Verify stage "defaultStage" is "Building" on pipeline with label "1" - On Swift Dashboard page

* Click on history - On Swift Dashboard page
* Open stage overview for stage "defaultStage" - On Pipeline Activity page
* Verify failed job count is "1"
* Verify passed job count is "1"
* Verify building job count is "1"


Teardown of contexts
____________________
* Capture go state "PipelineActivityStageOverview" - teardown
* With "2" live agents - teardown
