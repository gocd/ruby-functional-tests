
StageDetailsHistoryPagination
=============================

Setup of contexts
* Single Pipeline Configuration - setup
* Using pipeline "basic-pipeline-run-and-cancel" - setup
* Capture go state "StageDetailsHistoryPagination" - setup

StageDetailsHistoryPagination
-----------------------------

tags: stage-details

* On Swift Dashboard Page
* Looking at pipeline "basic-pipeline-run-and-cancel" - On Swift Dashboard page
* Trigger and cancel stage "defaultStage" "21" times
* On stage details page "overview" tab for "basic-pipeline-run-and-cancel" label "21" stage name "defaultStage" counter "1"

* Verify stage history has "21,20,19,18,17,16,15,14,13,12" - on Stage details page.

* Verify pipeline history page "2" is shown - on Stage details page
* click on stage history page of number "2"
* Verify stage history has "11,10,9,8,7,6,5,4,3,2" - on Stage details page.
* Verify pipeline history page "3" is shown - on Stage details page
* click on stage history page of number "3"
* Verify stage history has "1" - on Stage details page.




Teardown of contexts
____________________
* Capture go state "StageDetailsHistoryPagination" - teardown
