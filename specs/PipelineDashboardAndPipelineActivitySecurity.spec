PipelineDashboardAndPipelineActivitySecurity
============================================

Setup of contexts
* Permissions configuration - setup
* Login as "admin" - setup
* Using pipeline "P1, P2, P3, P4" - setup
* With "2" live agents - setup
* Capture go state "PipelineDashboardAndPipelineActivitySecurity" - setup

PipelineDashboardAndPipelineActivitySecurity
--------------------------------------------

tags: Permissions, long_running, pipeline_dashboard_pipeline_activity, pipeline_dashboard_permissions

Verify that super-admin has all view and operate permissions

* Looking at pipeline "P1" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "P2" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "P3" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "P4" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page

* Looking at pipeline "P1" - On Swift Dashboard page
* Click on history - On Swift Dashboard page
* Verify pipeline is triggered by "admin" - On History page

* On Swift Dashboard Page

Pipeline Visibility as admin
* PipelineVisibility
     |Pipeline Name|Visible?|Can Operate Using Ui?|Can Pause Using Api?|Can Pause Using Ui?|Can Operate Using API?|
     |-------------|--------|---------------------|--------------------|-------------------|----------------------|
     |P1           |true    |true                 |true                |true               |true                  |
     |P2           |true    |true                 |true                |true               |true                  |
     |P3           |true    |true                 |true                |true               |true                  |
     |P4           |true    |true                 |true                |true               |true                  |


* verify user has operate permissions on "defaultStage" for pipeline "P1" on Pipeline Activity Page

* verify user has operate permissions on "defaultStage" for pipeline "P2" on Pipeline Activity Page

* verify user has operate permissions on "defaultStage" for pipeline "P3" on Pipeline Activity Page

* verify user has operate permissions on "defaultStage" for pipeline "P4" on Pipeline Activity Page

* Looking at pipeline "P1" - On Swift Dashboard page
* Wait for "90" seconds till pipeline completed - On Swift Dashboard page

* Looking at pipeline "P2" - On Swift Dashboard page
* Wait for "90" seconds till pipeline completed - On Swift Dashboard page

* Looking at pipeline "P3" - On Swift Dashboard page
* Wait for "90" seconds till pipeline completed - On Swift Dashboard page

* Looking at pipeline "P4" - On Swift Dashboard page
* Wait for "90" seconds till pipeline completed - On Swift Dashboard page

* Logout - from any page

Pipeline Visibility as raghu
* Login as "raghu"
* PipelineVisibility
     |Pipeline Name|Visible?|Can Operate Using Ui?|Can Pause Using Api?|Can Pause Using Ui?|Can Operate Using API?|
     |-------------|--------|---------------------|--------------------|-------------------|----------------------|
     |P1           |true    |false                |false               |false              |false                 |
     |P2           |true    |true                 |true                |true               |true                  |
     |P3           |true    |true                 |true                |true               |true                  |
     |P4           |false   |false                |true                |false              |true                  |


* verify user does not have operate permissions on "defaultStage" for pipleine "P1" on pipeline activity page
* verify user has operate permissions on "defaultStage" for pipeline "P2" on Pipeline Activity Page
* verify user has operate permissions on "defaultStage" for pipeline "P3" on Pipeline Activity Page

* Looking at pipeline "P2" - On Swift Dashboard page
* Wait for "90" seconds till pipeline completed - On Swift Dashboard page

* Looking at pipeline "P3" - On Swift Dashboard page
* Wait for "90" seconds till pipeline completed - On Swift Dashboard page

* Logout - from any page

Pipeline Visibility as pavan
* Login as "pavan"
* PipelineVisibility
     |Pipeline Name|Visible?|Can Operate Using Ui?|Can Pause Using Api?|Can Pause Using Ui?|Can Operate Using API?|
     |-------------|--------|---------------------|--------------------|-------------------|----------------------|
     |P1           |true    |false                |false               |false              |false                 |
     |P2           |false   |false                |false               |false              |false                 |
     |P3           |true    |true                 |true                |true               |true                  |
     |P4           |false   |false                |false               |false              |false                 |


* verify user does not have operate permissions on "defaultStage" for pipleine "P1" on pipeline activity page
* verify user has operate permissions on "defaultStage" for pipeline "P3" on Pipeline Activity Page

* Looking at pipeline "P3" - On Swift Dashboard page
* Wait for "90" seconds till pipeline completed - On Swift Dashboard page

* Logout - from any page

Pipeline Visibility as group1view
* Login as "group1View"
* PipelineVisibility
     |Pipeline Name|Visible?|Can Operate Using Ui?|Can Pause Using Api?|Can Pause Using Ui?|Can Operate Using API?|
     |-------------|--------|---------------------|--------------------|-------------------|----------------------|
     |P1           |false   |false                |true                |false              |true                  |
     |P2           |true    |true                 |true                |true               |true                  |
     |P3           |true    |false                |true                |true               |false                 |
     |P4           |true    |false                |false               |false              |false                 |


* verify user has operate permissions on "defaultStage" for pipeline "P2" on Pipeline Activity Page
* verify user does not have operate permissions on "defaultStage" for pipleine "P4" on pipeline activity page
* verify user does not have stage "defaultStage" operate permissions for pipleine "P3" on pipeline activity page

Teardown of contexts
____________________
* Capture go state "PipelineDashboardAndPipelineActivitySecurity" - teardown
* With "2" live agents - teardown
* Logout - from any page
