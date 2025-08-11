
EditPipelineGroups
==================

Setup of contexts
* Group admin security configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline1,pipeline2,pipeline4,pipeline5,pipeline-with-group-and-stage-security,pipeline-down" - setup
* Capture go state "EditPipelineGroups" - setup

EditPipelineGroups
------------------

tags:pipeline group

* On Admin pipeline page

* Verify groups "group-name-to-be-changed,group2,groupWithStageSecurity" are visible - on Admin Pipelines tab
* Verify "group-name-to-be-changed" has pipelines "pipeline1,pipeline4"
* Verify "group2" has pipelines "pipeline2,pipeline-down"
* Verify "group4" has pipelines "pipeline5"
* Verify "groupWithStageSecurity" has pipelines "pipeline-with-group-and-stage-security"
* Verify can delete "pipeline4,pipeline5,pipeline-with-group-and-stage-security,pipeline-down"
 Verify cannot delete "pipeline1,pipeline2"
* Delete "pipeline4"
* Verify "group-name-to-be-changed" does not have pipelines "pipeline4"
* Delete "pipeline5"
* Verify "group4" has message "There are no pipelines defined in this pipeline group."
* Click to create a new pipeline to group "groupWithStageSecurity"
* Enter new pipeline name as "new-pipeline"
* Select material type as "Git"
* Set url "http://git.url" for material "git"
* Set stage name as "defaultStage"
* Set task as "rake wait_for_stopjob_file"
* Set job name as "defaultJob"
* Save pipeline "new-pipeline" successfully

* On Admin pipeline page

Verify Edit button
* Verify "groupWithStageSecurity" has pipelines "new-pipeline"
* Verify that the edit button for pipeline "pipeline1" is a link for edit pipeline

* Logout and login as "group1Admin"

* On Admin pipeline page


* Verify groups "group-name-to-be-changed" are visible - on Admin Pipelines tab
* Verify groups "group2,groupWithStageSecurity" are not visible - on Admin Pipelines tab
 Verify that move button is not present for "pipeline1"


Move pipeline  from one group to another

* Logout and login as "admin"

* On Admin pipeline page

* Verify that "pipeline2" cannot be moved to group "group2"
* Move pipeline "pipeline2" from group "group2" to group "group-name-to-be-changed"
* Verify "group2" has pipelines "pipeline-down"
* Verify "group-name-to-be-changed" has pipelines "pipeline1,pipeline2"





Teardown of contexts
____________________
* Capture go state "EditPipelineGroups" - teardown
* Logout - from any page
