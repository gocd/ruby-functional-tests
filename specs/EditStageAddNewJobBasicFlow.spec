
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
* Add task "More.." - Already on Add New Job popup
* Save Changes
* Verify error message "Name is a required field" is shown - Already On Job Edit Page
* Verify error message "Command cannot be empty" is shown - Already On Job Edit Page
* Verify error message "Save failed, see errors below" is shown - Already On Job Edit Page
* Set job name as "second-job" - Already on Add New Job popup
* Set resources as "windows" - Already on Add New Job popup
* Set command as "ls" - Already on Add New Job popup
* Save Changes

* Verify job "second-job" with resources as "windows" and run on all as "No"
* Open job "second-job"

* Open "Job Settings" tab - On Job settings page
* Set resources as "windows,win-xp,linux,win7" - Already on Add New Job popup
* set run type as "Run on all agents"
* Save Changes
* Wait for "60" seconds


Teardown of contexts
____________________
* Capture go state "EditStageAddNewJobBasicFlow" - teardown
