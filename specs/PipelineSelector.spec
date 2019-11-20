PipelineSelector
================

tags: Pipeline_Selection

Setup of contexts
* Basic Configuration - setup
* Using pipeline "basic-pipeline-run-till-file-exists, basic-pipeline-fast, dependency-group-pipeline-1, artifact-md5-verification-pipeline-1, artifact_md5_verification-pipeline-2" - setup
* Capture go state "PipelineSelector" - setup

PipelineSelector
----------------
tags: personalization, no_security, pipeline_selector

* On Swift Dashboard Page
* Verify current view is "default"
* Edit current tab

Make selections when security is disabled
* Verify show newly created pipelines option status is checked
* Verify groups "basic,dependency-group,artifact_md5_verification" are visible
* Deselect all pipelines
* Select group "basic"
* Verify all pipelines in group "basic" are selected
* Select group "artifact_md5_verification"
* Expand group "artifact_md5_verification"
* Deselect pipeline "artifact-md5-verification-pipeline-1"
* Verify "artifact_md5_verification" is deselected
* Apply selections

Verify visiblility after pipeline selection
* Turn on AutoRefresh - On Swift Dashboard page
* Verify group "basic" is visible - On Swift Dashboard page
* Verify pipeline "basic-pipeline-run-till-file-exists" shows up - On Swift Dashboard page
* Verify pipeline "basic-pipeline-fast" shows up - On Swift Dashboard page
* Verify group "artifact_md5_verification" is visible - On Swift Dashboard page
* Verify pipeline "artifact-md5-verification-pipeline-1" do not show up - On Swift Dashboard page
* Verify pipeline "artifact_md5_verification-pipeline-2" shows up - On Swift Dashboard page
* Verify group "dependency-group" is not visible - On Swift Dashboard page

Enable security
* Enable security and add "admin,pipelineSelectorAdmin,pavan" as admins
* Load login page

* Login as "pavan" - Swift Dashboard
* Edit current tab
* Check show newly created pipelines
* Apply selections

* Logout and login as "pipelineSelectorAdmin"

* On Swift Dashboard Page
* Verify current view is "default"
* Edit current tab
* Uncheck show newly created pipelines
* Deselect all pipelines
* Select group "artifact_md5_verification"
* Select group "dependency-group"
* Apply selections

//create new pipeline in group 'basic'
* On Admin pipeline page
* Click clone button for pipeline "basic-pipeline-fast"
* Enter pipeline name "admin-test-basic"
* Enter pipeline group name "basic" - Already On Clone Pipeline pop up
* Save Cloning
* Verify pipeline "admin-test-basic" is paused with message "Paused by pipelineSelectorAdmin"

//create new pipeline in group 'dependency-group'
* On Admin pipeline page
* Click clone button for pipeline "basic-pipeline-fast"
* Enter pipeline name "admin-test-dependency"
* Enter pipeline group name "dependency-group" - Already On Clone Pipeline pop up
* Save Cloning
* Verify pipeline "admin-test-dependency" is paused with message "Paused by pipelineSelectorAdmin"

* On Swift Dashboard Page
* Verify pipeline "admin-test-basic" do not show up - On Swift Dashboard page
* Verify pipeline "admin-test-dependency" do not show up - On Swift Dashboard page

* Logout and login as "pavan"

//Verify that user 'pavan' sees all pipelines created when no security was setup + the newly added pipelines by 'admin'
* Verify current view is "default"
* Verify group "basic" is visible - On Swift Dashboard page
* Verify pipeline "basic-pipeline-run-till-file-exists" shows up - On Swift Dashboard page
* Verify pipeline "admin-test-basic" shows up - On Swift Dashboard page
* Verify pipeline "basic-pipeline-fast" shows up - On Swift Dashboard page
* Verify group "artifact_md5_verification" is visible - On Swift Dashboard page
* Verify pipeline "artifact-md5-verification-pipeline-1" shows up - On Swift Dashboard page
* Verify pipeline "artifact_md5_verification-pipeline-2" shows up - On Swift Dashboard page
* Verify group "dependency-group" is visible - On Swift Dashboard page
* Verify pipeline "dependency-group-pipeline-1" shows up - On Swift Dashboard page
* Verify pipeline "admin-test-dependency" shows up - On Swift Dashboard page
* Edit current tab

//'pavan' makes selections
* Verify show newly created pipelines option status is checked
* Deselect all pipelines
* Select group "basic"
* Apply selections


//create new pipeline in group 'basic'
* On Admin pipeline page
* Click clone button for pipeline "basic-pipeline-fast"
* Enter pipeline name "pavan-test-basic"
* Enter pipeline group name "basic" - Already On Clone Pipeline pop up
* Save Cloning
* Verify pipeline "pavan-test-basic" is paused with message "Paused by pavan"

