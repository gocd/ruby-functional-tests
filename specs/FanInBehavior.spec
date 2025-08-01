
FanInBehavior
=============

Setup of contexts
* Fanin Configuration - setup
* Using pipeline "C1, C2, C3, C4-auto, C5, C6-auto, C7, C8, C9, C10-auto, C11-auto" - setup
* With "2" live agents - setup
* Capture go state "FanInBehavior" - setup

FanInBehavior
-------------

tags: diamond dependency, fanin

* On Swift Dashboard Page
* Looking at pipeline "C6-auto" - On Swift Dashboard page
* With material "git-four" of type "git" for pipeline "C6-auto"
* Checkin file "new-file-2" as user "go <go@po.com>" with message "Added new-file 2" - On Swift Dashboard page
* Remember current version as "git-four-g2"

* Looking at pipeline "C1" - On Swift Dashboard page
* With material "git-one" of type "git" for pipeline "C1"
* Checkin file "new-file-2" as user "go <go@po.com>" with message "Added new-file 2" - On Swift Dashboard page
* Remember current version as "git-one-g2"

* Looking at pipeline "C7" - On Swift Dashboard page
* With material "git-three" of type "git" for pipeline "C7"
* Checkin file "new-file-2" as user "go <go@po.com>" with message "Added new-file 2" - On Swift Dashboard page
* Remember current version as "git-three-g2"

* On Swift Dashboard Page
* Looking at pipeline "C1" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "C2" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "C8" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page

* Looking at pipeline "C1" - On Swift Dashboard page
* With material "git-one" of type "git" for pipeline "C1"
* Checkin file "new-file-3" as user "go <go@po.com>" with message "Added new-file 3 " - On Swift Dashboard page
* Remember current version as "git-one-g3"

* On Swift Dashboard Page
* Looking at pipeline "C1" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "2" - On Swift Dashboard page
* Looking at pipeline "C3" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "C2" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "2" - On Swift Dashboard page

* Looking at pipeline "C4-auto" - On Swift Dashboard page
* Verify pipeline does not get triggered


* Looking at pipeline "C3" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "2" - On Swift Dashboard page
* Looking at pipeline "C4-auto" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page


* Open changes section - On Swift Dashboard page
* Looking at material of type "Pipeline" named "$C1$"
* Verify modification "0" has revision "$C1$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$C2$"
* Verify modification "0" has revision "$C2$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$C3$"
* Verify modification "0" has revision "$C3$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* On Swift Dashboard Page
* Looking at pipeline "C1" - On Swift Dashboard page
* With material "git-two" of type "git" for pipeline "C1"
* Checkin file "file-2" as user "go <go@po.com>" with message "Added file 2" - On Swift Dashboard page
* Remember current version as "git-two-g2"

* On Swift Dashboard Page
* Looking at pipeline "C5" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "C7" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page


* Looking at pipeline "C7" - On Swift Dashboard page
* With material "git-three" of type "git" for pipeline "C7"
* Checkin file "file-3" as user "go <go@po.com>" with message "Added file 3" - On Swift Dashboard page
* Remember current version as "git-three-g3"

* On Swift Dashboard Page
* Looking at pipeline "C8" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "2" - On Swift Dashboard page

* Looking at pipeline "C1" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "3" - On Swift Dashboard page

* Looking at pipeline "C3" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "3" - On Swift Dashboard page


* Looking at pipeline "C4-auto" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" and counter "1" - On Swift Dashboard page
* Open changes section - On Swift Dashboard page


* Looking at material of type "Pipeline" named "$C1$"
* Verify modification "0" has revision "$C1$/3/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$C2$"
* Verify modification "0" has revision "$C2$/2/defaultStage/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$C3$"
* Verify modification "0" has revision "$C3$/3/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup


* On Swift Dashboard Page
* Looking at pipeline "C6-auto" - On Swift Dashboard page
* Verify pipeline does not get triggered

* Looking at pipeline "C7" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "2" - On Swift Dashboard page

* Looking at pipeline "C6-auto" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page
* Open changes section - On Swift Dashboard page

* Looking at material of type "Pipeline" named "$C4-auto$"
* Verify modification "0" has revision "$C4-auto$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* Looking at material of type "Pipeline" named "$C1$"
* Verify modification "0" has revision "$C1$/3/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* Looking at material of type "Pipeline" named "$C5$"
* Verify modification "0" has revision "$C5$/1/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* Looking at material of type "Pipeline" named "$C7$"
* Verify modification "0" has revision "$C7$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* Looking at material of type "Pipeline" named "$C8$"
* Verify modification "0" has revision "$C8$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* Looking at material of type "Git" named "git-one"
* Verify modification "0" has revision "git-one-g3" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* Looking at material of type "Git" named "git-four"
* Verify modification "0" has revision "git-four-g2" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* Looking at pipeline "C10-auto" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page
* Open changes section - On Swift Dashboard page

