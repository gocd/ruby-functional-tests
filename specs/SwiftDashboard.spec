SwiftDashboard
==============

SwiftDashboard
--------------

tags: dashboard, swift

Setup of contexts
* Enable new dashboard toggles
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "manual-stages-that-run-till-file-exists, admin-pipeline" - setup
* With "2" live agents - setup
* Capture go state "SwiftDashboard" - setup

* Logout - from any page

* Login as "view"

* On Swift Dashboard Page
* Verify pipeline "admin-pipeline" is not visible - On Swift Dashboard page
* Verify group "admin-only" is not visible - On Swift Dashboard page

* Logout - from any page

* Login as "admin"

* On Swift Dashboard Page
* Looking at pipeline "admin-pipeline" - On Swift Dashboard page
* Verify pipeline is in group "admin-only" - On Swift Dashboard page

* Looking at pipeline "manual-stages-that-run-till-file-exists" - On Swift Dashboard page
* Verify pipeline is in group "open-to-all" - On Swift Dashboard page
* Verify pipeline has no history - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "firstStage" is "building" - On Swift Dashboard page
* Create a "stopjob" file and validate pipeline completed
* Verify stage "firstStage" is "passed" - On Swift Dashboard page
* Verify pipeline is triggered by "admin" - On Swift Dashboard page
* Pause pipeline with reason "twist testing it" - On Swift Dashboard page
* Verify pipeline is paused with reason "gauge testing it" by "admin" - On Swift Dashboard page
* Verify cannot trigger pipeline
* Unpause pipeline - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "firstStage" is "building" - On Swift Dashboard page
* Click on history - On Swift Dashboard page
* Verify pipeline activity page is shown

* On Swift Dashboard Page
* Verify stage "firstStage" is "building" - On Swift Dashboard page
 Verify stage "secondStage" is "building" - On Swift Dashboard page

* Create a "stopjob" file and validate pipeline completed
* Verify stage "firstStage" is "passed" - On Swift Dashboard page
* Open changes section - On Swift Dashboard page

* Looking at material of type "Git" named "gitMaterial" verify shows latest revision - On Swift Dashboard page

* On Swift Dashboard Page
* Looking at pipeline "manual-stages-that-run-till-file-exists" - On Swift Dashboard page
* Checkin file "something" as user "gouser" with message "Added something" - On Swift Dashboard page
* Remember current version as "git-commit1"
* Checkin file "another file" as user "gouser" with message "Added another file" - On Swift Dashboard page

* On Swift Dashboard Page
* Looking at pipeline "manual-stages-that-run-till-file-exists" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "firstStage" is "Building" - On Swift Dashboard page
* Create a "stopjob" file and validate pipeline completed
* Verify stage "firstStage" is "Passed" - On Swift Dashboard page

* Open trigger with options - On Swift Dashboard page

* Using material "gitMaterial" set revision to trigger with as "git-commit1" - On Swift Dashboard page
* Trigger pipeline with options - On Swift Dashboard page

* On Swift Dashboard Page
* Looking at pipeline "manual-stages-that-run-till-file-exists" - On Swift Dashboard page
* Verify stage "firstStage" is "Building" - On Swift Dashboard page
* Verify trigger with option is disabled
* Create a "stopjob" file and validate pipeline completed
* Verify stage "firstStage" is "Passed" - On Swift Dashboard page
* Open trigger with options - On Swift Dashboard page
 
Enable  below step once PR https://github.com/gocd/gocd/pull/4525 is merged
* Verify last run revision is "git-commit1" - On Swift Dashboard page

* Close - Trigger with options - On Swift Dashboard page

Teardown of contexts
____________________
* Capture go state "SwiftDashboard" - teardown
* With "2" live agents - teardown
* Disable new dashboard toggles

