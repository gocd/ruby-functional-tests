
RerunStage
==========

Setup of contexts
* Basic Configuration - setup
* Using pipeline "pipeline-ls, pipeline-with-failing-stage" - setup
* With "1" live agents - setup
* Capture go state "RerunStage" - setup

RerunStage
----------

tags: rerun, job-detail, automate, stage1

* On Swift Dashboard Page
* Looking at pipeline "pipeline-ls" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page   
* On Job details page of pipeline "pipeline-ls" counter "1" stage "defaultStage" counter "1" job "defaultJob"
* Store the job completed time stamp
* On stage details page "overview" tab for "pipeline-ls" label "1" stage name "defaultStage" counter "1"
* Rerun stage "defaultStage" - On Stage Details page
* On Swift Dashboard Page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" and counter "2" - On Swift Dashboard page
* On Job details page of pipeline "pipeline-ls" counter "1" stage "defaultStage" counter "2" job "defaultJob"
* Store the job completed time stamp 
* Verify the job completed time stamp for job "defaultjob" of stage "defaultStage" of pipeline "pipeline-ls" with label "1" is Different for stage counter "1" and stage counter "2"
* Verify console log contains message "Start to prepare"
* Verify console log contains message "Start to build"
* Verify console log contains message "Start to upload"

* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-failing-stage" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "failed" on pipeline with label "1" - On Swift Dashboard page
* On Job details page of pipeline "pipeline-with-failing-stage" counter "1" stage "defaultStage" counter "1" job "defaultJob"
* Store the job completed time stamp
* On stage details page "overview" tab for "pipeline-with-failing-stage" label "1" stage name "defaultStage" counter "1"
* Rerun stage "defaultStage" - On Stage Details page
* On Swift Dashboard Page
* Verify stage "defaultStage" is "failed" on pipeline with label "1" - On Swift Dashboard page
* Verify stage "defaultStage" is "failed" on pipeline with label "1" and counter "2" - On Swift Dashboard page
* On Job details page of pipeline "pipeline-with-failing-stage" counter "1" stage "defaultStage" counter "2" job "defaultJob"
* Verify the job completed time stamp for job "defaultjob" of stage "defaultStage" of pipeline "pipeline-with-failing-stage" with label "1" is Different for stage counter "1" and stage counter "2"
* Verify console log contains message "Start to prepare"
* Verify console log contains message "Start to build"
* Verify console log contains message "Start to upload"


Teardown of contexts
____________________
* Capture go state "RerunStage" - teardown