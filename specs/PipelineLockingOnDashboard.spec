PipelineLockingOnDashboard
==========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "pipeline-with-lock-all-manual" - setup
* With "1" live agents - setup
* Capture go state "PipelineLockingOnDashboard" - setup

PipelineLockingOnDashboard
--------------------------

tags: pipeline_locking_behavior

* Looking at pipeline "pipeline-with-lock-all-manual" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "firstStage" is "Building" - On Swift Dashboard page
* Verify pipeline is locked - On Swift Dashboard page
* Create a "stopjob" file and validate pipeline completed
* Verify stage "firstStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* Verify pipeline is locked - On Swift Dashboard page

* Unlock the pipeline - On Swift Dashboard Page

* Looking at pipeline "pipeline-with-lock-all-manual" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "firstStage" is "Building" on pipeline with label "2" - On Swift Dashboard page
* Verify pipeline is locked - On Swift Dashboard page
* Create a "stopjob" file and validate pipeline completed
* Verify stage "firstStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page
* Verify pipeline is locked - On Swift Dashboard page

* Unlock the pipeline - On Swift Dashboard Page
* Click on history - On Swift Dashboard page

* Approve stage "secondStage" with label "2"

* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-lock-all-manual" - On Swift Dashboard page
* Verify stage "secondStage" is "Building" on pipeline with label "2" - On Swift Dashboard page
* Verify pipeline is locked - On Swift Dashboard page
* Create a "stopjob" file and validate pipeline completed
* Verify stage "secondStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page




Teardown of contexts
____________________
* With "1" live agents - teardown
* Capture go state "PipelineLockingOnDashboard" - teardown
