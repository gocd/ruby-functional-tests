

PipelineXml
===========

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "basic-pipeline-fast, admin-pipeline-api" - setup
* With "1" live agents - setup
* Capture go state "PipelineXml" - setup

PipelineXml
-----------

tags:  automate

* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* With material "git" of type "git" for pipeline "basic-pipeline-fast"
* Checkin file "new-file-1" as user "go <go@po.com>" with message "Added new-file 1" - On Swift Dashboard page



* Logout and login as "view"

* Verify pipeline "basic-pipeline-fast" shows up - On Swift Dashboard page
* Verify pipeline "admin-pipeline-api" do not show up - On Swift Dashboard page



* Verify pipeline instance "foo-pipeline" is not found


* Logout and login as "admin"
* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Looking at pipeline "admin-pipeline-api" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page

* Verify shows first instance of "defaultStage" of "admin-pipeline-api"

* Logout and login as "view"

* Verify shows first instance of "defaultStage" of "basic-pipeline-fast"

* Verify loads "basic-pipeline-fast" instance with file "new-file-1"
* Verify unauthorized to load "admin-pipeline-api"
* Verify fails to find "basic-pipeline-fast" with bad id





Teardown of contexts
____________________
* Logout - from any page
* With "1" live agents - teardown
* Capture go state "PipelineXml" - teardown
