
StageDetails
============

Setup of contexts
* Basic Configuration - setup
* Using pipeline "pipeline-ls,basic-auto-pipeline" - setup
* With "2" live agents - setup
* Capture go state "StageDetails" - setup

StageDetails
------------

tags: stage-details

* Looking at pipeline "pipeline-ls" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* On stage details page "overview" tab for "pipeline-ls" label "1" stage name "defaultStage" counter "1"


* Turn off AutoRefresh - On Swift Dashboard page
* Verify stage bar is displaying run "1 of 1"
* Verify stage bar triggered by shows "anonymous"
* Verify jobs shows "Failed: 0" collapsed
* Verify jobs shows "Passed: 1" open with jobs "defaultJob"
* Verify jobs shows "In Progress: 0" collapsed
* Rerun stage "defaultStage" - On Stage Details page


* On Swift Dashboard Page
* Looking at pipeline "pipeline-ls" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* On stage details page "overview" tab for "pipeline-ls" label "1" stage name "defaultStage" counter "2"

* Turn off AutoRefresh - On Swift Dashboard page
* Click on stage bar run "1 of 2"
* Verify stage bar is displaying run "1 of 2"
* Verify stage history has "1 (run 2), 1"
* Verify selected stage history entry is "1"

* Turn off AutoRefresh - On Swift Dashboard page
* Click on stage bar run "2 of 2"
* Verify stage bar is displaying run "2 of 2"
* Verify stage history has "1 (run 2), 1"
* Verify selected stage history entry is "1 (run 2)"

* Turn off AutoRefresh - On Swift Dashboard page
* Looking at pipeline "pipeline-ls" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "3" - On Swift Dashboard page
* On stage details page "overview" tab for "pipeline-ls" label "3" stage name "defaultStage" counter "1"
 Navigate to stage detail page for "pipeline-ls" "3" "defaultStage" "1" with stage history page size "2"

* Turn off AutoRefresh - On Swift Dashboard page    
* Verify stage history has "3, 2, 1 (run 2), 1"
* Verify stage bar triggered by shows "anonymous"
* Rerun stage "defaultStage" - On Stage Details page
* Cancel "defaultStage" - On Stage Detail Page
* Click on stage bar run "2 of 2"
* Verify stage bar cancelled by shows "anonymous"


* Enable security and add "admin" as admins

* Logout and login as "admin"

* Looking at pipeline "pipeline-ls" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "4" - On Swift Dashboard page
* On stage details page "overview" tab for "pipeline-ls" label "4" stage name "defaultStage" counter "1"

* Turn off AutoRefresh - On Swift Dashboard page
* Verify stage bar triggered by shows "admin"
* Rerun stage "defaultStage" - On Stage Details page
* Cancel "defaultStage" - On Stage Detail Page
* Click on stage bar run "2 of 2"
* Verify stage bar cancelled by shows "admin"

* On Swift Dashboard Page
* Looking at pipeline "basic-auto-pipeline" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* Verify pipeline is triggered by "changes" - On Swift Dashboard page
* On stage details page "overview" tab for "basic-auto-pipeline" label "1" stage name "defaultStage" counter "1"

* Turn off AutoRefresh - On Swift Dashboard page
* Verify stage bar triggered automatically by changes






Teardown of contexts
____________________
* Capture go state "StageDetails" - teardown
* Logout - from any page
* With "2" live agents - teardown



