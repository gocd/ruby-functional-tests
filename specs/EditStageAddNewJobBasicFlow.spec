
EditStageAddNewJobBasicFlow
======================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "edit-pipeline" - setup
* Capture go state "EditStageAddNewJobBasicFlow" - setup

EditStageAddNewJobBasicFlow
----------------------

tags: smoke, run-on-docker

* On Stage settings page of pipeline "edit-pipeline" stage "defaultStage"
* Open "Jobs" tab - On Stage settings page
* Add new Job
* Add task "Custom Command" - Already on Add New Job popup
* Save job changes
* Verify error message "Job-Name:Name must be present." is shown - Already On Job Edit Page
* Verify error message "Command:Command must be present." is shown - Already On Job Edit Page
* Set job name as "second-job" - Already on Add New Job popup
* set job resources as "windows"
* Set command as "ls" - Already on Add New Job popup
* Save job changes

* Verify job "second-job" with resources as "windows" and run on all as "No"
* Open job "second-job"

* Open "Job Settings" tab - On Job settings page
* set job resources as "windows,win-xp,linux,win7"
* set run type as "Run on all agents"
* Save Changes

Teardown of contexts
____________________
* Capture go state "EditStageAddNewJobBasicFlow" - teardown
