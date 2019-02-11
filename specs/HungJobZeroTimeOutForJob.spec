

HungJobZeroTimeOutForJob
========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "hung-job-zero-timeout-pipeline" - setup
* With "1" live agents - setup
* Capture go state "HungJobZeroTimeOutForJob" - setup

HungJobZeroTimeOutForJob
------------------------

tags: Clicky Admin

* On Admin page
* Open "Server Configuration" tab

* Set cancel job after "2" minutes
* Save Server Configuration

* On Job settings page of pipeline "hung-job-zero-timeout-pipeline" stage "defaultStage" job "defaultJob"
* Open "Job Settings" tab - On Job settings page
* Select never option
* Save Changes


* On Swift Dashboard Page
* Looking at pipeline "hung-job-zero-timeout-pipeline" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till error message popup appears
* Verify there are "1" warnings
* Verify stage "defaultStage" is "Building" - On Swift Dashboard page
* Wait till "160" seconds for stage "defaultStage" shows status "Passed" - On Swift Dashboard page


Teardown of contexts
____________________
* Capture go state "HungJobZeroTimeOutForJob" - teardown
* With "1" live agents - teardown



