

FanInOffBehavior
================

Setup of contexts
* Fanin Configuration - setup
* Using pipeline "C1, C2, C3, C4-auto-new, C5" - setup
* With "2" live agents - setup
* Capture go state "FanInOffBehavior" - setup

FanInOffBehavior
----------------

tags: diamond dependency, fanin

* On Swift Dashboard Page
* Looking at pipeline "C1" - On Swift Dashboard page
* With material "git-one" of type "git" for pipeline "C1"
* Checkin file "new-file-2" as user "go <go@po.com>" with message "Added new-file 2" - On Swift Dashboard page
* Remember current version as "git-one-g2"

* With material "git-two" of type "git" for pipeline "C1"
* Checkin file "new-file-2" as user "go <go@po.com>" with message "Added new-file 2" - On Swift Dashboard page
* Remember current version as "git-two-g2"

* On Swift Dashboard Page
* Looking at pipeline "C1" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "C2" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "C5" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "C3" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page

* Looking at pipeline "C4-auto-new" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page

* Set Fan In turned off
* Restart server 

* Looking at pipeline "C1" - On Swift Dashboard page
* With material "git-two" of type "git" for pipeline "C1"
* Checkin file "new-file-3" as user "go <go@po.com>" with message "Added new-file 3" - On Swift Dashboard page
* Remember current version as "git-two-g3"

* Looking at pipeline "C5" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "2" - On Swift Dashboard page

* Looking at pipeline "C4-auto-new" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" and counter "1" - On Swift Dashboard page

* Open changes section - On Swift Dashboard page
* Looking at material of type "Pipeline" named "$C1$"
* Verify modification "0" has revision "$C1$/1/defaultStage/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$C2$"
* Verify modification "0" has revision "$C2$/1/defaultStage/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$C3$"
* Verify modification "0" has revision "$C3$/1/defaultStage/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$C5$"
* Verify modification "0" has revision "$C5$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Git" named "git-one"
* Verify modification "0" has revision "git-one-g2" - On Build Cause popup
* Verify material has not changed - On Build Cause popup

* Looking at pipeline "C1" - On Swift Dashboard page
* With material "git-one" of type "git" for pipeline "C1"
* Checkin file "new-file-3" as user "go <go@po.com>" with message "Added new-file 3" - On Swift Dashboard page
* Remember current version as "git-one-g3"



* On Swift Dashboard Page
* Looking at pipeline "C2" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "2" - On Swift Dashboard page

* Looking at pipeline "C4-auto-new" - On Swift Dashboard page
* Verify pipeline does not get triggered



Teardown of contexts
____________________
* Capture go state "FanInOffBehavior" - teardown
* With "2" live agents - teardown
* Set Fan In turned off - teardown