* Looking at material of type "Pipeline" named "$C8$"
* Verify modification "0" has revision "$C8$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* Looking at material of type "Pipeline" named "$C6-auto$"
* Verify modification "0" has revision "$C6-auto$/1/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* On Swift Dashboard Page
* Looking at pipeline "C7" - On Swift Dashboard page
* With material "git-three" of type "git" for pipeline "C7"
* Checkin file "file-4" as user "go <go@po.com>" with message "Added file 4" - On Swift Dashboard page
* Remember current version as "git-three-g4"

* Looking at pipeline "C6-auto" - On Swift Dashboard page
* With material "git-four" of type "git" for pipeline "C6-auto"
* Checkin file "file-3" as user "go <go@po.com>" with message "Added file 3" - On Swift Dashboard page
* Remember current version as "git-four-g3"

* On Swift Dashboard Page
* Looking at pipeline "C6-auto" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" and counter "1" - On Swift Dashboard page
* Open changes section - On Swift Dashboard page


* Looking at material of type "Pipeline" named "$C4-auto$"
* Verify modification "0" has revision "$C4-auto$/2/defaultStage/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup

* Looking at material of type "Pipeline" named "$C1$"
* Verify modification "0" has revision "$C1$/3/defaultStage/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup

* Looking at material of type "Pipeline" named "$C5$"
* Verify modification "0" has revision "$C5$/1/defaultStage/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup

* Looking at material of type "Pipeline" named "$C7$"
* Verify modification "0" has revision "$C7$/2/defaultStage/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup

* Looking at material of type "Pipeline" named "$C8$"
* Verify modification "0" has revision "$C8$/2/defaultStage/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup

* Looking at material of type "Git" named "git-one"
* Verify modification "0" has revision "git-one-g3" - On Build Cause popup
* Verify material has not changed - On Build Cause popup

* Looking at material of type "Git" named "git-four"
* Verify modification "0" has revision "git-four-g3" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* On Swift Dashboard Page
* Looking at pipeline "C9" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page

* Looking at pipeline "C10-auto" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" and counter "1" - On Swift Dashboard page
* Open changes section - On Swift Dashboard page

* Looking at material of type "Pipeline" named "$C8$"
* Verify modification "0" has revision "$C8$/2/defaultStage/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup

* Looking at material of type "Pipeline" named "$C6-auto$"
* Verify modification "0" has revision "$C6-auto$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* Looking at pipeline "C11-auto" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page
* Open changes section - On Swift Dashboard page

* Looking at material of type "Pipeline" named "$C9$"
* Verify modification "0" has revision "$C9$/1/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$C10-auto$"
* Verify modification "0" has revision "$C10-auto$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup



* Looking at material of type "Git" named "git-three"
* Verify modification "0" has revision "git-three-g3" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* Looking at pipeline "C1" - On Swift Dashboard page
* With material "git-one" of type "git" for pipeline "C1"
* Checkin file "file-4" as user "go <go@po.com>" with message "Added file 4" - On Swift Dashboard page
* Remember current version as "git-one-g4"

* On Swift Dashboard Page

* Looking at pipeline "C2" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "3" - On Swift Dashboard page
* Looking at pipeline "C8" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "3" - On Swift Dashboard page

* Looking at pipeline "C10-auto" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" and counter "1" - On Swift Dashboard page


* Looking at pipeline "C1" - On Swift Dashboard page
* With material "git-two" of type "git" for pipeline "C1"
* Checkin file "file-3" as user "go <go@po.com>" with message "Added file 3" - On Swift Dashboard page
* Remember current version as "git-two-g3"



* On Swift Dashboard Page

* Looking at pipeline "C1" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "4" - On Swift Dashboard page


* Looking at pipeline "C4-auto" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "3" - On Swift Dashboard page
* Open changes section - On Swift Dashboard page

* Looking at material of type "Pipeline" named "$C1$"
* Verify modification "0" has revision "$C1$/4/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$C2$"
* Verify modification "0" has revision "$C2$/3/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$C3$"
* Verify modification "0" has revision "$C3$/3/defaultStage/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup

* On Swift Dashboard Page
* Looking at pipeline "C6-auto" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "3" - On Swift Dashboard page

* Open changes section - On Swift Dashboard page


* Looking at material of type "Pipeline" named "$C4-auto$"
* Verify modification "0" has revision "$C4-auto$/3/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* Looking at material of type "Pipeline" named "$C1$"
* Verify modification "0" has revision "$C1$/4/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* Looking at material of type "Pipeline" named "$C5$"
* Verify modification "0" has revision "$C5$/1/defaultStage/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup

* Looking at material of type "Pipeline" named "$C7$"
* Verify modification "0" has revision "$C7$/2/defaultStage/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup

* Looking at material of type "Pipeline" named "$C8$"
* Verify modification "0" has revision "$C8$/3/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* Looking at material of type "Git" named "git-one"
* Verify modification "0" has revision "git-one-g4" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* Looking at material of type "Git" named "git-four"
* Verify modification "0" has revision "git-four-g3" - On Build Cause popup
* Verify material has not changed - On Build Cause popup


Teardown of contexts
____________________
* Capture go state "FanInBehavior" - teardown
* With "2" live agents - teardown



