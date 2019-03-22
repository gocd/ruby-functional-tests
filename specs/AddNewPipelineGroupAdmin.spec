

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
* Click to create a new pipeline to group "groupWithStageSecurity"

make sure group admins don't see autocomplete for group
* Enter new pipeline name as "some_pipeline_name"
* Go next from settings
* Select material type as "Git"
* Set url "http://git.url" for material  "git"
* Set branch as "some_branch"
* Go next from materials
* Set stage name as "some_stage"
* Set job name as "some_job"
* Select task type as "Rake"
* Set task as "rake" "buildFile" name "Rakefile"
* Set task as "rake" "target" name "wait_for_stopjob_file"
* Set task as "rake" "workingDirectory" name "src"
* Save pipeline "some_pipeline_name" successfully

* Verify "Pipeline successfully created." message is displayed
* On Admin page
* Verify "group3" has pipelines "pipeline3"
* Open "Materials" tab - On Pipeline settings page
* Verify material "pipeline_material" is exist with URL "http://git.url"
* On Job settings page of pipeline "some_pipeline_name" stage "some_stage" job "some_job"

* verifyTask
|Order_no|Task Type         |Run If Conditions |Properties                                                               |On Cancel     |
|--------|------------------|------------------|-------------------------------------------------------------------------|--------------|
|1       |Rake              |Passed            |Build File: Rakefile Target: wait_for_stopjob_file Working Directory: src|No            |

* On Admin page
* Open "Pipelines" tab

* Click clone button for pipeline "some_pipeline_name"

* Enter pipeline name "cloned-some-pipeline-name"
* Save Changes

* Verify "Cloned successfully." message is displayed
* Verify pipeline "cloned-some-pipeline-name" is paused with message "Paused by group1Admin"

* On Admin page
* Open "Pipelines" tab

* Verify "group1" has pipelines "some_pipeline_name, cloned-some-pipeline-name"
* Delete "cloned-some-pipeline-name"
* Verify "group1" has pipelines "some_pipeline_name"





Teardown of contexts
____________________
* Capture go state "AddNewPipelineGroupAdmin" - teardown
* Logout - from any page
