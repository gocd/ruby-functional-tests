
JobRerunRunMultipleInstance
===========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "pipeline-for-job-rerun-run-multiple-instance" - setup
* With "1" live agents - setup
* Capture go state "JobRerunRunOnAllAgents" - setup

JobRerunRunMultipleInstance
---------------------------

tags: job-rerun,run-multiple-instance

* On Job settings page of pipeline "pipeline-for-job-rerun-run-multiple-instance" stage "defaultStage" job "first"
* Open "Job Settings" tab - On Job settings page
* Check run multiple instance with "2"
* Save Job Settings

* On Swift Dashboard Page
* Looking at pipeline "pipeline-for-job-rerun-run-multiple-instance" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* On stage details page "jobs" tab for "pipeline-for-job-rerun-run-multiple-instance" label "1" stage name "defaultStage" counter "1"
* Verify job "first-runInstance-1" has state "Completed" and result "Passed"
* Verify job "first-runInstance-2" has state "Completed" and result "Passed"

* On Job details page of pipeline "pipeline-for-job-rerun-run-multiple-instance" counter "1" stage "defaultStage" counter "1" job "first-runInstance-1"

* Verify console has environment variable "GO_JOB_RUN_COUNT" set to value "2"
* Verify console has environment variable "GO_JOB_RUN_INDEX" set to value "1"
 
* On Job details page of pipeline "pipeline-for-job-rerun-run-multiple-instance" counter "1" stage "defaultStage" counter "1" job "first-runInstance-2"

* Verify console has environment variable "GO_JOB_RUN_COUNT" set to value "2"
* Verify console has environment variable "GO_JOB_RUN_INDEX" set to value "2"

* On stage details page "jobs" tab for "pipeline-for-job-rerun-run-multiple-instance" label "1" stage name "defaultStage" counter "1"

* Rerun "first-runInstance-2" jobs

* On Swift Dashboard Page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* On stage details page "jobs" tab for "pipeline-for-job-rerun-run-multiple-instance" label "1" stage name "defaultStage" counter "2"

* Verify job "first-runInstance-1" has state "Completed" and result "Passed"
* Verify job "first-runInstance-2" has state "Completed" and result "Passed"

* On Job details page of pipeline "pipeline-for-job-rerun-run-multiple-instance" counter "1" stage "defaultStage" counter "2" job "first-runInstance-2"

* Verify console has environment variable "GO_JOB_RUN_COUNT" set to value "2"
* Verify console has environment variable "GO_JOB_RUN_INDEX" set to value "2"

* On Job settings page of pipeline "pipeline-for-job-rerun-run-multiple-instance" stage "defaultStage" job "first"
* Open "Job Settings" tab - On Job settings page
* Set run instance count to "0" for job "first" in pipeline "pipeline-for-job-rerun-run-multiple-instance"
* Save Job Settings

* On stage details page "jobs" tab for "pipeline-for-job-rerun-run-multiple-instance" label "1" stage name "defaultStage" counter "2"
* Rerun "first-runInstance-1" jobs
* Verify rerun failed with cause "Cannot rerun job 'first'. Run configuration for job has been changed to 'simple'."

* On Swift Dashboard Page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page
* On stage details page "jobs" tab for "pipeline-for-job-rerun-run-multiple-instance" label "2" stage name "defaultStage" counter "1"

* Verify job "first" has state "Completed" and result "Passed"

Teardown of contexts
____________________
* Capture go state "JobRerunRunOnAllAgents" - teardown
* With "1" live agents - teardown



