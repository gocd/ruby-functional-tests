BisectingPipelines
==================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "basic-pipeline-fast" - setup
* With "1" live agents - setup
* Capture go state "BisectingPipelines" - setup

BisectingPipelines
------------------

tags: shine, bisect, automate

* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page

* Checkin file "foo1.txt" as user "cceuser1" with message "Comment a" - On Swift Dashboard page
* Remember current version as "rev-1"

* Checkin file "foo2.txt" as user "cceuser2" with message "Comment b" - On Swift Dashboard page
* Remember current version as "rev-2"

* Checkin file "foo3.txt" as user "cceuser3" with message "Comment c" - On Swift Dashboard page
* Remember current version as "rev-3"

* Checkin file "foo4.txt" as user "cceuser4" with message "Comment d" - On Swift Dashboard page
* Remember current version as "rev-4"

* Checkin file "foo5.txt" as user "cceuser5" with message "Comment e" - On Swift Dashboard page
* Remember current version as "rev-5"

* Trigger and wait for stage "defaultStage" is "Passed" with label "2" - On Swift Dashboard page
* Open changes section - On Swift Dashboard page

* Looking at material of type "Git" named "git"
* Verify material has changed - On Build Cause popup
* Verify modification "0" has revision "rev-5" - On Build Cause popup
* Verify modification "1" has revision "rev-4" - On Build Cause popup
* Verify modification "2" has revision "rev-3" - On Build Cause popup
* Verify modification "3" has revision "rev-2" - On Build Cause popup
* Verify modification "4" has revision "rev-1" - On Build Cause popup


* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Open trigger with options - On Swift Dashboard page

* Using material "git" set revision to trigger with as "rev-3" - On Swift Dashboard page
* Trigger pipeline with options - On Swift Dashboard page

* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "passed" on pipeline with label "3" - On Swift Dashboard page
* Verify pipeline is triggered by "anonymous" - On Swift Dashboard page

* Open changes section - On Swift Dashboard page

* Verify modification "0" has revision "rev-3" - On Build Cause popup
* Verify material has not changed - On Build Cause popup

* Click on history - On Swift Dashboard page

* Open build cause of pipeline with label "2"
* Verify build cause message contains "Comment a"
* Verify build cause message contains "Comment b"
* Verify build cause message contains "Comment c"
* Verify build cause message contains "Comment d"
* Verify build cause message contains "Comment e"
* Verify pipeline with label "2" is triggered by "anonymous"
* Pause pipeline on activity page

* On Swift Dashboard Page
* Verify pipeline is paused by "anonymous" - On Swift Dashboard page


Teardown of contexts
____________________
* Capture go state "BisectingPipelines" - teardown


