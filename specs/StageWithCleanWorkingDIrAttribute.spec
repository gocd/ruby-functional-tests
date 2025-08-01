

StageWithCleanWorkingDIrAttribute
=================================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "pipeline-clean-working-dir" - setup
* With "1" live agents - setup
* Capture go state "StageWithCleanWorkingDIrAttribute" - setup

StageWithCleanWorkingDIrAttribute
---------------------------------

tags: stage-config

* On Swift Dashboard Page
* Looking at pipeline "pipeline-clean-working-dir" - On Swift Dashboard page
* With material "basic-git-material" of type "git" for pipeline "pipeline-clean-working-dir"
* Checkin file "new_file.txt" as user "go <go@po.com>" with message "Comment abc" - On Swift Dashboard page

* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "setup" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page
* On stage details page "overview" tab for "pipeline-clean-working-dir" label "1" stage name "setup" counter "1"
* Trigger stage "first" - On stage details page

* On Swift Dashboard Page
* Verify stage "first" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page
* On Job details page of pipeline "pipeline-clean-working-dir" counter "1" stage "first" counter "1" job "firstJob"
* Verify console log contains message "Start to upload"
* Verify console log contains message "Start to prepare"
* Verify console log does not contains message "Cleaning working directory"
* Verify console log contains message "abc.txt"
* Verify console log contains message "xyz.txt"
* Verify console log contains message "bar"
* Verify console log contains message "new_file.txt"
* Click on stage bread crumb


* Trigger stage "second" - On stage details page

* On Swift Dashboard Page
* Verify stage "second" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page
* On Job details page of pipeline "pipeline-clean-working-dir" counter "1" stage "second" counter "1" job "secondJob"
* Verify console log contains message "Cleaning working directory"
* Verify console log does not contains message "abc.txt"
* Verify console log does not contains message "xyz.txt"
* Verify console log does not contains message "bar"
* Verify console log contains message "new_file.txt"







Teardown of contexts
____________________
* Capture go state "StageWithCleanWorkingDIrAttribute" - teardown
* With "1" live agents - teardown



