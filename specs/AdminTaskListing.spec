AdminTaskListing
================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "pipeline-ls" - setup
* Capture go state "AdminTaskListing" - setup

AdminTaskListing
----------------

tags: task, clicky, admin, exec, stage1

* On Job settings page of pipeline "pipeline-ls" stage "defaultStage" job "defaultJob"
* Add task "More..."
* Set More task - Command as "sleep" argument as "5" working directory as "git" runIfConditions as "Passed,Failed" - Already on Task edit popup
* Set on Cancel task "More..." and command "echo" - Already on Task edit popup
* Save Changes

Verify Tasks
* verifyTask
|Order_no|Task Type         |Run If Conditions |Properties                                         |On Cancel     |
|--------|------------------|------------------|---------------------------------------------------|--------------|
|1       |Custom Command    |Passed            |Command: ls                                        |No            |
|2       |Custom Command    |Failed, Passed    |Command: sleep Arguments: 5 Working Directory: git |Custom Command|

* Delete task "1"
* Verify no task with command "Command: ls" exists
* Verify no "exec" task with command  "ls" exists in "defaultJob" under "defaultStage" for piepline "pipeline-ls"


teardown
_______________
* Capture go state "AdminPermissionsNewUsers" - teardown
