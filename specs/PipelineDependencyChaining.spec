

PipelineDependencyChaining
==========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "autoFirst, child-of-autoFirst, grandchild-of-autoFirst, child-of-autoFirst-ignoring-scheduling-for-upstream" - setup
* With "2" live agents - setup
* Capture go state "PipelineDependencyChaining" - setup

PipelineDependencyChaining
--------------------------

tags: dependency pipeline


* On Swift Dashboard Page
* Looking at pipeline "autoFirst" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* Looking at pipeline "child-of-autoFirst" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* Looking at pipeline "child-of-autoFirst-ignoring-scheduling-for-upstream" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* Looking at pipeline "grandchild-of-autoFirst" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page



SCM Trigger

* On Swift Dashboard Page
* Looking at pipeline "autoFirst" - On Swift Dashboard page
* With material "git-first" of type "git" for pipeline "autoFirst"
* Checkin file "git-new-file" as user "go <go@po.com>" with message "Added new-file" - On Swift Dashboard page
* Remember current version as "git-new1"




Verify dependency chaining after scm triggers autoFirst pipeline

* On Swift Dashboard Page
* Looking at pipeline "autoFirst" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page

* Looking at pipeline "child-of-autoFirst" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page

* Open changes section - On Swift Dashboard page

* Looking at material of type "Pipeline" named "$autoFirst$" 
* Verify modification "0" has revision "$autoFirst$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* On Swift Dashboard Page
* Looking at pipeline "grandchild-of-autoFirst" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page

* Open changes section - On Swift Dashboard page

* Looking at material of type "Pipeline" named "$child-of-autoFirst$" 
* Verify modification "0" has revision "$child-of-autoFirst$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* On Swift Dashboard Page
* Looking at pipeline "child-of-autoFirst-ignoring-scheduling-for-upstream" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page


Pipeline ignoring upstream dependency should be triggered with SCM material

* On Swift Dashboard Page
* Looking at pipeline "child-of-autoFirst-ignoring-scheduling-for-upstream" - On Swift Dashboard page
* With material "git-first" of type "git" for pipeline "child-of-autoFirst-ignoring-scheduling-for-upstream"
* Checkin file "git-new-file" as user "go <go@po.com>" with message "Added new-file" - On Swift Dashboard page
* Remember current version as "git-new2"

* Looking at pipeline "child-of-autoFirst-ignoring-scheduling-for-upstream" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page

* Open changes section - On Swift Dashboard page

* Looking at material of type "Pipeline" named "$autoFirst$"
* Verify modification "0" has revision "$autoFirst$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup



Teardown of contexts
____________________
* With "2" live agents - teardown
* Capture go state "PipelineDependencyChaining" - teardown
