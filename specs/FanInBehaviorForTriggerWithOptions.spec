FanInBehaviorForTriggerWithOptions
==================================

Setup of contexts
* Fanin Configuration - setup
* Using pipeline "FTO1, FTO2, FTO3, FTO4, FTO5" - setup
* With "2" live agents - setup
* Capture go state "FanInBehaviorForTriggerWithOptions" - setup

FanInBehaviorForTriggerWithOptions
----------------------------------

tags: fanin-trigger-with-opts

* Looking at pipeline "FTO1" - On Swift Dashboard page
* With material "git-one" of type "git" for pipeline "FTO1"
* Checkin file "new-file-0" as user "go <go@po.com>" with message "Added new-file 0" - On Swift Dashboard page
* Remember current version as "g0"

* Looking at pipeline "FTO1" - On Swift Dashboard page
* Trigger and wait for stage "stage1" is "passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "FTO2" - On Swift Dashboard page
* Trigger and wait for stage "stage1" is "passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "FTO3" - On Swift Dashboard page
* Trigger and wait for stage "stage1" is "passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "FTO4" - On Swift Dashboard page
* Verify stage "stage1" is "passed" on pipeline with label "1" - On Swift Dashboard page
* Looking at pipeline "FTO5" - On Swift Dashboard page
* Verify stage "stage1" is "passed" on pipeline with label "1" - On Swift Dashboard page

* Looking at pipeline "FTO1" - On Swift Dashboard page
* With material "git-one" of type "git" for pipeline "FTO1"
* Checkin file "new-file-1" as user "go <go@po.com>" with message "Added new-file 1" - On Swift Dashboard page
* Remember current version as "g1"

* Looking at pipeline "FTO1" - On Swift Dashboard page
* Trigger and wait for stage "stage1" is "passed" with label "2" - On Swift Dashboard page

* Looking at pipeline "FTO1" - On Swift Dashboard page
* With material "git-one" of type "git" for pipeline "FTO1"
* Checkin file "new-file-2" as user "go <go@po.com>" with message "Added new-file 2" - On Swift Dashboard page
* Remember current version as "g2"

* Looking at pipeline "FTO2" - On Swift Dashboard page
* Trigger and wait for stage "stage1" is "passed" with label "2" - On Swift Dashboard page
* Looking at pipeline "FTO3" - On Swift Dashboard page
* Trigger and wait for stage "stage1" is "passed" with label "2" - On Swift Dashboard page

* Looking at pipeline "FTO4" - On Swift Dashboard page
* Verify stage "stage1" is with label "1" - On Swift Dashboard page

* Looking at pipeline "FTO1" - On Swift Dashboard page
* With material "git-one" of type "git" for pipeline "FTO1"
* Checkin file "new-file-3" as user "go <go@po.com>" with message "Added new-file 3" - On Swift Dashboard page
* Remember current version as "g3"

* Looking at pipeline "FTO1" - On Swift Dashboard page
* Trigger and wait for stage "stage1" is "passed" with label "3" - On Swift Dashboard page
* Looking at pipeline "FTO2" - On Swift Dashboard page
* Trigger and wait for stage "stage1" is "passed" with label "3" - On Swift Dashboard page
* Looking at pipeline "FTO3" - On Swift Dashboard page
* Trigger and wait for stage "stage1" is "passed" with label "3" - On Swift Dashboard page
* Looking at pipeline "FTO4" - On Swift Dashboard page
* Verify stage "stage1" is "passed" on pipeline with label "2" - On Swift Dashboard page
* Looking at pipeline "FTO5" - On Swift Dashboard page
* Verify stage "stage1" is "passed" on pipeline with label "2" - On Swift Dashboard page

* Looking at pipeline "FTO4" - On Swift Dashboard page
* Open trigger with options - On Swift Dashboard page

* Using material "$FTO1$" set revision to trigger with as "$FTO1$/3/stage1/1" - On Swift Dashboard page
* Using material "$FTO3$" set revision to trigger with as "$FTO3$/3/stage1/1" - On Swift Dashboard page
* Using material "$FTO2$" set revision to trigger with as "$FTO2$/2/stage1/1" - On Swift Dashboard page
* Trigger pipeline with options - On Swift Dashboard page

