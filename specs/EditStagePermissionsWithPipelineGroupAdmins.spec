
EditStagePermissionsWithPipelineGroupAdmins
===========================================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "edit-pipeline" - setup
* Capture go state "EditStagePermissionsWithPipelineGroupAdmins" - setup

EditStagePermissionsWithPipelineGroupAdmins
-------------------------------------------

tags: Clicky Admin

Verify that an admin or a pipeline group admin can be explicitly added as an operate user
Wait for "60" seconds

* Add user "pavan" - Using user API
* Add user "raghu" - Using user API

* On Admin page
* Edit pipeline group "basic"

* Adding "pavan" as a "admin" user for group "basic"

* Looking at pipeline "edit-pipeline" - On Swift Dashboard page
* On Stage settings page of pipeline "edit-pipeline" stage "defaultStage"
* Open "Permissions" tab - On Stage settings page
* Select "Specify locally"
* Set "pavan" as user name - On Permission tab 
* Save Changes
* Verify that user "pavan" is authorized to operate on the stage "defaultStage" of pipeline "edit-pipeline"
* Set "admin" as user name - On Permission tab 
* Save Changes
* Verify that user "admin" is authorized to operate on the stage "defaultStage" of pipeline "edit-pipeline"



Teardown of contexts
____________________
* Capture go state "EditStagePermissionsWithPipelineGroupAdmins" - teardown
* Delete users "pavan,raghu" from DB
* Logout - from any page


