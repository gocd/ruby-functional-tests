ComparePipelinesWithTriangleDependency
======================================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "fourth, fifth, another-sixth-manual" - setup
* With "1" live agents - setup
* Capture go state "ComparePipelinesWithTriangleDependency" - setup

ComparePipelinesWithTriangleDependency
--------------------------------------

tags:compare_pipeline
* On Swift Dashboard Page
* With material "git-first" of type "git" for pipeline "fourth"
* Checkin file "git-new-file" as user "go" with message "Added git-new-file" - On Swift Dashboard page
* Remember current version as "git-new"

* On Swift Dashboard Page
* Looking at pipeline "fourth" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "2" - On Swift Dashboard page
* Looking at pipeline "fifth" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "another-sixth-manual" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page
* On Pipeline Compare page from "1" build to "1"


* Verify displays revision "$fourth$/2/defaultStage/1" having label "2" under pipeline named "fourth"
* Verify displays revision "$fifth$/1/defaultStage/1" having label "1" under pipeline named "fifth"
* Verify displays revision "git-new" having comment "Added git-new-file" under "Git"



Teardown of contexts
____________________
* Capture go state "ComparePipelinesWithTriangleDependency" - teardown
* With "1" live agents - teardown


