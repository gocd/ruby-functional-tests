
PipelineApprovalConfigurations
==============================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "edit-pipeline, autoFirst" - setup
* Capture go state "PipelineApprovalConfigurations" - setup

PipelineApprovalConfigurations
------------------------------

tags: Pipeline Approval Configurations

Automatic pipeline scheduling for general pipelines
* On Swift Dashboard Page
* Looking at pipeline "edit-pipeline" - On Swift Dashboard page
* Edit pipeline "edit-pipeline"
* Enable pipeline config spa
* Set auto scheduling
* Save Changes
* On Stage settings page of pipeline "edit-pipeline" stage "defaultStage"

* Mark stage manual - On Stage settings page
* Save Changes

* On Swift Dashboard Page
* Looking at pipeline "autoFirst" - On Swift Dashboard page
* Edit pipeline "autoFirst"
* Enable pipeline config spa
* Verify auto scheduling is selected
* Verify auto scheduling checkbox is disabled

* On Admin Templates page

* Edit template "autoStagePipelineTemplate"
* Enable pipeline config spa
* Open "Stages" tab - On Pipeline settings page
* Open stage "defaultStage"
* Verify auto approval type is selected
* Mark stage manual - On Stage settings page
* Save Changes
* On Swift Dashboard Page
* Looking at pipeline "autoFirst" - On Swift Dashboard page
* Edit pipeline "autoFirst"
* Enable pipeline config spa
* Verify auto scheduling is not selected
* Verify auto scheduling checkbox is disabled

Teardown of contexts
____________________
* Capture go state "PipelineApprovalConfigurations" - teardown
