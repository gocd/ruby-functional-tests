NewPipelineGroups
==================

Setup of contexts
* Group admin security configuration - setup
* Login as "admin" - setup
*    Using pipeline "pipeline1,pipeline2,pipeline4,pipeline5,pipeline-with-group-and-stage-security,pipeline-down" - setup
* Add user "user1" - Using user API
* Add user "user2" - Using user API
* Add user "user3" - Using user API
* Capture go state "NewPipelineGroups" - setup

NewPipelineGroups
------------------

tags:pipeline group, new pipeline group

* On pipelines page

* Verify groups "group-name-to-be-changed,group2,groupWithStageSecurity" are visible on new page

Add new pipeline group

* Click on add pipeline group

* Enter pipeline group name "newly-added-group" - create pipeline group

* Click on create new pipeline group - save

* Verify groups "newly-added-group" are visible on new page

Pipeline group edit

* Click on edit pipeline group "group-name-to-be-changed"

* Enter pipeline group name "updated-group" on edit pipeline group modal

* Click on add user permission - add "view" permission for "user1"
* Click on add user permission - add "admin" permission for "user2"

* Click on add role permission - add "view" permission for "user1"
* Click on add role permission - add "operate" permission for "user2"

* Click on save pipeline group

* Verify groups "updated-group" are visible on new page

* Click on edit pipeline group "updated-group"

* Verify user permission "view" for user "user1"
* Verify user permission "view,operate,admin" for user "user2"

* Verify role permission "view" for role "user1"
* Verify role permission "view,operate" for role "user2"

* Close pipeline group edit modal

Pipeline group delete

* Click on delete pipeline group "newly-added-group"

* Click on confirm delete pipeline group

* Verify "newly-added-group" is not visible on new page

Teardown of contexts
____________________
* As user "admin" for teardown
* Capture go state "NewPipelineGroups" - teardown
* Logout - from any page
