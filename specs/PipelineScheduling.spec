
PipelineScheduling
==================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline-2-manual-stages-that-run-till-file-exists" - setup
* With "1" live agents - setup
* Capture go state "PipelineScheduling" - setup

PipelineScheduling
------------------

tags: scheduling
* On Swift Dashboard Page
* Looking at pipeline "pipeline-2-manual-stages-that-run-till-file-exists" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
 Verify stage "defaultStage" is "Building" - On Swift Dashboard page
* On stage details page "overview" tab for "pipeline-2-manual-stages-that-run-till-file-exists" label "1" stage name "defaultStage" counter "1"

* Verify stage "defaultStage" has action "Cancel"
* Verify stage "defaultStage" does not have action "Rerun"

* Schedule should return code "404"

* Create a "stopjob" file

* On Swift Dashboard Page
* Verify stage "defaultStage" is "passed" on pipeline with label "1" - On Swift Dashboard page
* On stage details page "overview" tab for "pipeline-2-manual-stages-that-run-till-file-exists" label "1" stage name "defaultStage" counter "1"
* Trigger stage "secondStage" - On stage details page


* On Swift Dashboard Page
* On stage details page "overview" tab for "pipeline-2-manual-stages-that-run-till-file-exists" label "1" stage name "secondStage" counter "1"

* Verify stage "secondStage" has action "Cancel"
* Verify stage "secondStage" does not have action "Rerun"


* Schedule should return code "404"






Teardown of contexts
____________________
* Capture go state "PipelineScheduling" - teardown
* With "1" live agents - teardown
* Logout - from any page
