PipelineGroupAdminsForNonAdmin
==============================

Setup of contexts
* Group admin security configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline1, pipeline2,pipeline3" - setup
* With "1" live agents - setup
* Capture go state "PipelineGroupAdminsForNonAdmin" - setup

PipelineGroupAdminsForNonAdmin
------------------------------

tags: group_admin

The user "notInAnyRoleA" does not have admin permissions anywhere in config.
He has view permission for group2 and operate permission for group3.

* Logout - from any page

* Login as "notInAnyRoleA"

Pipeline Visibility
* PipelineVisibility 
     |Pipeline Name|Visible?   |Can Operate Using API?|
     |-------------|-----------|----------------------|
     |pipeline1    |false      |false                 |
     |pipeline2    |true       |false                 |
     |pipeline3    |false      |true                  |


* Verify any operation on agents return code "403" - Using Agents Api

Teardown of contexts
____________________
* Capture go state "PipelineGroupAdminsForNonAdmin" - teardown
* With "1" live agents - teardown
* Logout - from any page

