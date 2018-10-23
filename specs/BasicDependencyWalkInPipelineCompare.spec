BasicDependencyWalkInPipelineCompare
====================================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "up, down, child-of-down" - setup
* With "1" live agents - setup
* Capture go state "BasicDependencyWalkInPipelineCompare" - setup

BasicDependencyWalkInPipelineCompare
------------------------------------

tags: compare_pipeline, dependency_walk

* On Swift Dashboard Page
* Looking at pipeline "up" - On Swift Dashboard page
* Trigger pipeline and not wait for building - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* Looking at pipeline "down" - On Swift Dashboard page
* Trigger pipeline and not wait for building - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* Looking at pipeline "child-of-down" - On Swift Dashboard page
* Trigger pipeline and not wait for building - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* Looking at pipeline "up" - On Swift Dashboard page
* Checkin file "git-new-file" as user "go" with message "Added git-new-file" - On Swift Dashboard page
* Remember current version as "git-new1"

Verify dependency chaining after scm triggers autoFirst pipeline

* On Swift Dashboard Page
* Looking at pipeline "up" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page

* Looking at pipeline "down" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page

* Looking at pipeline "child-of-down" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page

* Looking at pipeline "up" - On Swift Dashboard page
* Checkin file "git-another-new-file" as user "go" with message "Added git-another-new-file" - On Swift Dashboard page
* Remember current version as "git-new2"

* On Swift Dashboard Page
* Looking at pipeline "up" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "3" - On Swift Dashboard page

* Looking at pipeline "down" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "3" - On Swift Dashboard page

* Looking at pipeline "child-of-down" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "3" - On Swift Dashboard page

* Click pipeline compare link

* Verify displays revision "$up$/3/defaultStage/1" having label "3" under pipeline named "up"
* Verify displays revision "$down$/3/defaultStage/1" having label "3" under pipeline named "down"
* Verify displays revision "git-new2" having comment "Added git-another-new-file" under "Git"
* Search for "2" on to pipeline textbox
* Click on label "2" in the dropdown
* Verify displays revision "$up$/2/defaultStage/1" having label "2" under pipeline named "up"
* Verify displays revision "$down$/2/defaultStage/1" having label "2" under pipeline named "down"
* Verify displays revision "git-new1" having comment "Added git-new-file" under "Git"


Teardown of contexts
____________________
* Capture go state "BasicDependencyWalkInPipelineCompare" - teardown
* With "1" live agents - teardown