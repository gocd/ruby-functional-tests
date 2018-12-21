
JobRerun
========

Setup of contexts
* Basic Configuration - setup
* Using pipeline "pipeline-with-3-jobs" - setup
* With "2" live agents - setup
* Capture go state "JobRerun" - setup

JobRerun
--------

tags: job-rerun

* Looking at pipeline "pipeline-with-3-jobs" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Failed" on pipeline with label "1" - On Swift Dashboard page
* On stage details page "jobs" tab for "pipeline-with-3-jobs" label "1" stage name "defaultStage" counter "1"


* Rerun "first, second" jobs
* Verify rerun button is enabled
* Verify looking at "defaultStage" having counter "2"
* Verify job "third" has state "Completed" and result "Passed"

* On stage details page "jobs" tab for "pipeline-with-3-jobs" label "1" stage name "defaultStage" counter "2"

* Verify rerun button is enabled
* On Job details page of pipeline "pipeline-with-3-jobs" counter "1" stage "defaultStage" counter "2" job "first"

* Verify console has environment variable "GO_RERUN_OF_STAGE_COUNTER" set to value "1"
* Verify console has environment variable "GO_STAGE_COUNTER" set to value "2"
* Verify console log contains pipeline "pipeline-with-3-jobs" with "1/defaultStage/2/first"


* Verify breadcrumb contains stage run "defaultStage / 2"
* Verify displaying job "1"
* Verify historical job "1" is not a copy
* Verify properties tab shows value "2" for property "cruise_stage_counter"

* On Job details page of pipeline "pipeline-with-3-jobs" counter "1" stage "defaultStage" counter "2" job "third"

* Verify console log does not contains message "GO_RERUN_OF_STAGE_COUNTER"
* Verify console has environment variable "GO_STAGE_COUNTER" set to value "1"
* Verify console log contains pipeline "pipeline-with-3-jobs" with "1/defaultStage/1/third"
* Verify breadcrumb contains stage run "defaultStage / 1"
* Verify displaying job "1"
* Verify properties tab shows value "1" for property "cruise_stage_counter"


Teardown of contexts
____________________
* Capture go state "JobRerun" - teardown



