DashboardStageOverviewOlderRuns
============

Setup of contexts

Setup of contexts
* Basic Configuration - setup
* Using pipeline "pipeline-with-3-jobs" - setup
* With "2" live agents - setup
* Capture go state "DashboardStageOverviewOlderRuns" - setup

DashboardStageOverviewOlderRuns
------------

tags: stage-overview, UI, refresh

* Looking at pipeline "pipeline-with-3-jobs" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Failing" on pipeline with label "1" - On Swift Dashboard page

* Open stage overview for stage "defaultStage" - On Swift Dashboard page

* Verify stage overview has header "pipeline-with-3-jobs" "1" "defaultStage" "1"

* Wait for "20" seconds

* Verify failed job count is "1"
* Verify passed job count is "1"
* Verify building job count is "1"

* Verify "second" job is in "failed" state
* Verify "first" job is in "unknown" state
* Verify "third" job is in "passed" state

* On Swift Dashboard Page
* Create a "stopjob" file and validate pipeline completed
* Verify stage "defaultStage" is "Failed" on pipeline with label "1" - On Swift Dashboard page

* Open stage overview for stage "defaultStage" - On Swift Dashboard page

* Verify failed job count is "1"
* Verify passed job count is "2"
* Verify building job count is "0"

* Verify "second" job is in "failed" state
* Verify "first" job is in "passed" state
* Verify "third" job is in "passed" state

* Rerun failed jobs

* Verify stage "defaultStage" is "Building" on pipeline with label "1" - On Swift Dashboard page

* Open stage overview for stage "defaultStage" - On Swift Dashboard page
* Verify failed job count is "0"
* Verify passed job count is "2"
* Verify building job count is "1"

* Verify "second" job is in "unknown" state
* Verify "first" job is in "passed" state
* Verify "third" job is in "passed" state

* On Swift Dashboard Page
* Create a "stopjob" file and validate pipeline completed

* Open stage overview for stage "defaultStage" - On Swift Dashboard page

* Verify stage overview has header "pipeline-with-3-jobs" "1" "defaultStage" "2"

* Select stage counter "1" from stage overview header

* Verify failed job count is "1"
* Verify passed job count is "2"
* Verify building job count is "0"

* Verify "second" job is in "failed" state
* Verify "first" job is in "passed" state
* Verify "third" job is in "passed" state

* Rerun failed jobs

* Verify stage "defaultStage" is "Building" on pipeline with label "1" - On Swift Dashboard page

* Open stage overview for stage "defaultStage" - On Swift Dashboard page
* Verify stage overview has header "pipeline-with-3-jobs" "1" "defaultStage" "3"

* Verify failed job count is "0"
* Verify passed job count is "2"
* Verify building job count is "1"


Teardown of contexts
____________________
* Capture go state "DashboardStageOverviewOlderRuns" - teardown
* With "2" live agents - teardown
