
EditStageAddNewJobFlow
======================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "edit-pipeline" - setup
* Capture go state "EditStageAddNewJobFlow" - setup

EditStageAddNewJobFlow
----------------------

tags: Clicky Admin, 4699, smoke

* On Stage settings page of pipeline "pipeline-ls" stage "defaultStage"
* Add task "More.."
* Save Changes
* Verify error message "Name is a required field" is shown - Already On Job Edit Page
* Verify error message "Command cannot be empty" is shown - Already On Job Edit Page
* Verify error message "Save failed, see errors below" is shown - Already On Job Edit Page
* Set job name as "job_for_rake_target"
* Enter "second-job" for job name
* Enter "windows" for resources
* Enter "ls" as command
* Add job

* Verify that job saved sucessfully - Already on Job listing Page
* Verify job "second-job" with resources as "windows" and run on all as "No"
* Open job "second-job"

* Open job settings
* Enter "windows,win-xp,linux,win7" for resources - Already on Job edit page
* Check run on all
* Click save - Already On Job Edit Page
* Verify that job saved sucessfully

* Open stage "defaultStage" - Using Pipeline Navigation

* Open jobs

Testing autocomplete on Resources

* Open add new job to this stage page

* Enter "third-Job" for job name
* Select as task type "More..."
* Enter "ls" as command
* Enter "win" for resources
* Verify dropdown contains "windows,win-xp,win7"
* Select "windows" from the dropdown
* Add job

* Verify job "second-job" with resources as "windows, win-xp, linux, win7" and run on all as "Yes"
* Verify job "third-Job" with resources as "windows" and run on all as "No"

* Open stage "defaultStage" - Using Pipeline Navigation

* Open jobs

* Delete job "defaultJob"
* Verify "second-job" job is present
* Verify job "defaultJob" is not present




Teardown of contexts
____________________
* Capture go state "EditStageAddNewJobFlow" - teardown
* Using pipeline "edit-pipeline" - teardown
* Basic configuration - teardown