//create new pipeline in group 'dependency-group'
* On Admin pipeline page
* Click clone button for pipeline "basic-pipeline-fast"
* Enter pipeline name "pavan-test-dependency"
* Enter pipeline group name "dependency-group" - Already On Clone Pipeline pop up
* Save Cloning
* Verify pipeline "pavan-test-dependency" is paused with message "Paused by pavan"

* On Swift Dashboard Page
* Verify pipeline "pavan-test-basic" shows up - On Swift Dashboard page
* Verify pipeline "pavan-test-dependency" shows up - On Swift Dashboard page

//Verify 'admin' sees his own selections
* Logout and login as "pipelineSelectorAdmin"

//Verify 'admin' sees his own selections + newly created pipelines by 'admin' + don't see any pipelines created by pavan
* Verify group "artifact_md5_verification" is visible - On Swift Dashboard page
* Verify pipeline "artifact-md5-verification-pipeline-1" shows up - On Swift Dashboard page
* Verify pipeline "artifact_md5_verification-pipeline-2" shows up - On Swift Dashboard page
* Verify group "dependency-group" is visible - On Swift Dashboard page
* Verify pipeline "admin-test-dependency" do not show up - On Swift Dashboard page
* Verify pipeline "pavan-test-dependency" do not show up - On Swift Dashboard page
* Verify pipeline "admin-test-basic" do not show up - On Swift Dashboard page
* Verify pipeline "pavan-test-basic" do not show up - On Swift Dashboard page
* Verify pipeline "basic-pipeline-run-till-file-exists,basic-pipeline-fast" do not show up - On Swift Dashboard page

* Logout and login as "pavan"

//Verify 'pavan' sees his own selections + newly created pipelines by 'admin' and 'pavan'
* Verify group "artifact_md5_verification" is not visible - On Swift Dashboard page
* Verify group "dependency-group" is visible - On Swift Dashboard page
* Verify pipeline "pavan-test-dependency" shows up - On Swift Dashboard page
* Verify pipeline "admin-test-dependency" do not show up - On Swift Dashboard page
* Verify pipeline "dependency-group-pipeline-1" do not show up - On Swift Dashboard page
* Verify group "basic" is visible - On Swift Dashboard page
* Verify pipeline "basic-pipeline-run-till-file-exists" shows up - On Swift Dashboard page
* Verify pipeline "basic-pipeline-fast" shows up - On Swift Dashboard page
* Verify pipeline "pavan-test-basic" shows up - On Swift Dashboard page
* Verify pipeline "admin-test-basic" shows up - On Swift Dashboard page

* On Admin pipeline page
* Delete "dependency-group-pipeline-1"
* Move pipeline "artifact-md5-verification-pipeline-1" from group "artifact_md5_verification" to group "basic"

//Verify 'admin' sees his own selections except the deleted pipeline
* Logout and login as "pipelineSelectorAdmin"
* Verify group "artifact_md5_verification" is visible - On Swift Dashboard page
* Verify pipeline "artifact_md5_verification-pipeline-2" shows up - On Swift Dashboard page
* Verify pipeline "dependency-group-pipeline-1" do not show up - On Swift Dashboard page
* Verify pipeline "admin-test-dependency" do not show up - On Swift Dashboard page
* Verify pipeline "pavan-test-dependency" do not show up - On Swift Dashboard page
* Verify group "basic" is visible - On Swift Dashboard page
* Verify pipeline "artifact-md5-verification-pipeline-1" shows up - On Swift Dashboard page
* Verify pipeline "admin-test-basic" do not show up - On Swift Dashboard page
* Verify pipeline "pavan-test-basic" do not show up - On Swift Dashboard page
* Verify pipeline "basic-pipeline-run-till-file-exists" do not show up - On Swift Dashboard page
* Verify pipeline "basic-pipeline-fast" do not show up - On Swift Dashboard page

//Verify 'pavan' sees his own selections
* Logout and login as "pavan"
* Verify group "artifact_md5_verification" is not visible - On Swift Dashboard page
* Verify group "dependency-group" is visible - On Swift Dashboard page
* Verify pipeline "pavan-test-dependency" shows up - On Swift Dashboard page
* Verify pipeline "admin-test-dependency" do not show up - On Swift Dashboard page
* Verify pipeline "dependency-group-pipeline-1" do not show up - On Swift Dashboard page
* Verify group "basic" is visible - On Swift Dashboard page
* Verify pipeline "basic-pipeline-run-till-file-exists" shows up - On Swift Dashboard page
* Verify pipeline "basic-pipeline-fast" shows up - On Swift Dashboard page
* Verify pipeline "pavan-test-basic" shows up - On Swift Dashboard page
* Verify pipeline "admin-test-basic" shows up - On Swift Dashboard page
* Verify pipeline "artifact-md5-verification-pipeline-1" do not show up - On Swift Dashboard page


* Edit current tab

//verify that even if 1 pipeline is deselected the group checkbox appears deselected
* Verify "basic" is deselected

Teardown of contexts
____________________
* As user "pipelineSelectorAdmin" for teardown
* Capture go state "PipelineSelector" - teardown
* Logout - from any page
