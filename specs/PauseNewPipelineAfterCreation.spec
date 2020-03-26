
PauseNewPipelineAfterCreation
=============================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "edit-pipeline" - setup
* Capture go state "PauseNewPipelineAfterCreation" - setup


PauseNewPipelineAfterCreation
-----------------------------

tags: pipeline,pause_pipeline

* Start add new pipeline in pipeline group "basic"

* Select material type as "Git"
* Set url "http://git.url" for material  "git"
* Open Materials advanced settings
* Set branch as "some_branch" for material "git"

* Enter new pipeline name as "newpipeline"

* Set stage name as "defaultStage"
* Set task as "rake wait_for_stopjob_file"
* Set job name as "defaultJob"
* Save pipeline "newpipeline" successfully

 Verify "Pipeline successfully created." message is displayed
* Verify pipeline "newpipeline" is paused with message "Paused by anonymous"
* Open "Materials" tab - On Pipeline settings page

* Verify pipeline "newpipeline" is paused with message "Paused by anonymous"
* Open "Stages" tab - On Pipeline settings page

* Verify pipeline "newpipeline" is paused with message "Paused by anonymous"
* Open stage "defaultStage"

* Verify pipeline "newpipeline" is paused with message "Paused by anonymous"
* Open "Jobs" tab - On Stage settings page

* Open job "defaultJob"

* Verify pipeline "newpipeline" is paused with message "Paused by anonymous"
* Unpause pipeline - On pipeline edit page

* On Swift Dashboard Page
* Looking at pipeline "newpipeline" - On Swift Dashboard page
* Verify pipeline is unpaused - Using API


Teardown of contexts
____________________
* Capture go state "PauseNewPipelineAfterCreation" - teardown
