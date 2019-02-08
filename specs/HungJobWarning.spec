

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
* Wait till pipeline completed - On Swift Dashboard page
* Wait till error message popup appears
* Verify there are "1" warnings
* Open error messages popup

* Verify message contains "is not responding"
* Verify error description contains "This job may be hung."

* Verify stage "defaultStage" is "building" on pipeline with label "1" - On Swift Dashboard page
* On Job details page of pipeline "hung-job-pipeline" counter "1" stage "defaultStage" counter "1" job "defaultJob"

* Verify job "defaultJob" has state "Completed" and result "Cancelled"




Teardown of contexts
____________________
* Capture go state "HungJobWarning" - teardown
* With "1" live agents - teardown

