

FanInBehaviourManualAndAutoTriggerForDeepDiamondConfiguration
=============================================================

Setup of contexts
* Fanin Configuration - setup
* Using pipeline "P1,P2,P3,P4" - setup
* With "2" live agents - setup
* Capture go state "FanInManualAndAutoTriggerForDeepDiamondConfiguration" - setup

FanInBehaviourManualAndAutoTriggerForDeepDiamondConfiguration
-------------------------------------------------------------

tags: Deep Diamond, fanin

* On Swift Dashboard Page
* Looking at pipeline "P1" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page


* Looking at pipeline "P2" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page


* Looking at pipeline "P3" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page


* Looking at pipeline "P4" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* On Swift Dashboard Page
* Looking at pipeline "P1" - On Swift Dashboard page
* With material "git-one" of type "git" for pipeline "P1"
* Checkin file "new-file-1" as user "go <go@po.com>" with message "Added new-file 1" - On Swift Dashboard page
* Remember current version as "git-one-c2"


* Looking at pipeline "P3" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "2" - On Swift Dashboard page

* Looking at pipeline "P4" - On Swift Dashboard page
* Verify pipeline does not get triggered

* On Swift Dashboard Page
* Looking at pipeline "P1" - On Swift Dashboard page
* With material "git-two" of type "git" for pipeline "P4"
* Checkin file "new-file-1" as user "go <go@po.com>" with message "Added new-file 1" - On Swift Dashboard page
* Remember current version as "git-two-c2"



* Looking at pipeline "P4" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page

* Open changes section - On Swift Dashboard page
* Looking at material of type "Git" named "git-one"
* Verify material has not changed - On Build Cause popup
* Looking at material of type "Git" named "git-two"
* Verify modification "0" has revision "git-two-c2" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$P2$"
* Verify modification "0" has revision "$P2$/1/defaultStage/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$P3$"
* Verify modification "0" has revision "$P3$/1/defaultStage/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup


* On Swift Dashboard Page
* Looking at pipeline "P1" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "2" - On Swift Dashboard page
* Looking at pipeline "P4" - On Swift Dashboard page
* Verify pipeline does not get triggered
* Looking at pipeline "P2" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "2" - On Swift Dashboard page
* Looking at pipeline "P4" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "3" - On Swift Dashboard page

* Open changes section - On Swift Dashboard page

* Looking at material of type "Git" named "git-one"
* Verify material has changed - On Build Cause popup
* Looking at material of type "Git" named "git-two"
* Verify modification "0" has revision "git-two-c2" - On Build Cause popup
* Verify material has not changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$P2$"
* Verify modification "0" has revision "$P2$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$P3$"
* Verify modification "0" has revision "$P3$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup







Teardown of contexts
____________________
* Capture go state "FanInManualAndAutoTriggerForDeepDiamondConfiguration" - teardown
* With "2" live agents - teardown
