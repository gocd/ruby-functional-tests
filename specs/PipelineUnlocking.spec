

PipelineUnlocking
=================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline-2-manual-stages-that-run-till-file-exists, pipeline-with-failing-stage" - setup
* With "1" live agents - setup
* Capture go state "PipelineUnlocking" - setup

PipelineUnlocking
-----------------

tags: 3378, 3411, feeds, restful api, shine, 3426, automate, failing, api

Verify can unlock a pipeline that's waiting for a manual stage to be triggered
* On Swift Dashboard Page
* Looking at pipeline "pipeline-2-manual-stages-that-run-till-file-exists" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page

* Create a "stopjob" file
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* Verify can unlock "pipeline-2-manual-stages-that-run-till-file-exists"

Verify can unlock a pipeline that's been cancelled
* Delete stopjob file
* On Swift Dashboard Page
* Looking at pipeline "pipeline-2-manual-stages-that-run-till-file-exists" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Building" on pipeline with label "2" - On Swift Dashboard page



Verify stage "defaultStage" is "Building" on pipeline with label "2" - On Swift Dashboard page

* On stage details page "overview" tab for "pipeline-2-manual-stages-that-run-till-file-exists" label "2" stage name "defaultStage" counter "1"
* Cancel "defaultStage" - On Stage Detail Page
* On Swift Dashboard Page
* Wait till "50" seconds for stage "defaultStage" shows status "Cancelled" - On Swift Dashboard page

* Verify can unlock "pipeline-2-manual-stages-that-run-till-file-exists"

* On stage details page "overview" tab for "pipeline-2-manual-stages-that-run-till-file-exists" label "2" stage name "defaultStage" counter "1"
* Rerun stage "defaultStage" - On Stage Details page


* On Swift Dashboard Page
* Create a "stopjob" file
* On stage details page "overview" tab for "pipeline-2-manual-stages-that-run-till-file-exists" label "2" stage name "defaultStage" counter "2"
* Verify stage bar is displaying run "2 of 2"
* On Swift Dashboard Page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Delete stopjob file
* On stage details page "overview" tab for "pipeline-2-manual-stages-that-run-till-file-exists" label "2" stage name "defaultStage" counter "2"
* Trigger stage "secondStage" - On stage details page
* On Swift Dashboard Page
* Verify stage "secondStage" is "Building" on pipeline with label "2" - On Swift Dashboard page
* Create a "stopjob" file
* Wait till pipeline completed - On Swift Dashboard page
* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-failing-stage" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Failed" on pipeline with label "1" - On Swift Dashboard page

* Verify can unlock "pipeline-with-failing-stage"





Teardown of contexts
____________________
* Logout - from any page
* With "1" live agents - teardown
* Capture go state "PipelineUnlocking" - teardown
