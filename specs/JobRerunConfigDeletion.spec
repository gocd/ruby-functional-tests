
JobRerunConfigDeletion
======================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "pipeline-with-3-jobs" - setup
* Capture go state "JobRerunConfigDeletion" - setup

JobRerunConfigDeletion
----------------------

tags: job-rerun

* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-3-jobs" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Building" on pipeline with label "1" - On Swift Dashboard page
* On stage details page "jobs" tab for "pipeline-with-3-jobs" label "1" stage name "defaultStage" counter "1"
* Cancel "defaultStage" - On Stage Detail Page

* Remove job "second" from stage "defaultStage" in pipeline "pipeline-with-3-jobs"

* On stage details page "jobs" tab for "pipeline-with-3-jobs" label "1" stage name "defaultStage" counter "1"

* Rerun "second" jobs
* Verify rerun button is enabled
* Verify rerun failed with cause "Cannot rerun job 'second'. Configuration for job doesn't exist."
* Verify looking at "defaultStage" having counter "1"


Teardown of contexts
____________________
* Capture go state "JobRerunConfigDeletion" - teardown