* Looking at pipeline "FTO4" - On Swift Dashboard page
* Verify stage "stage1" is "passed" on pipeline with label "3" - On Swift Dashboard page


* Looking at pipeline "FTO5" - On Swift Dashboard page
* Verify stage "stage1" is with label "2" - On Swift Dashboard page

Trigger FT03 with options which won't allow fan-in due to use of g3 with FT02 run that didn't use g3 material
* Looking at pipeline "FTO3" - On Swift Dashboard page
* Open trigger with options - On Swift Dashboard page

* Using material "git-one" set revision to trigger with as "g3" - On Swift Dashboard page
* Using material "$FTO1$" set revision to trigger with as "$FTO1$/3/stage1/1" - On Swift Dashboard page
* Using material "$FTO2$" set revision to trigger with as "$FTO2$/2/stage1/1" - On Swift Dashboard page
* Trigger pipeline with options - On Swift Dashboard page

* Looking at pipeline "FTO3" - On Swift Dashboard page
* Verify stage "stage1" is "passed" on pipeline with label "4" - On Swift Dashboard page

Check FT04 not triggered (can't fan in)
* Looking at pipeline "FTO4" - On Swift Dashboard page
* Verify stage "stage1" is with label "3" - On Swift Dashboard page

Go back and trigger FT02 and FT03 with options allowing fan-in (original g1 revision)
* Looking at pipeline "FTO2" - On Swift Dashboard page
* Open trigger with options - On Swift Dashboard page
* Using material "git-one" set revision to trigger with as "g1" - On Swift Dashboard page
* Trigger pipeline with options - On Swift Dashboard page

* Looking at pipeline "FTO2" - On Swift Dashboard page
* Verify stage "stage1" is "passed" on pipeline with label "4" - On Swift Dashboard page

* Looking at pipeline "FTO3" - On Swift Dashboard page
* Open trigger with options - On Swift Dashboard page

* Using material "git-one" set revision to trigger with as "g1" - On Swift Dashboard page
* Using material "$FTO1$" set revision to trigger with as "$FTO1$/2/stage1/1" - On Swift Dashboard page
* Using material "$FTO2$" set revision to trigger with as "$FTO2$/4/stage1/1" - On Swift Dashboard page
* Trigger pipeline with options - On Swift Dashboard page


* Looking at pipeline "FTO3" - On Swift Dashboard page
* Verify stage "stage1" is "passed" on pipeline with label "5" - On Swift Dashboard page
* Looking at pipeline "FTO4" - On Swift Dashboard page
* Verify stage "stage1" is "passed" on pipeline with label "4" - On Swift Dashboard page
* Looking at pipeline "FTO5" - On Swift Dashboard page
* Verify stage "stage1" is "passed" on pipeline with label "3" - On Swift Dashboard page

Trigger FT03 with g3 revision and "correct" FT01 and FT02 revisions (allowing fan-in)
* Looking at pipeline "FTO3" - On Swift Dashboard page
* Open trigger with options - On Swift Dashboard page

* Using material "git-one" set revision to trigger with as "g3" - On Swift Dashboard page
* Using material "$FTO1$" set revision to trigger with as "$FTO1$/3/stage1/1" - On Swift Dashboard page
* Using material "$FTO2$" set revision to trigger with as "$FTO2$/3/stage1/1" - On Swift Dashboard page
* Trigger pipeline with options - On Swift Dashboard page


* Looking at pipeline "FTO3" - On Swift Dashboard page
* Verify stage "stage1" is "passed" on pipeline with label "6" - On Swift Dashboard page

* Looking at pipeline "FTO4" - On Swift Dashboard page
* Verify stage "stage1" is "passed" on pipeline with label "4" - On Swift Dashboard page



Teardown of contexts
____________________
* With "2" live agents - teardown
* Capture go state "FanInBehaviorForTriggerWithOptions" - teardown
