

PipelineGroupAdminsForSuperAdmin
================================

Setup of contexts
* Group admin security configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline1, pipeline2, pipeline3" - setup
* With "1" live agents - setup
* Capture go state "PipelineGroupAdminsForSuperAdmin" - setup

PipelineGroupAdminsForSuperAdmin
--------------------------------

tags: group admin

This scenario tests the system for a Super Admin.

* On Swift Dashboard Page

Pipeline Visibility
* PipelineVisibility
     |Pipeline Name|Visible?   |Can Operate Using API?|
     |-------------|-----------|----------------------|
     |pipeline1    |true       |true                  |
     |pipeline2    |true       |true                  |
     |pipeline3    |true       |true                  |

* On Admin pipeline page

* Verify groups "group-name-to-be-changed,group2,group3" are visible - on Admin Pipelines tab
* Verify "group-name-to-be-changed" has pipelines "pipeline1"
* Verify "group2" has pipelines "pipeline2"
* Verify "group3" has pipelines "pipeline3"

* Verify any operation on agents return code "200" - Using Agents Api


Teardown of contexts
____________________
* Capture go state "PipelineGroupAdminsForSuperAdmin" - teardown
* With "1" live agents - teardown
* Logout - from any page
