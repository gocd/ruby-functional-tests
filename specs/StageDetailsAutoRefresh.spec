

StageDetailsAutoRefresh
=======================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "basic-pipeline-wait-till-file-exists" - setup
* With "1" live agents - setup
* Capture go state "StageDetailsAutoRefresh" - setup

StageDetailsAutoRefresh
-----------------------

tags: 3609, stage-details, automate, 3667, failing
* On Swift Dashboard Page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Building" - On Swift Dashboard page
* On stage details page "overview" tab for "basic-pipeline-wait-till-file-exists" label "1" stage name "defaultStage" counter "1"


While the stage is running it should be automatically updated

* Verify stage bar is displaying run "1 of 1"
* Verify stage result shows "Building" - On Stage Detail Page
* Verify stage history shows current stage as "Building"

* Verify jobs shows "Failed: 0" collapsed
* Verify jobs shows "Passed: 0" collapsed
* Verify jobs shows "In Progress: 1" open with jobs "defaultJob"
* Verify stage history shows current stage as "Building"
* Verify stage bar triggered by shows "anonymous"
* Verify stage bar triggered at shows a date

After a the stage completes the page should be automatically updated

* On Swift Dashboard Page
* Create a "stopjob" file and validate pipeline completed
* On stage details page "overview" tab for "basic-pipeline-wait-till-file-exists" label "1" stage name "defaultStage" counter "1"
* Verify jobs shows "In Progress: 0" collapsed
* Verify stage result shows "Building" - On Stage Detail Page
* Verify stage bar does not have other runs
* Verify stage result shows "Passed" - On Stage Detail Page
* Verify stage bar duration shows a time

(We have removed auto-refresh from the stage history widget)
 - verify stage history shows current stage as "Passed"

* Rerun stage "defaultStage" - On Stage Details page

Checking that a new re-run of the stage appears


* Wait for stage bar to show other runs
* Click on stage bar run "2 of 2"
* Verify jobs shows "Failed: 0" collapsed

* Create a "failjob" file


verify jobs shows  "In Progress: 0" open
This is a bug. At this point, there is nothing which is running and the job has already failed. So, the In progress must be collapsed. This is the behaviour when you hard refresh the page. But auto refresh does not honour it. This is so that user interactions ar retained. May be we should have an 'auto-hide-reveal' and 'manual-hide-reveal' classes

* On Swift Dashboard Page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* On stage details page "overview" tab for "basic-pipeline-wait-till-file-exists" label "1" stage name "defaultStage" counter "2"
* Verify jobs shows "In Progress: 0" collapsed



Teardown of contexts
____________________
* Capture go state "StageDetailsAutoRefresh" - teardown
* With "1" live agents - teardown


