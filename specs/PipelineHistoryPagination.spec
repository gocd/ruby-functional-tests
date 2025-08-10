
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
* Trigger and cancel stage "defaultStage" "21" times
* Verify stage "defaultStage" is with label "21" - On Swift Dashboard page
* Click on history - On Swift Dashboard page

Check basic pagination
* Verify pipeline history page "1" is shown
* Verify pipeline history page has "21, 20, 19, 18, 17, 16, 15, 14, 13, 12"
* Verify pipeline history page doesnt have "11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1"

Check filtering
* Search for "20" on pipeline history page
* Verify pipeline history page has "20"
* Verify pipeline history page doesnt have "21, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1"
* Clear label filter selection field
* Verify pipeline history page has "21, 20, 19, 18, 17, 16, 15, 14, 13, 12"
* Verify pipeline history page doesnt have "11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1"

Check page 2
* Navigate to next pipeline history page
* Verify pipeline history page "2" is shown
* Verify pipeline history page has "11, 10, 9, 8, 7, 6, 5, 4, 3, 2"
* Verify pipeline history page doesnt have "21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 1"

Check page 3
* Click on page number "3"
* Verify pipeline history page "3" is shown
* Verify pipeline history page has "1"
* Verify pipeline history page doesnt have "21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2"

* Navigate to previous pipeline history page
* Verify pipeline history page "2" is shown
* Verify pipeline history page has "11, 10, 9, 8, 7, 6, 5, 4, 3, 2"
* Verify pipeline history page doesnt have "21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 1"

Teardown of contexts
____________________
* Capture go state "PipelineHistoryPagination" - teardown
