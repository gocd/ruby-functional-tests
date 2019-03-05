

PermissionsForStageAndJobDetails
================================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "first-pipeline,down-pipeline" - setup
* With "1" live agents - setup
* Capture go state "PermissionsForStageAndJobDetails" - setup

PermissionsForStageAndJobDetails
--------------------------------

tags: compare_pipeline, dependency_walk
* On Swift Dashboard Page
* Looking at pipeline "down-pipeline" - On Swift Dashboard page
* With material "git-down-pipeline" of type "git" for pipeline "down-pipeline"
* Checkin file "git-new-file1" as user "go" with message "Added git-new-file1" - On Swift Dashboard page
* Remember current version as "git-new1"
* On Swift Dashboard Page
* Looking at pipeline "first-pipeline" - On Swift Dashboard page
* With material "git-first-pipeline" of type "git" for pipeline "first-pipeline"
* Checkin file "git-new-file2" as user "go" with message "Added git-new-file2" - On Swift Dashboard page
* Remember current version as "git-new2"


* Looking at pipeline "first-pipeline" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is with label "1" - On Swift Dashboard page

* Looking at pipeline "down-pipeline" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is with label "1" - On Swift Dashboard page



* Logout and login as "raghu"
* Verify pipeline "first-pipeline" is not visible - On Swift Dashboard page
* On Swift Dashboard Page
* Looking at pipeline "down-pipeline" - On Swift Dashboard page
* On stage details page "materials" tab for "down-pipeline" label "1" stage name "defaultStage" counter "1"

* Click on revision "$first-pipeline$/1/defaultStage/1" - Already On Stage Detail Materials Tab
* Verify that unauthorized access message is shown

* On stage details page "jobs" tab for "down-pipeline" label "1" stage name "defaultStage" counter "1"

* On Job details page of pipeline "down-pipeline" counter "1" stage "defaultStage" counter "1" job "defaultJob"
* Open "Materials" tab - On Job details page
* Click on revision "$first-pipeline$/1/defaultStage/1" - Already On Stage Detail Materials Tab
* Verify that unauthorized access message is shown




Teardown of contexts
____________________
* Capture go state "PermissionsForStageAndJobDetails" - teardown
* With "1" live agents - teardown
* Logout - from any page

