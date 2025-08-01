

DependencyWalkInPipelineCompareWithSameScm
==========================================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "first,child-of-first,grandchild-of-first" - setup
* With "1" live agents - setup
* Capture go state "DependencyWalkInPipelineCompareWithSameScm" - setup

DependencyWalkInPipelineCompareWithSameScm
------------------------------------------

tags:compare_pipeline, dependency_walk


* On Swift Dashboard Page
* Looking at pipeline "first" - On Swift Dashboard page
* With material "git-first" of type "git" for pipeline "first"
* Checkin file "git-new-file" as user "go <go@po.com>" with message "Added git-new-file" - On Swift Dashboard page
* Remember current version as "git-new1"

* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* Looking at pipeline "child-of-first" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* Looking at pipeline "grandchild-of-first" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* On Swift Dashboard Page
* Looking at pipeline "first" - On Swift Dashboard page
* With material "git-first" of type "git" for pipeline "first"
* Checkin file "git-another-new-file" as user "go <go@po.com>" with message "Added git-another-new-file" - On Swift Dashboard page
* Remember current version as "git-new2"

* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page
* Looking at pipeline "child-of-first" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page
* Looking at pipeline "grandchild-of-first" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page


* On Pipeline Compare page from "1" build to "2"

* Verify displays revision "$first$/2/defaultStage/1" having label "2" under pipeline named "first"
* Verify displays revision "$child-of-first$/2/defaultStage/1" having label "2" under pipeline named "child-of-first"
* Verify displays revision "git-new2" having comment "Added git-another-new-file" under "Git"

* On Pipeline Compare page from "1" build to "1"

* Verify displays revision "$first$/1/defaultStage/1" having label "1" under pipeline named "first"
* Verify displays revision "$child-of-first$/1/defaultStage/1" having label "1" under pipeline named "child-of-first"
* Verify displays revision "git-new1" having comment "Added git-new-file" under "Git" 


Teardown of contexts
____________________
* With "1" live agents - teardown
* Capture go state "DependencyWalkInPipelineCompareWithSameScm" - teardown

