

EditStagePermissions
====================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline-in-group-with-no-auth" - setup
* Capture go state "EditStagePermissions" - setup

EditStagePermissions
--------------------

tags: Clicky Admin

* Looking at pipeline "pipeline-in-group-with-no-auth" - On Swift Dashboard page
* On Stage settings page of pipeline "pipeline-in-group-with-no-auth" stage "defaultStage"
* Open "Permissions" tab - On Stage settings page
* Verify option  "Inherit from the pipeline group" is selected
* Verify that the message "There is no authorization configured for this stage nor its pipeline group. Only GoCD administrators can operate this stage." shows up - Already On Edit Stage Page
* Verify that the message "All system administrators and pipeline group administrators can operate on this stage (this cannot be overridden)." shows up - Already On Edit Stage Page
* Select "Specify locally"
* Set "admin" as user name - On Permission tab
* Save Changes
* Verify that user "admin" is authorized to operate on the stage "defaultStage" of pipeline "pipeline-in-group-with-no-auth"
* Open "Permissions" tab - On Stage settings page
* Set "admins" as role name - On Permission tab
* Save Changes
* Verify that role "admins" is authorized to operate on the stage "defaultStage" of pipeline "pipeline-in-group-with-no-auth"


Teardown of contexts
____________________
* Capture go state "EditStagePermissions" - teardown
* Logout - from any page
