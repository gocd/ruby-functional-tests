Pipeline_Stage_Job_AgentJobRun_HistoryApis
==========================================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "basic-pipeline-fast,pipeline-run-till-file-exits,pipeline-with-failing-stage" - setup
* With "1" live agents - setup
* Capture go state "Pipeline_Stage_Job_AgentJobRun_HistoryApis" - setup

Pipeline_Stage_Job_AgentJobRun_HistoryApis
------------------------------------------

tags: schedule, trigger, restful api, api


* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Trigger the pipeline "11" times - Using API

verify passed + pagination

* Verify "11" instances of "basic-pipeline-fast" "defaultStage" "defaultJob" "Passed" - Using Pipeline History API
* Verify "11" instance of "basic-pipeline-fast" "defaultStage" "defaultJob" "Passed" - Using Pipeline Instance API

* Verify "11" instances of "basic-pipeline-fast" "defaultStage" "defaultJob" "Passed" - Using Stage Api
* Verify "11" instance of "basic-pipeline-fast" "defaultStage" "defaultJob" "Passed" - Using Stage Api

* Verify "11" instances of "basic-pipeline-fast" "defaultStage" "defaultJob" "Passed" - Using Job Api

* Verify "11" instances of "basic-pipeline-fast" "defaultStage" "defaultJob" "Passed" - Using Agents Api

* Looking at pipeline "pipeline-with-failing-stage" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "failed" on pipeline with label "1" - On Swift Dashboard page

verify failed

* Verify "1" instances of "pipeline-with-failing-stage" "defaultStage" "defaultJob" "Failed" - Using Pipeline History API
* Verify "1" instance of "pipeline-with-failing-stage" "defaultStage" "defaultJob" "Failed" - Using Pipeline Instance API

* Verify "1" instances of "pipeline-with-failing-stage" "defaultStage" "defaultJob" "Failed" - Using Stage Api
* Verify "1" instance of "pipeline-with-failing-stage" "defaultStage" "defaultJob" "Failed" - Using Stage Api

* Verify "1" instances of "pipeline-with-failing-stage" "defaultStage" "defaultJob" "Failed" - Using Job Api
* Verify last job "pipeline-with-failing-stage" "defaultStage" "defaultJob" "Failed" - Using Agents Api

* Looking at pipeline "pipeline-run-till-file-exits" - On Swift Dashboard page
* Trigger pipeline and wait for building - On Swift Dashboard page
* Verify stage "defaultStage" is "building" on pipeline with label "1" - On Swift Dashboard page
* On stage details page "overview" tab for "pipeline-run-till-file-exits" label "1" stage name "defaultStage" counter "1"

verify building

* Verify "1" instances of "pipeline-run-till-file-exits" "defaultStage" "defaultJob" "Unknown" - Using Pipeline History API
* Verify "1" instance of "pipeline-run-till-file-exits" "defaultStage" "defaultJob" "Unknown" - Using Pipeline Instance API

* Verify "1" instances of "pipeline-run-till-file-exits" "defaultStage" "defaultJob" "Unknown" - Using Stage Api
* Verify "1" instance of "pipeline-run-till-file-exits" "defaultStage" "defaultJob" "Unknown" - Using Stage Api

* Verify "1" instances of "pipeline-run-till-file-exits" "defaultStage" "defaultJob" "Unknown" - Using Job Api

Wait for the agent to pick it up
* Wait for "5" seconds
* Verify last job "pipeline-run-till-file-exits" "defaultStage" "defaultJob" "Unknown" - Using Agents Api

Cancel the stage
* Cancel "defaultStage" - On Stage Detail Page
* Verify stage result shows "Cancelled" - On Stage Detail Page

verify cancelled

* Verify "1" instances of "pipeline-run-till-file-exits" "defaultStage" "defaultJob" "Cancelled" - Using Pipeline History API
* Verify "1" instance of "pipeline-run-till-file-exits" "defaultStage" "defaultJob" "Cancelled" - Using Pipeline Instance API

* Verify "1" instances of "pipeline-run-till-file-exits" "defaultStage" "defaultJob" "Cancelled" - Using Stage Api
* Verify "1" instance of "pipeline-run-till-file-exits" "defaultStage" "defaultJob" "Cancelled" - Using Stage Api

* Verify "1" instances of "pipeline-run-till-file-exits" "defaultStage" "defaultJob" "Cancelled" - Using Job Api

* Verify last job "pipeline-run-till-file-exits" "defaultStage" "defaultJob" "Cancelled" - Using Agents Api

Teardown of contexts
____________________
* Capture go state "Pipeline_Stage_Job_AgentJobRun_HistoryApis" - teardown
* With "1" live agents - teardown
* Logout - from any page
