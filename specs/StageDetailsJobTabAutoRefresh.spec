

StageDetailsJobTabAutoRefresh
=============================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "pipeline-with-3-jobs" - setup
* With "3" live agents - setup
* Capture go state "StageDetailsJobTabAutoRefresh" - setup

StageDetailsJobTabAutoRefresh
-----------------------------

tags: stage-details

* Looking at pipeline "pipeline-with-3-jobs" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Failing" - On Swift Dashboard page
* On stage details page "jobs" tab for "pipeline-with-3-jobs" label "1" stage name "defaultStage" counter "1"
* Turn on AutoRefresh - On Swift Dashboard page
* Verify job "first" has state "Building" and result "Active"
* Verify job "second" has state "Completed" and result "Failed"
* Verify job "third" has state "Completed" and result "Passed"
* Create a "stopjob" file
* Verify job "first" has state "Completed" and result "Passed"
* Verify job "second" has state "Completed" and result "Failed"
* Verify job "third" has state "Completed" and result "Passed"





Teardown of contexts
____________________
* With "3" live agents - teardown
* Capture go state "StageDetailsJobTabAutoRefresh" - teardown
