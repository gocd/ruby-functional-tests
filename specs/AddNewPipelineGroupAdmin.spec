

AddNewPipelineGroupAdmin
========================

Setup of contexts
* Group admin security configuration - setup
* Login as "group1Admin" - setup
* Capture go state "AddNewPipelineGroupAdmin" - setup

AddNewPipelineGroupAdmin
------------------------

tags: Clicky Admin

* On Admin page
* Click to create a new pipeline to group "group_with_no_pipelines"

make sure group admins don't see autocomplete for group
* Enter new pipeline name as "some_pipeline_name"
* Select material type as "Git"
* Set url "http://git.url" for material  "git"
* Set branch as "some_branch" for material "git"
* Set stage name as "some_stage"
* Set task as "rake wait_for_stopjob_file"
* Set job name as "some_job"
* Save pipeline "some_pipeline_name" successfully

 Verify "Pipeline successfully created." message is displayed

* On Admin page
* Open "Pipelines" tab

* Click clone button for pipeline "some_pipeline_name"

* Enter pipeline name "cloned-some-pipeline-name"
* Save Changes

* Verify "Cloned successfully." message is displayed
* Verify pipeline "cloned-some-pipeline-name" is paused with message "Paused by group1Admin"

* On Admin page
* Open "Pipelines" tab

* Verify "group_with_no_pipelines" has pipelines "some_pipeline_name, cloned-some-pipeline-name"
* Delete "cloned-some-pipeline-name"
* Verify "group_with_no_pipelines" has pipelines "some_pipeline_name"





Teardown of contexts
____________________
* Capture go state "AddNewPipelineGroupAdmin" - teardown
* Logout - from any page
