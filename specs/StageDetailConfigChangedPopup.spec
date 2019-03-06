
StageDetailConfigChangedPopup
=============================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "edit-pipeline" - setup
* Capture go state "StageDetailConfigChangedPopup" - setup

StageDetailConfigChangedPopup
-----------------------------

tags: wip

* On Swift Dashboard Page
* Looking at pipeline "edit-pipeline" - On Swift Dashboard page
* Trigger and cancel stage "defaultStage" "1" times


* On Job settings page of pipeline "edit-pipeline" stage "defaultStage" job "defaultJob"
* Open "Job Settings" tab - On Job settings page
* Set job as "new_job_name" - On Job settings page
* Save Changes

* On Swift Dashboard Page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline start building - On Swift Dashboard page
* Verify stage "defaultStage" is "Building" - On Swift Dashboard page
* On stage details page "overview" tab for "edit-pipeline" label "2" stage name "defaultStage" counter "1"

* Cancel "defaultStage" - On Stage Detail Page
* On stage details page "overview" tab for "edit-pipeline" label "2" stage name "defaultStage" counter "1"

* Verify config changed marker after pipeline counter "1" stage counter "1" is a link
* Click on config changed link after pipeline counter "1" stage counter "1"

* Verify added changes contains lines "<job name=\"new_job_name\""
* Verify removed changes contains lines "<job name=\"defaultJob\""

* Logout - from any page

* Login as "operate"

* On Swift Dashboard Page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Building" - On Swift Dashboard page
* On stage details page "overview" tab for "edit-pipeline" label "3" stage name "defaultStage" counter "1"
* Cancel "defaultStage" - On Stage Detail Page
* On stage details page "overview" tab for "edit-pipeline" label "3" stage name "defaultStage" counter "1"
* Verify config changed marker after pipeline counter "1" stage counter "1" is not a link







Teardown of contexts
____________________
* Capture go state "StageDetailConfigChangedPopup" - teardown
* Logout - from any page

