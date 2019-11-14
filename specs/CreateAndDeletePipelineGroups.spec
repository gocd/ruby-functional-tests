
CreateAndDeletePipelineGroups
=============================

Setup of contexts
* Group admin security configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline1,pipeline2,pipeline4,pipeline-with-group-and-stage-security,pipeline-down" - setup
* Capture go state "CreateAndDeletePipelineGroups" - setup

CreateAndDeletePipelineGroups
-----------------------------

tags: pipeline group

* On Admin page
* Add new pipeline group
* Enter pipeline group name "some_funky_group" - Already On New Pipeline Group Popup
* Save group create

* Verify groups "group-name-to-be-changed,group2,groupWithStageSecurity" are visible - on Admin Pipelines tab
* Verify "group-name-to-be-changed" has pipelines "pipeline1,pipeline4"
* Verify "group2" has pipelines "pipeline2,pipeline-down"
* Verify "groupWithStageSecurity" has pipelines "pipeline-with-group-and-stage-security"
* Verify delete link is disabled for "group-name-to-be-changed"
* Verify delete link is disabled for "group2"
* Verify delete link is disabled for "groupWithStageSecurity"
* Delete pipeline "pipeline-with-group-and-stage-security"
* Delete group "groupWithStageSecurity"
* Verify groups "group-name-to-be-changed,group2" are visible - on Admin Pipelines tab
* Verify groups "groupWithStageSecurity" are not visible - on Admin Pipelines tab


Teardown of contexts
____________________
* Capture go state "CreateAndDeletePipelineGroups" - teardown
* Logout - from any page
