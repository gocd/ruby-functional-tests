
FanInWithAllAutoPipelines
=========================

Setup of contexts
* Fanin Configuration - setup
* Using pipeline "grandparent-fast, parent-fast, parent-slow, child-fast" - setup
* With "4" live agents - setup
* Capture go state "FanInWithAllAutoPipelines" - setup

FanInWithAllAutoPipelines
-------------------------

tags: diamond dependency, fanin
* On Swift Dashboard Page
* Looking at pipeline "grandparent-fast" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page

* Looking at pipeline "parent-fast" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page

* Looking at pipeline "parent-slow" - On Swift Dashboard page
* Verify stage "defaultStage" is "Building" on pipeline with label "1" and counter "1" - On Swift Dashboard page

Before parent-slow 1 is finished or child-fast 1 is triggered, checkin a new file
* On Swift Dashboard Page
* Looking at pipeline "grandparent-fast" - On Swift Dashboard page
* With material "git-five" of type "git" for pipeline "grandparent-fast"
* Checkin file "new-file-2" as user "go <go@po.com>" with message "Added new-file 2" - On Swift Dashboard page
* Remember current version as "g2"

* Looking at pipeline "grandparent-fast" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" and counter "1" - On Swift Dashboard page

* Looking at pipeline "parent-fast" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" and counter "1" - On Swift Dashboard page

Before parent-slow 1/2 is finished or child-fast 1/2 is triggered, checkin another new file
* On Swift Dashboard Page
* Looking at pipeline "grandparent-fast" - On Swift Dashboard page
* With material "git-five" of type "git" for pipeline "grandparent-fast"
* Checkin file "new-file-3" as user "go <go@po.com>" with message "Added new-file 3" - On Swift Dashboard page
* Remember current version as "g3"

* Looking at pipeline "grandparent-fast" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "3" and counter "1" - On Swift Dashboard page

* Looking at pipeline "parent-fast" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "3" and counter "1" - On Swift Dashboard page

// Wait for parent-slow to finish both second and third attempts, allowing child-fast to fan-in
* Looking at pipeline "parent-slow" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "3" and counter "1" - On Swift Dashboard page
* Looking at pipeline "child-fast" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "3" and counter "1" - On Swift Dashboard page

* Open changes section - On Swift Dashboard page

* Looking at material of type "Pipeline" named "$grandparent-fast$"
* Verify modification "0" has revision "$grandparent-fast$/3/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$parent-fast$"
* Verify modification "0" has revision "$parent-fast$/3/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$parent-slow$"
* Verify modification "0" has revision "$parent-slow$/3/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Git" named "$git-five$"
* Verify modification "0" has revision "g3" - On Build Cause popup
* Verify material has changed - On Build Cause popup


Teardown of contexts
____________________
* With "4" live agents - teardown
* Capture go state "FanInWithAllAutoPipelines" - teardown
