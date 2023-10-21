ApiPausePipeline
================

Setup of contexts
* Permissions configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline1" - setup
* Capture go state "ApiPausePipeline" - setup

ApiPausePipeline
----------------

tags: api, pause_pipeline

Pipeline Groups - group 1
						  group 2
Role: group1AdminRole
Group Admins: group1Admin
Group Users: group1View
Admins: admin

* Attempt to pause pipeline "pipeline1" with cause "gauge testing it" and should return with http status "200"

* Looking at pipeline "pipeline1" - On Swift Dashboard page
* Verify pipeline is paused with reason "gauge testing it" by "admin" - Using API

* Attempt to unpause pipeline "pipeline1" and should return with http status "200"

* Looking at pipeline "pipeline1" - On Swift Dashboard page
* Verify pipeline is unpaused - Using API

* Attempt to pause pipeline "pipeline1" with cause "gauge testing it - second pause to test with view only user" and should return with http status "200"

* Logout - from any page

* Login as "group1View"

* Attempt to pause pipeline "pipeline1" with cause "gauge testing it - user has view only" and should return with http status "403"
* Attempt to unpause pipeline "pipeline1" and should return with http status "403"

Non existent pipeline steps

* Attempt to pause pipeline "non-existent-pipeline" with cause "gauge testing it" and should return with http status "404"
* Attempt to unpause pipeline "non-existent-pipeline" and should return with http status "404"

* Logout - from any page


Teardown of contexts
____________________
* As user "admin" for teardown
* Capture go state "ApiPausePipeline" - teardown
* Logout - from any page


