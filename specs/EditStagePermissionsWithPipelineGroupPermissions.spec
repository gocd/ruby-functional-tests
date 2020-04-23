
EditStagePermissionsWithPipelineGroupPermissions
================================================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "edit-pipeline" - setup
* Capture go state "EditStagePermissionsWithPipelineGroupPermissions" - setup

EditStagePermissionsWithPipelineGroupPermissions
------------------------------------------------

tags: Clicky Admin

* Add user "user3" - Using user API
* Add user "user4" - Using user API

* On Admin page
* Edit pipeline group "basic"
* Click on add user permission - add "view" permission for "user3"
* Click on add user permission - add "operate" permission for "user4"
* Update role permission - set "operate" permission for "operator"
* Click on save pipeline group

* Looking at pipeline "edit-pipeline" - On Swift Dashboard page
* On Stage settings page of pipeline "edit-pipeline" stage "defaultStage"
* Open "Permissions" tab - On Stage settings page
* Verify option  "Inherit from the pipeline group" is selected
* Verify that user "user4" is inheritted
* Verify that role "operator" is inheritted


Make sure that only users who operate permissions (and not view users) on the pipeline group can be added into stage authorization

* Select "Specify locally"
* Verify that user "user4" is already added - On Permission tab
* Verify that role "operator" is already added - On Permission tab
* Save Changes
* Verify that user "user4" is authorized to operate on the stage "defaultStage" of pipeline "edit-pipeline"
* Verify that role "operator" is authorized to operate on the stage "defaultStage" of pipeline "edit-pipeline"


* Set "operatorUser" as user name - On Permission tab
* Save Changes
* Verify that user "operatorUser" is authorized to operate on the stage "defaultStage" of pipeline "edit-pipeline"


* Set "user3" as user name - On Permission tab
* Save Changes
* Verify message "User \"user3\" who is not authorized to operate pipeline group `basic` can not be authorized to approve stage" shows up - On Permission tab

* Open "Permissions" tab - On Stage settings page
* Set "viewer" as role name - On Permission tab
* Save Changes
* Verify message "Role \"viewer\" who is not authorized to operate pipeline group `basic` can not be authorized to approve stage" shows up - On Permission tab



Teardown of contexts
____________________
* Delete users "user3,user4" from DB
* Capture go state "EditStagePermissionsWithPipelineGroupPermissions" - teardown
* Logout - from any page
