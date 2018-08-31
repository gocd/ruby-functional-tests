ComparePipelineWithBisect
=========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "up" - setup
* Capture go state "ComparePipelineWithBisect" - setup

ComparePipelineWithBisect
-------------------------

tags: compare_pipeline

* Looking at pipeline "up" - On Swift Dashboard page
* Trigger and cancel stage "defaultStage" "1" times

* Looking at pipeline "up" - On Swift Dashboard page
* Checkin file "foo.txt" as user "user" with message "#10 - Comment user" - On Swift Dashboard page
* Remember current version as "FIRST_REV"
* Sleep for "5" seconds
* Checkin file "bar.txt" as user "luser" with message "#15 - Another comment loser" - On Swift Dashboard page
* Remember current version as "SECOND_REV"

* Looking at pipeline "up" - On Swift Dashboard page
* Trigger and cancel stage "defaultStage" "1" times

* Open trigger with options - On Swift Dashboard page

* Using material "git" set revision to trigger with as "FIRST_REV" - On Swift Dashboard page
* Trigger pipeline with options - On Swift Dashboard page


* On Swift Dashboard Page
* Looking at pipeline "up" - On Swift Dashboard page
* Verify stage "defaultStage" is "Building" - On Swift Dashboard page
* On stage details page material tab for "up" label "3" stage name "defaultStage" counter "1"

* Cancel "defaultStage" - On Stage Detail Page

* On Swift Dashboard Page
* Looking at pipeline "up" - On Swift Dashboard page
* Verify stage "defaultStage" is "Cancelled" on pipeline with label "3" - On Swift Dashboard page
* Click pipeline compare link

* Verify that from pipeline textbox is populated with "2"
* Verify that to pipeline textbox is populated with "3"
* Verify that there are "0" materials
* Verify there is message "This comparison involves a pipeline instance that was triggered with a non-sequential material revision."
* Opt to see bisect diff
* Verify there is a warning message "This comparison involves a pipeline instance that was triggered with a non-sequential material revision."
* Verify that there are "1" materials
* Verify displays revision "SECOND_REV" having comment "#15 - Another comment loser" under "Git"



Teardown of contexts
____________________
* Capture go state "ComparePipelineWithBisect" - teardown


