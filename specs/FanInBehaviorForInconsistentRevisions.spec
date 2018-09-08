FanInBehaviorForInconsistentRevisions
=====================================

Setup of contexts
* Fanin Configuration - setup
* Using pipeline "FIR1, FIR2, FIR3" - setup
* With "2" live agents - setup
* Capture go state "FanInBehaviorForInconsistentRevisions" - setup

FanInBehaviorForInconsistentRevisions
-------------------------------------

tags: diamond dependency, fanin

* Looking at pipeline "FIR1" - On Swift Dashboard page
* Checkin file "new-file-1" as user "go <go@po.com>" with message "Added new-file 1" - On Swift Dashboard page
* Remember current version as "g1"

* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page


* Looking at pipeline "FIR2" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page

* Looking at pipeline "FIR3" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* Looking at pipeline "FIR1" - On Swift Dashboard page
* Checkin file "new-file-2" as user "go <go@po.com>" with message "Added new-file 2" - On Swift Dashboard page
* Remember current version as "g2"

* Trigger and wait for stage "defaultStage" is "Passed" with label "2" - On Swift Dashboard page


* Looking at pipeline "FIR2" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "2" - On Swift Dashboard page
* Looking at pipeline "FIR3" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page


* Looking at pipeline "FIR1" - On Swift Dashboard page
* Checkin file "new-file-3" as user "go <go@po.com>" with message "Added new-file 3" - On Swift Dashboard page
* Remember current version as "g3"

* Trigger and wait for stage "defaultStage" is "Passed" with label "3" - On Swift Dashboard page

* Looking at pipeline "FIR2" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "3" - On Swift Dashboard page
* Looking at pipeline "FIR3" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "3" - On Swift Dashboard page

* Looking at pipeline "FIR3" - On Swift Dashboard page
* Pause pipeline with reason "wait for FIR1 and FIR2 to complete" - On Swift Dashboard page

* Looking at pipeline "FIR1" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "4" - On Swift Dashboard page

* Looking at pipeline "FIR2" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "4" - On Swift Dashboard page


* Looking at pipeline "FIR3" - On Swift Dashboard page
* Unpause pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "4" - On Swift Dashboard page

* Looking at pipeline "FIR2" - On Swift Dashboard page
* Open trigger with options - On Swift Dashboard page

* Using material "git" set revision to trigger with as "g1" - On Swift Dashboard page
* Trigger pipeline with options - On Swift Dashboard page

* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "5" - On Swift Dashboard page

* Looking at pipeline "FIR3" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "5" - On Swift Dashboard page
* Open changes section - On Swift Dashboard page

* Looking at material of type "Pipeline" named "$FIR2$"
* Verify modification "0" has revision "$FIR2$/5/stage1/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$FIR1$"
* Verify modification "0" has revision "$FIR1$/1/stage1/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* Looking at pipeline "FIR1" - On Swift Dashboard page
* Open trigger with options - On Swift Dashboard page

* Using material "git" set revision to trigger with as "g3" - On Swift Dashboard page
* Trigger pipeline with options - On Swift Dashboard page

* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "5" - On Swift Dashboard page
* Looking at pipeline "FIR3" - On Swift Dashboard page
* Verify pipeline does not get triggered




Teardown of contexts
____________________
* Capture go state "FanInBehaviorForInconsistentRevisions" - teardown


