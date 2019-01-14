

EditStagePermissions
====================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "edit-pipeline" - setup
* Capture go state "EditStagePermissions" - setup

EditStagePermissions
--------------------

tags: Clicky Admin

* Looking at pipeline "edit-pipeline" - On Swift Dashboard page
* On Stage settings page of pipeline "edit-pipeline" stage "defaultStage"
* Open "Permissions" tab - On Stage settings page
* Verify option  "Inherit from the pipeline group" is selected
* Verify that the message "There are no operate permissions configured for this stage nor its pipeline group. All Go users can operate on this stage." shows up - Already On Edit Stage Page
* Verify that the message "All system administrators and pipeline group administrators can operate on this stage (this cannot be overridden)." shows up - Already On Edit Stage Page
* Select "Specify locally"
* Set "admin" as user name - On Permission tab 
* Save Changes
* Verify that user "admin" is authorized to operate on the stage "defaultStage" of pipeline "edit-pipeline"
* Open "Permissions" tab - On Stage settings page
* Set "admins" as role name - On Permission tab 
* Save Changes
* Verify that role "admins" is authorized to operate on the stage "defaultStage" of pipeline "edit-pipeline"


Teardown of contexts
____________________
* Capture go state "EditStagePermissions" - teardown
* Logout - from any page


