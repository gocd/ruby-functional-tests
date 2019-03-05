

PipelineDependencyTriangle
==========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "fourth, fifth, another-sixth" - setup
* With "2" live agents - setup
* Capture go state "PipelineDependencyTriangle" - setup

PipelineDependencyTriangle
--------------------------

tags: dependency pipeline, 3695, 3957, automate, failing, server_restart_needed

Stop server
 Start server with fanin turned off

* Set Fan In turned off
* Restart server 

* On Swift Dashboard Page
* Looking at pipeline "fourth" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "2" - On Swift Dashboard page

* Looking at pipeline "fifth" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page

* Pause pipeline with reason "pausing to test dependency" - On Swift Dashboard page
* Looking at pipeline "another-sixth" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* Open changes section - On Swift Dashboard page

* Looking at material of type "Pipeline" named "$fourth$"
* Verify modification "0" has revision "$fourth$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$fifth$"
* Verify modification "0" has revision "$fifth$/1/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* On Swift Dashboard Page
* Looking at pipeline "fourth" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "3" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "4" - On Swift Dashboard page
* Looking at pipeline "another-sixth" - On Swift Dashboard page
* Verify pipeline does not get triggered


Teardown of contexts
____________________
* Capture go state "PipelineDependencyTriangle" - teardown
* With "2" live agents - teardown
* Set Fan In turned off - teardown

