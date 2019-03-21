

JobProperties
=============

Setup of contexts
* Basic Configuration - setup
* Using pipeline "basic-pipeline-fast-with-job-properties" - setup
* With "1" live agents - setup
* Capture go state "JobProperties" - setup

JobProperties
-------------

tags: job properties, 2251, 2512, automate

* Looking at pipeline "basic-pipeline-fast-with-job-properties" - On Swift Dashboard page
* With material "materialWithJobProperties" of type "git" for pipeline "basic-pipeline-fast-with-job-properties"
* Commit file "junit-failures/fail-a-pass-b/TEST-cruise.testing.JUnit.xml" to directory "junit-output"

* Trigger pipeline - On Swift Dashboard page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* On Job details page of pipeline "basic-pipeline-fast-with-job-properties" counter "1" stage "defaultStage" counter "1" job "defaultJob"
* Verify console log contains message "Start to create properties"
* Verify console log contains message "Failed to create property illegal.file. File"
* Verify console log contains message "Failed to create property illegal.xpath. Illegal xpath: \"!@\""
* Verify console log contains message "Failed to create property xpath.not.found. Nothing matched xpath \"buhao\" in the file"
* Verify console log contains message "Failed to create property src.is.folder."
* Verify console log contains message "Property suite.time = 2.0 created"

On Properties Tab
* OnPropertiesTab
     |property name          |property_exists?|
     |-----------------------|----------------|
     |cruise_agent           |true            |
     |cruise_job_duration    |true            |
     |cruise_job_id          |true            |
     |cruise_job_result      |true            |
     |cruise_pipeline_counter|true            |
     |cruise_pipeline_label  |true            |
     |cruise_stage_counter   |true            |
     |suite.time             |true            |






Teardown of contexts
____________________
* Capture go state "JobProperties" - teardown
* With "1" live agents - teardown
