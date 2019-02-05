
FanInBehaviorStageFailAndCancel
===============================

Setup of contexts
* Fanin Configuration - setup
* Using pipeline "FS1, FS2, FS3," - setup
* With "2" live agents - setup
* Capture go state "FanInBehaviorStageFailAndCancel" - setup

FanInBehaviorStageFailAndCancel
-------------------------------

tags: diamond dependency, fanin

* On Swift Dashboard Page
* Looking at pipeline "FS1" - On Swift Dashboard page
* With material "git-one" of type "git" for pipeline "FS1"
* Checkin file "new-file-1" as user "go <go@po.com>" with message "Added new-file 1" - On Swift Dashboard page
* Remember current version as "git-one-g1"



* On Swift Dashboard Page
* Looking at pipeline "FS1" - On Swift Dashboard page
* Trigger and wait for stage "stage1" is "Passed" with label "1" - On Swift Dashboard page
* On stage details page "overview" tab for "FS1" label "1" stage name "stage1" counter "1"
* Trigger stage "stage2-manual" - On stage details page


* On Swift Dashboard Page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "stage2-manual" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page

* Looking at pipeline "FS2" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "stage1" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page
* Looking at pipeline "FS3" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "stage1" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page


* On Job settings page of pipeline "FS1" stage "stage2-manual" job "job2"
* Open "Tasks" tab - On Job settings page
* Open task "1"
* Set command as "crap" - On Job Setting Page
* Save Changes

* On Swift Dashboard Page
* Looking at pipeline "FS1" - On Swift Dashboard page
* Trigger and wait for stage "stage1" is "Passed" with label "2" - On Swift Dashboard page
* On stage details page "overview" tab for "FS1" label "2" stage name "stage1" counter "1"
* Trigger stage "stage2-manual" - On stage details page

* On Swift Dashboard Page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "stage2-manual" is "Failed" on pipeline with label "2" and counter "1" - On Swift Dashboard page

* Looking at pipeline "FS2" - On Swift Dashboard page
* Verify pipeline does not get triggered


* On Job settings page of pipeline "FS1" stage "stage2-manual" job "job2"
* Open "Tasks" tab - On Job settings page
* Open task "1"
* Set command as "sleep" - On Job Setting Page
* Save Changes

* On Swift Dashboard Page
* Looking at pipeline "FS1" - On Swift Dashboard page
* Trigger and wait for stage "stage1" is "Passed" with label "3" - On Swift Dashboard page
* On stage details page "overview" tab for "FS1" label "3" stage name "stage1" counter "1"
* Trigger stage "stage2-manual" - On stage details page
* On Swift Dashboard Page
* Looking at pipeline "FS1" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "stage2-manual" is "Passed" on pipeline with label "3" and counter "1" - On Swift Dashboard page
* On stage details page "overview" tab for "FS1" label "3" stage name "stage2-manual" counter "1"
* Rerun stage "stage2-manual" - On Stage Details page
* Cancel "stage2-manual" - On Stage Detail Page

* On Swift Dashboard Page

* Looking at pipeline "FS2" - On Swift Dashboard page
* Verify stage "stage1" is "passed" on pipeline with label "2" - On Swift Dashboard page

* Looking at pipeline "FS3" - On Swift Dashboard page
* Verify stage "stage1" is "passed" on pipeline with label "4" - On Swift Dashboard page
* Open changes section - On Swift Dashboard page


* Looking at material of type "Pipeline" named "$FS1$"
* Verify modification "0" has revision "$FS1$/3/stage1/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup

* Looking at material of type "Pipeline" named "$FS2$"
* Verify modification "0" has revision "$FS2$/2/stage1/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup


Teardown of contexts
____________________
* Capture go state "FanInBehaviorStageFailAndCancel" - teardown
* With "2" live agents - teardown


