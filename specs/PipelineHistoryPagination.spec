
PipelineHistoryPagination
=========================

Setup of contexts
* Single Pipeline Configuration - setup
* Using pipeline "basic-pipeline-run-and-cancel" - setup
* Capture go state "PipelineHistoryPagination" - setup

PipelineHistoryPagination
-------------------------

tags: UI, pagination

* Looking at pipeline "basic-pipeline-run-and-cancel" - On Swift Dashboard page
* Trigger and cancel stage "defaultStage" "23" times
* Verify stage "defaultStage" is with label "23" - On Swift Dashboard page
* Click on history - On Swift Dashboard page

* Verify pipeline history page "1" is shown
* Verify pipeline history page has "23, 22, 21, 20, 19, 18, 17, 16, 15, 14"
* Search for "20" on pipeline history page
* Verify pipeline history page has "20"
* Clear label filter selection field
* Search for "" on pipeline history page
* Verify pipeline history page has "23, 22, 21, 20, 19, 18, 17, 16, 15, 14"

* Navigate to next pipeline history page
* Verify pipeline history page "2" is shown
* Verify pipeline history page has "13, 12, 11, 10, 9, 8, 7, 6, 5, 4"


* Click on page number "3"
* Verify pipeline history page "3" is shown
* Verify pipeline history page has "3,2,1"

* Navigate to previous pipeline history page
* Verify pipeline history page "2" is shown
* Verify pipeline history page has "13, 12, 11, 10, 9, 8, 7, 6, 5, 4"

Teardown of contexts
____________________
* Capture go state "PipelineHistoryPagination" - teardown