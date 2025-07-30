PipelineDashboardAndPipelineActivitySecurityAtStageLevel
========================================================

Setup of contexts
* Permissions configuration - setup
* Login as "admin" - setup
* Using pipeline "P5, P6,P7" - setup
* With "2" live agents - setup
* Capture go state "PipelineDashboardAndPipelineActivitySecurityAtStageLevel" - setup

PipelineDashboardAndPipelineActivitySecurityAtStageLevel
--------------------------------------------------------

tags: Permissions, long_running, pipeline_dashboard_stage_permissions, pipeline_dashboard_permissions

* Looking at pipeline "P5" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "P6" - On Swift Dashboard page
* Trigger and wait for stage "firstStage" is "Passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "P7" - On Swift Dashboard page
* Trigger and wait for stage "firstStage" is "Passed" with label "1" - On Swift Dashboard page

* Logout - from any page

Pipeline Visibility as "raghu"
* Login as "raghu"
* PipelineVisibility
     |Pipeline Name|visible?|can operate using ui?|can operate using Api?|can pause using ui?|can pause using api?|
     |-------------|--------|---------------------|----------------------|-------------------|--------------------|
     |P5           |true    |true                 |true                  |true               |true                |
     |P6           |true    |true                 |true                  |true               |true                |
     |P7           |true    |false                |false                 |true               |true                |



* verify user has operate permissions on "defaultStage" for pipeline "P5" on Pipeline Activity Page

* verify user has operate permissions on "firstStage" for pipeline "P6" on Pipeline Activity Page
* Verify "secondStage" can be approved on Pipeline Activity Page
* Approve stage "secondStage" on Pipeline Activity Page

* Looking at pipeline "P6" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page

* verify user does not have stage "firstStage" operate permissions for pipleine "P7" on pipeline activity page
* Verify "secondStage" can be approved on Pipeline Activity Page
* Approve stage "secondStage" on Pipeline Activity Page

* Logout - from any page



Behavior of P7 is similar for user 'pavan' and 'raghu', hence not verified
* Login as "pavan"
Pipeline Visibility for "paven"
* PipelineVisibility
     |Pipeline Name|visible?|can operate using ui?|can operate using Api?|can pause using ui?|can pause using api?|
     |-------------|--------|---------------------|----------------------|-------------------|--------------------|
     |P5           |true    |false                |false                 |true               |true                |
     |P6           |true    |true                 |true                  |true               |true                |


* Looking at pipeline "P5" - On Swift Dashboard page
* Click on history - On Swift Dashboard page
* Looking at pipeline with label "1"
* Verify stage "defaultStage" of pipeline cannot be rerun on Pipeline Activity Page
* Pause pipeline on activity page

* Looking at pipeline "P5" - On Swift Dashboard page
* Verify pipeline is paused by "pavan" - On Swift Dashboard page
* Unpause pipeline - On Swift Dashboard page

* verify user has operate permissions on "firstStage" for pipeline "P6" on Pipeline Activity Page
* Looking at pipeline "P6" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Click on history - On Swift Dashboard page
* Looking at pipeline with label "1"
* Verify stage "secondStage" of pipeline cannot be rerun on Pipeline Activity Page

* Looking at pipeline "P6" - On Swift Dashboard page
* Click on history - On Swift Dashboard page

* Looking at pipeline with label "2"
* Verify "secondStage" cannot be approved on Pipeline Activity Page

* Logout - from any page


Pipeline Visibility as "group1view"
* Login as "group1View"
* PipelineVisibility
     |Pipeline Name|visible?|can operate using ui?|can operate using Api?|can pause using ui?|can pause using api?|
     |-------------|--------|---------------------|----------------------|-------------------|--------------------|
     |P5           |true    |true                 |true                  |true               |true                |
     |P6           |true    |true                 |true                  |true               |true                |
     |P7           |true    |true                 |true                  |true               |true                |


* verify user has operate permissions on "defaultStage" for pipeline "P5" on Pipeline Activity Page
* verify user does not have stage "secondStage" operate permissions for pipleine "P6" on pipeline activity page


* Looking at pipeline "P6" - On Swift Dashboard page
* Click on history - On Swift Dashboard page

* Looking at pipeline with label "2"
* Verify "secondStage" cannot be approved on Pipeline Activity Page
* verify user has operate permissions on "firstStage" for pipeline "P7" on Pipeline Activity Page
* Verify stage "secondStage" of pipeline can be rerun

Teardown of contexts
____________________
* Capture go state "PipelineDashboardAndPipelineActivitySecurityAtStageLevel" - teardown
* With "2" live agents - teardown
* Logout - from any page
