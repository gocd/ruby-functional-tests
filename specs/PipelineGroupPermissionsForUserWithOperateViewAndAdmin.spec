
PipelineGroupPermissionsForUserWithOperateViewAndAdmin
======================================================

Setup of contexts
* Group admin security configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline1, pipeline2, pipeline3" - setup
* With "1" live agents - setup
* Capture go state "PipelineGroupPermissionsForUserWithOperateViewAndAdmin" - setup

PipelineGroupPermissionsForUserWithOperateViewAndAdmin
------------------------------------------------------

tags: 4138, group admin


This scenario tests the system when an user (group1Admin) is a Pipeline Group Admin for group 1  and an Operate only user for group 2 and is View only user for group 3.
In this case, the user should have all group admin permissions on group 1 , should only be able to operate pipelines in group 2 and should only be able to view pipelines in group 3.


* Logout - from any page

* Login as "group1Admin"

Pipeline Visibility
* PipelineVisibility

     |Pipeline Name|Visible?   |Can Operate Using API?|
     |-------------|-----------|----------------------|
     |pipeline1    |true       |true                  |
     |pipeline2    |false      |true                  |
     |pipeline3    |true       |false                 |


* On Admin pipeline page


* Verify groups "group2" are not visible - on Admin Pipelines tab
* Verify groups "group-name-to-be-changed" are visible - on Admin Pipelines tab
* Verify "group-name-to-be-changed" has pipelines "pipeline1"

* On Swift Dashboard Page
* Looking at pipeline "pipeline1" - On Swift Dashboard page
* Edit pipeline "pipeline1"

* Enter "crap-${COUNT}-label" for label template
* Save Changes


* Verify any operation on agents return code "403" - Using Agents Api





Teardown of contexts
____________________
* Capture go state "PipelineGroupPermissionsForUserWithOperateViewAndAdmin" - teardown
* With "1" live agents - teardown
* Logout - from any page
