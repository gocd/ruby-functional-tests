
EditStagePermissionsWithPipelineGroupAdmins
===========================================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "edit-pipeline" - setup
* Capture go state "EditStagePermissionsWithPipelineGroupAdmins" - setup

EditStagePermissionsWithPipelineGroupAdmins
-------------------------------------------

tags: stage_permissions

Verify that an admin or a pipeline group admin can be explicitly added as an operate user

* Add user "user5" - Using user API

* On Admin page
* Edit pipeline group "basic"

* Adding "user5" as a "admin" user
* Save pipeline group
* Looking at pipeline "edit-pipeline" - On Swift Dashboard page
* On Stage settings page of pipeline "edit-pipeline" stage "defaultStage"
* Open "Permissions" tab - On Stage settings page
* Select "Specify locally"
* Add new user permission
* Set "user5" as user name - On Permission tab
* Save Changes
* Verify that user "user5" is authorized to operate on the stage "defaultStage" of pipeline "edit-pipeline"
* Add new user permission
* Set "admin" as user name - On Permission tab
* Save Changes
* Verify that user "admin" is authorized to operate on the stage "defaultStage" of pipeline "edit-pipeline"



Teardown of contexts
____________________
* Capture go state "EditStagePermissionsWithPipelineGroupAdmins" - teardown
* Delete users "user5" from DB
* Logout - from any page
