
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

* Add user "user3" - Using user API

* On Admin page
* Edit pipeline group "basic"

* Adding "user3" as a "admin" user for group "basic"

* Looking at pipeline "edit-pipeline" - On Swift Dashboard page
* On Stage settings page of pipeline "edit-pipeline" stage "defaultStage"
* Open "Permissions" tab - On Stage settings page
* Select "Specify locally"
* Set "user3" as user name - On Permission tab
* Save Changes
* Verify that user "user3" is authorized to operate on the stage "defaultStage" of pipeline "edit-pipeline"
* Set "admin" as user name - On Permission tab
* Save Changes
* Verify that user "admin" is authorized to operate on the stage "defaultStage" of pipeline "edit-pipeline"



Teardown of contexts
____________________
* Capture go state "EditStagePermissionsWithPipelineGroupAdmins" - teardown
* Delete users "user3" from DB
* Logout - from any page
