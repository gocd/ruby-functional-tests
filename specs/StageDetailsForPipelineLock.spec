StageDetailsForPipelineLock
===========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "pipeline-with-lock-all-manual" - setup
* With "1" live agents - setup
* Capture go state "StageDetailsForPipelineLock" - setup

StageDetailsForPipelineLock
---------------------------

tags: stage-details, pipeline_locking_behavior

* Looking at pipeline "pipeline-with-lock-all-manual" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "firstStage" is "Building" - On Swift Dashboard page
* Create a "stopjob" file and validate pipeline completed
* Verify stage "firstStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* On stage details page "materials" tab for "pipeline-with-lock-all-manual" label "1" stage name "firstStage" counter "1"

* Verify the lock status is "Click to unlock" - On Stage Details page
* Unlock the pipeline - On Stage Details page
* Verify the lock status is "UNLOCKED" - On Stage Details page

* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-lock-all-manual" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "firstStage" is "Building" - On Swift Dashboard page
* Create a "stopjob" file and validate pipeline completed
* Verify stage "firstStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page
* On stage details page "materials" tab for "pipeline-with-lock-all-manual" label "1" stage name "firstStage" counter "1"

* Verify the lock status is "Locked by 2" - On Stage Details page

* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-lock-all-manual" - On Swift Dashboard page
* On stage details page "materials" tab for "pipeline-with-lock-all-manual" label "2" stage name "firstStage" counter "1"

* Rerun stage "firstStage" - On Stage Details page
* Verify the lock status is "LOCKED" - On Stage Details page





Teardown of contexts
____________________
* With "1" live agents - teardown
* Capture go state "StageDetailsForPipelineLock" - teardown
