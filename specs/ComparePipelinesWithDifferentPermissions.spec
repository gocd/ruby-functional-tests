

ComparePipelinesWithDifferentPermissions
========================================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "first-pipeline,down-pipeline" - setup
* With "1" live agents - setup
* Capture go state "ComparePipelinesWithDifferentPermissions" - setup

ComparePipelinesWithDifferentPermissions
----------------------------------------

tags:compare_pipeline, dependency_walk


* On Swift Dashboard Page
* Looking at pipeline "down-pipeline" - On Swift Dashboard page
* With material "git-down-pipeline" of type "git" for pipeline "down-pipeline"
* Checkin file "git-new-file1" as user "go <go@po.com>" with message "Added git-new-file1" - On Swift Dashboard page
* Remember current version as "git-new1"

* Looking at pipeline "first-pipeline" - On Swift Dashboard page
* With material "git-first-pipeline" of type "git" for pipeline "first-pipeline"
* Checkin file "git-new-file2" as user "go <go@po.com>" with message "Added git-new-file2" - On Swift Dashboard page
* Remember current version as "git-new2"


* On Swift Dashboard Page
* Looking at pipeline "first-pipeline" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Looking at pipeline "down-pipeline" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page

* On Pipeline Compare page from "1" build to "1"


* Verify that there are "3" materials
* Verify displays revision "$first-pipeline$/1/defaultStage/1" having label "1" under pipeline named "first-pipeline"
* Verify displays revision "git-new1" having comment "Added git-new-file1" under "Git"
* Verify displays revision "git-new2" having comment "Added git-new-file2" under "Git"
* Click on upstream pipeline revision "$first-pipeline$/1/defaultStage/1"

* Verify that "$first-pipeline$/1/defaultStage/1" stage is displayed
* Click compare link - Already on stage Detail Page

* Verify that there are "1" materials
* Verify displays revision "git-new2" having comment "Added git-new-file2" under "Git"

* Logout and login as "raghu"

* Verify pipeline "first-pipeline" is not visible - On Swift Dashboard page
* Looking at pipeline "down-pipeline" - On Swift Dashboard page
* On Pipeline Compare page from "1" build to "1"

* Verify that there are "2" materials
* Verify displays revision "$first-pipeline$/1/defaultStage/1" having label "1" under pipeline named "$first-pipeline$"
* Verify displays revision "git-new1" having comment "Added git-new-file1" under "Git"

* Logout and login as "pavan"

* Looking at pipeline "down-pipeline" - On Swift Dashboard page
* On Pipeline Compare page from "1" build to "1"

* Verify that there are "3" materials
* Verify displays revision "$first-pipeline$/1/defaultStage/1" having label "1" under pipeline named "$first-pipeline$"
* Verify displays revision "git-new1" having comment "Added git-new-file1" under "Git"
* Verify displays revision "git-new2" having comment "Added git-new-file2" under "Git"
* Click on upstream pipeline revision "$first-pipeline$/1/defaultStage/1"

* Verify that "$first-pipeline$/1/defaultStage/1" stage is displayed
* Click compare link - Already on stage Detail Page

* Verify that there are "1" materials
* Verify displays revision "git-new2" having comment "Added git-new-file2" under "Git"

* Logout and login as "operatorUser"

* Verify pipeline "first-pipeline" is not visible - On Swift Dashboard page
* Looking at pipeline "down-pipeline" - On Swift Dashboard page
* On Pipeline Compare page from "1" build to "1"

* Verify that there are "2" materials
* Verify displays revision "$first-pipeline$/1/defaultStage/1" having label "1" under pipeline named "first-pipeline"
* Verify displays revision "git-new1" having comment "Added git-new-file1" under "Git"

* Click on upstream pipeline revision "$first-pipeline$/1/defaultStage/1"
* Verify that unauthorized access message is shown

* Logout and login as "group1View"

* Verify pipeline "first-pipeline" is visible - On Swift Dashboard page
* Looking at pipeline "down-pipeline" - On Swift Dashboard page
* On Pipeline Compare page from "1" build to "1"

* Verify that there are "3" materials
* Verify displays revision "$first-pipeline$/1/defaultStage/1" having label "1" under pipeline named "$first-pipeline$"
* Verify displays revision "git-new1" having comment "Added git-new-file1" under "Git"
* Verify displays revision "git-new2" having comment "Added git-new-file2" under "Git"
* Click on upstream pipeline revision "$first-pipeline$/1/defaultStage/1"

* Verify that "$first-pipeline$/1/defaultStage/1" stage is displayed
* Click compare link - Already on stage Detail Page

* Verify that there are "1" materials
* Verify displays revision "git-new2" having comment "Added git-new-file2" under "Git"





Teardown of contexts
____________________
* Logout - from any page
* With "1" live agents - teardown
* Capture go state "ComparePipelinesWithDifferentPermissions" - teardown
