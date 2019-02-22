
HungJobTermination
==================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "hung-job-pipeline" - setup
* With "1" live agents - setup
* Capture go state "HungJobTermination" - setup

HungJobTermination
------------------

tags: Clicky Admin

* On Job settings page of pipeline "hung-job-pipeline" stage "defaultStage" job "defaultJob"
* Open "Job Settings" tab - On Job settings page
* Override job time out with "1" minutes
* Save Changes

* On Swift Dashboard Page
* Looking at pipeline "hung-job-pipeline" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Building" on pipeline with label "1" - On Swift Dashboard page
* Wait till "140" seconds for stage "defaultStage" shows status "Cancelled" - On Swift Dashboard page
* On Job details page of pipeline "hung-job-pipeline" counter "1" stage "defaultStage" counter "1" job "defaultJob"
* Verify console log contains message "Go cancelled this job as it has not generated any console output for more than 1 minute(s)"
* Verify there are no warnings




Teardown of contexts
____________________
* Capture go state "HungJobTermination" - teardown
* With "1" live agents - teardown

