

PipelineGroupAdminsForUserWithNoPermission
==========================================

Setup of contexts
* Group admin security configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline1, pipeline2, pipeline3" - setup
* With "1" live agents - setup
* Capture go state "PipelineGroupAdminsForUserWithNoPermission" - setup

PipelineGroupAdminsForUserWithNoPermission
------------------------------------------

tags: group admin

This scenario tests the system for a user "notInAnyRoleC" who has No Permissions on any Group

* Logout - from any page

* Login as "notInAnyRoleC"


Pipeline Visibility
* PipelineVisibility 
     |Pipeline Name|Visible?   |Can Operate Using API?|
     |-------------|-----------|----------------------|
     |pipeline1    |false      |false                 |
     |pipeline2    |false      |false                 |
     |pipeline3    |false      |false                 |

* Verify any operation on agents return code "403" - Using Agents Api

* Verify admin link is disabled




Teardown of contexts
____________________
* Capture go state "PipelineGroupAdminsForUserWithNoPermission" - teardown
* With "1" live agents - teardown
* Logout - from any page


