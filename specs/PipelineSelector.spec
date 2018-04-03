PipelineSelector
================

tags: Pipeline_Selection

Setup of contexts
* Enable new dashboard toggles
* Basic Configuration - setup
* Using pipeline "basic-pipeline-run-till-file-exists, basic-pipeline-fast, dependency-group-pipeline-1, artifact_md5_verification-pipeline-1, artifact_md5_verification-pipeline-2" - setup
* Capture go state "PipelineSelector" - setup

PipelineSelector
----------------

tags: new_dashboard, no_security, pipeline_selector

* Turn on AutoRefresh - On Swift Dashboard page
* Open pipelines selector - On Swift Dashboard page

Make selections when security is disabled
* Verify show newly created pipelines option status is checked
* Verify groups "basic,dependency-group,artifact_md5_verification" are visible - Already on pipelines selector section
* Deselect all pipelines
* Select group "basic"
* Verify all pipelines in group "basic" are selected
* Select group "artifact_md5_verification"
* Expand group "artifact_md5_verification"
* Deselect pipeline "artifact_md5_verification-pipeline-1"
* Verify "artifact_md5_verification" is deselected
* Apply selections

Verify visiblility after pipeline selection
* Turn on AutoRefresh - On Swift Dashboard page
* Verify group "basic" is visible - On Swift Dashboard page
* Verify pipeline "basic-pipeline-run-till-file-exists" shows up - On Swift Dashboard page
* Verify pipeline "basic-pipeline-fast" shows up - On Swift Dashboard page
* Verify group "artifact_md5_verification" is visible - On Swift Dashboard page
* Verify pipeline "artifact_md5_verification-pipeline-1" do not show up - On Swift Dashboard page
* Verify pipeline "artifact_md5_verification-pipeline-2" shows up - On Swift Dashboard page
* Verify group "dependency-group" is not visible - On Swift Dashboard page

Enable security
* Enable security and add "admin,pavan" as admins
* Load login page
* Login as "admin" - Swift Dashboard

* Turn on AutoRefresh - On Swift Dashboard page
* Open pipelines selector - On Swift Dashboard page
* Verify show newly created pipelines option status is checked
* Set show newly created pipelines option status as "unchecked"
* Deselect all pipelines
* Select group "artifact_md5_verification"
* Select group "dependency-group"
* Apply selections

//create new pipeline in group 'basic'
* On Admin page
* Clone pipeline "basic-pipeline-fast" to "admin-test-basic" in pipeline group "basic"

//create new pipeline in group 'dependency-group'
* On Admin page
* Clone pipeline "basic-pipeline-fast" to "admin-test-dependency" in pipeline group "dependency-group"


* Logout and login as "pavan"

//Verify that user 'pavan' sees all pipelines created when no security was setup + the newly added pipelines by 'admin'
* Turn on AutoRefresh - On Swift Dashboard page
* Verify group "basic" is visible - On Swift Dashboard page
* Verify pipeline "basic-pipeline-run-till-file-exists" shows up - On Swift Dashboard page
* Verify pipeline "admin-test-basic" shows up - On Swift Dashboard page
* Verify pipeline "basic-pipeline-fast" shows up - On Swift Dashboard page
* Verify group "artifact_md5_verification" is visible - On Swift Dashboard page
* Verify pipeline "artifact_md5_verification-pipeline-1" shows up - On Swift Dashboard page
* Verify pipeline "artifact_md5_verification-pipeline-2" shows up - On Swift Dashboard page
* Verify group "dependency-group" is visible - On Swift Dashboard page
* Verify pipeline "dependency-group-pipeline-1" shows up - On Swift Dashboard page
* Verify pipeline "admin-test-dependency" shows up - On Swift Dashboard page
* Open pipelines selector - On Swift Dashboard page

//'pavan' makes selections
* Verify show newly created pipelines option status is checked
* Deselect all pipelines
* Select group "basic"
* Apply selections


//create new pipeline in group 'basic'
* On Admin page
* Clone pipeline "basic-pipeline-fast" to "pavan-test-basic" in pipeline group "basic"

//create new pipeline in group 'dependency-group'
* On Admin page
* Clone pipeline "basic-pipeline-fast" to "pavan-test-dependency" in pipeline group "dependency-group"


//Verify 'admin' sees his own selections
* Logout and login as "admin"

//Verify 'admin' sees his own selections + newly created pipelines by 'admin' + don't see any pipelines created by pavan
* Verify group "artifact_md5_verification" is visible - On Swift Dashboard page
* Verify pipeline "artifact_md5_verification-pipeline-1" shows up - On Swift Dashboard page
* Verify pipeline "artifact_md5_verification-pipeline-2" shows up - On Swift Dashboard page
* Verify group "dependency-group" is visible - On Swift Dashboard page
* Verify pipeline "admin-test-dependency" shows up - On Swift Dashboard page
* Verify pipeline "pavan-test-dependency" do not show up - On Swift Dashboard page
* Verify group "basic" is visible - On Swift Dashboard page
* Verify pipeline "admin-test-basic" shows up - On Swift Dashboard page
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

* On Admin page
* Delete "dependency-group-pipeline-1"
* Move pipeline "artifact_md5_verification-pipeline-1" from group "artifact_md5_verification" to group "basic"

//Verify 'admin' sees his own selections except the deleted pipeline
* Logout and login as "admin"
* Verify group "artifact_md5_verification" is visible - On Swift Dashboard page
* Verify pipeline "artifact_md5_verification-pipeline-2" shows up - On Swift Dashboard page
* Verify group "dependency-group" is visible - On Swift Dashboard page
* Verify pipeline "dependency-group-pipeline-1" do not show up - On Swift Dashboard page
* Verify pipeline "admin-test-dependency" shows up - On Swift Dashboard page
* Verify pipeline "pavan-test-dependency" do not show up - On Swift Dashboard page
* Verify group "basic" is visible - On Swift Dashboard page
* Verify pipeline "artifact_md5_verification-pipeline-1" shows up - On Swift Dashboard page
* Verify pipeline "admin-test-basic" shows up - On Swift Dashboard page
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
* Verify pipeline "artifact_md5_verification-pipeline-1" do not show up - On Swift Dashboard page


* Open pipelines selector - On Swift Dashboard page

//verify that even if 1 pipeline is deselected the group checkbox appears deselected
* Verify "basic" is deselected

Teardown of contexts
____________________
* Capture go state "PipelineSelector" - teardown
* Logout - from any page


