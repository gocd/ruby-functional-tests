

HungJobServerTagTimeOut
=======================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "hung-job-pipeline" - setup
* With "1" live agents - setup
* Capture go state "HungJobServerTagTimeOut" - setup

HungJobServerTagTimeOut
-----------------------

tags: server configuration, HungJobServerTagTimeOut

* On Admin page

* On Server Configuration page

* On Job timeout configuration

* Set cancel jobs after "2" minutes
* Save Server Configuration

* On Swift Dashboard Page
* Looking at pipeline "hung-job-pipeline" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page

Wait for unresponsive job warning caused by cruise.unresponsive.job.warning setting
* Wait till error message popup appears
* Verify there are "1" warnings
* Open error messages popup
* Verify message contains "is not responding"
* Verify error description contains "This job may be hung."

Wait for automtic cancellation
* On Swift Dashboard Page
* Verify stage "defaultStage" is "Building" on pipeline with label "1" - On Swift Dashboard page
* Wait till "90" seconds for stage "defaultStage" shows status "Cancelled" - On Swift Dashboard page
* On Job details page of pipeline "hung-job-pipeline" counter "1" stage "defaultStage" counter "1" job "defaultJob"
* Verify console log contains message "Go cancelled this job as it has not generated any console output for more than 2 minute(s)"
* On Swift Dashboard Page
* Verify there are no error and warnings



Teardown of contexts
____________________
* Capture go state "HungJobServerTagTimeOut" - teardown
* With "1" live agents - teardown
