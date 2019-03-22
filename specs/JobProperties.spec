

JobProperties
=============

Setup of contexts
* Basic Configuration - setup
* Using pipeline "basic-pipeline-fast-with-job-properties" - setup
* With "1" live agents - setup
* Capture go state "JobProperties" - setup

JobProperties
-------------

tags: job properties

* Looking at pipeline "basic-pipeline-fast-with-job-properties" - On Swift Dashboard page
* With material "materialWithJobProperties" of type "git" for pipeline "basic-pipeline-fast-with-job-properties"
* Commit file "TEST-cruise.testing.JUnit.xml" to directory "junit-output"

* Trigger pipeline - On Swift Dashboard page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* On Job details page of pipeline "basic-pipeline-fast-with-job-properties" counter "1" stage "defaultStage" counter "1" job "defaultJob"
* Verify console log contains message "Start to create properties"
* Verify console log contains message "Failed to create property illegal.file. File"
* Verify console log contains message "Failed to create property illegal.xpath. Illegal xpath: \"!@\""
* Verify console log contains message "Failed to create property xpath.not.found. Illegal xpath: \"buhao\""
* Verify console log contains message "Failed to create property src.is.folder."

* Open "Properties" tab - On Job details page
* Verify property "cruise_agent" exist
* Verify property "cruise_job_duration" exist
* Verify property "cruise_job_id" exist
* Verify property "cruise_job_result" exist
* Verify property "cruise_pipeline_counter" exist
* Verify property "cruise_pipeline_label " exist







Teardown of contexts
____________________
* Capture go state "JobProperties" - teardown
* With "1" live agents - teardown
