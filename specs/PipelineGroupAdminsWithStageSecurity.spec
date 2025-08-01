

PipelineGroupAdminsWithStageSecurity
====================================

Setup of contexts
* Group admin security configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline-with-group-and-stage-security" - setup
* With "1" live agents - setup
* Capture go state "PipelineGroupAdminsWithStageSecurity" - setup

PipelineGroupAdminsWithStageSecurity
------------------------------------

tags: group admin

Stage first has Operate permission enabled only for user operate. User pavan is the pipeline Group Admin. He does not have operate permission on the stage defined explicitly.
He should still be able to operate on the stage.

* Logout - from any page

* Login as "pavan"

* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-group-and-stage-security" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "first" is "Building" - On Swift Dashboard page
* Create a "stopjob" file and validate pipeline completed


* Verify stage "first" is "passed" on pipeline with label "1" - On Swift Dashboard page
* On stage details page "overview" tab for "pipeline-with-group-and-stage-security" label "1" stage name "first" counter "1"

* Rerun stage "first" - On Stage Details page
* Verify stage "first" has action "cancel"

* On Swift Dashboard Page
* Create a "stopjob" file
* Verify stage "first" is "passed" on pipeline with label "1" - On Swift Dashboard page


* Logout - from any page

* Login as "operate"

For pipeline "pipeline-with-group-and-stage-security" - Using pipeline api
* Schedule should return code "202"




Teardown of contexts
____________________
* Logout - from any page
* With "1" live agents - teardown
* Capture go state "PipelineGroupAdminsWithStageSecurity" - teardown
