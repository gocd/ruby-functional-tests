

HungJobWarning
==============

Setup of contexts
* Basic Configuration - setup
* Using pipeline "hung-job-pipeline" - setup
* With "1" live agents - setup
* Capture go state "HungJobWarning" - setup

HungJobWarning
--------------

tags: Clicky Admin

* On Swift Dashboard Page
* Looking at pipeline "hung-job-pipeline" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till error message popup appears
* Verify there are "1" warnings
* Open error messages popup

* Verify message contains "is not responding"
* Verify error description contains "This job may be hung."

* Verify stage "defaultStage" is "building" on pipeline with label "1" - On Swift Dashboard page
* On stage details page "jobs" tab for "hung-job-pipeline" label "1" stage name "defaultStage" counter "1"
* Cancel stage "defaultStage" counter "1" of pipeline "hung-job-pipeline" instance "1"
* Verify job "defaultJob" has state "Completed" and result "Cancelled"




Teardown of contexts
____________________
* With "1" live agents - teardown
* Capture go state "HungJobWarning" - teardown
