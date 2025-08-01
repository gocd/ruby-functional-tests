FanInOffBehaviorBlacklistingForTriangleConfiguration
====================================================

Setup of contexts
* Fanin Configuration - setup
* Using pipeline "cruise, acceptance" - setup
* With "1" live agents - setup
* Capture go state "FaninOffBehaviorBlacklistingForTriangleConfiguration" - setup

FanInOffBehaviorBlacklistingForTriangleConfiguration
----------------------------------------------------

tags: Fanin off
* Set Fan In turned off
* Restart server

* On Swift Dashboard Page
* Looking at pipeline "cruise" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page

* Looking at pipeline "acceptance" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page

* Looking at pipeline "cruise" - On Swift Dashboard page
* With material "git-one" of type "git" for pipeline "cruise"
* Checkin file "new-file-1" as user "go <go@po.com>" with message "Added new-file 1" - On Swift Dashboard page
* Remember current version as "git-one-c1"


* On Swift Dashboard Page
* Looking at pipeline "cruise" - On Swift Dashboard page
* Verify pipeline does not get triggered
* Looking at pipeline "acceptance" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" and counter "1" - On Swift Dashboard page

* Open changes section - On Swift Dashboard page
* Looking at material of type "Pipeline" named "$cruise$"
* Verify modification "0" has revision "$cruise$/1/defaultStage/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup
* Looking at material of type "Git" named "git-one"
* Verify modification "0" has revision "git-one-c1" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* Looking at pipeline "cruise" - On Swift Dashboard page
* With material "git-two" of type "git" for pipeline "cruise"
* Checkin file "new-file-1" as user "go <go@po.com>" with message "Commit to git two" - On Swift Dashboard page
* Remember current version as "git-two-c1"


* On Swift Dashboard Page
* Looking at pipeline "cruise" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" and counter "1" - On Swift Dashboard page

* Open changes section - On Swift Dashboard page
* Looking at material of type "Git" named "git-one"
* Verify modification "0" has revision "git-one-c1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Git" named "git-two"
* Verify modification "0" has revision "git-two-c1" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* On Swift Dashboard Page
* Looking at pipeline "acceptance" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "3" and counter "1" - On Swift Dashboard page

* Open changes section - On Swift Dashboard page
* Looking at material of type "Pipeline" named "$cruise$"
* Verify modification "0" has revision "$cruise$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Git" named "git-one"
* Verify modification "0" has revision "git-one-c1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup


Teardown of contexts
____________________
* With "1" live agents - teardown
* Set Fan In turned off - teardown
* Capture go state "FaninOffBehaviorBlacklistingForTriangleConfiguration" - teardown



