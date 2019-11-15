

AddNewPipelineGroupAdmin
========================

Setup of contexts
* Group admin security configuration - setup
* Login as "group1Admin" - setup
* Capture go state "AddNewPipelineGroupAdmin" - setup

AddNewPipelineGroupAdmin
------------------------

tags: Clicky Admin

* On Admin pipeline page
* Click to create a new pipeline to group "group-with-no-pipelines"

make sure group admins don't see autocomplete for group
* Enter new pipeline name as "some-pipeline-name"
* Select material type as "Git"
* Set url "http://git.url" for material  "git"
* Open Materials advanced settings
* Set branch as "some_branch" for material "git"
* Set stage name as "some_stage"
* Set task as "rake wait_for_stopjob_file"
* Set job name as "some_job"
* Save pipeline "some-pipeline-name" successfully

 Verify "Pipeline successfully created." message is displayed

* On Admin pipeline page

* Click clone button for pipeline "some-pipeline-name"

* Enter pipeline name "cloned-some-pipeline-name"
* Enter pipeline group name "group-with-no-pipelines" - Already On Clone Pipeline pop up
* Save Cloning

* Verify pipeline "cloned-some-pipeline-name" is paused with message "Paused by group1Admin"

* On Admin pipeline page

* Verify "group-with-no-pipelines" has pipelines "some-pipeline-name, cloned-some-pipeline-name"
* Delete "cloned-some-pipeline-name"
* Verify "group-with-no-pipelines" has pipelines "some-pipeline-name"





Teardown of contexts
____________________
* Capture go state "AddNewPipelineGroupAdmin" - teardown
* Logout - from any page
