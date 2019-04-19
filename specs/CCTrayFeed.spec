
CCTrayFeed
==========

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "basic-pipeline-for-cctray, admin-pipeline-api" - setup
* With "1" live agents - setup
* Capture go state "CCTrayFeed" - setup

CCTrayFeed
----------

 tags: cctray integration

 * Looking at pipeline "basic-pipeline-for-cctray" - On Swift Dashboard page
 * Trigger pipeline - On Swift Dashboard page


 * Create a "failjob" file
 * Wait till "120" seconds for stage "defaultStage" shows status "Failed" - On Swift Dashboard page
 * Wait till pipeline completed - On Swift Dashboard page

 * Make API call to cctray feed
 * Verify cctray feed contains stage "defaultStage" with current activity "Sleeping" with label "1" and last status "Failure" with broken by authors of last commit for material "git-material" of type "git" for pipeline "basic-pipeline-for-cctray"
 * Verify cctray feed contains stage "defaultStage" job "basic-pipeline-for-cctray-job" with current activity "Sleeping" with label "1" and last status "Failure" with broken by authors of last commit for material "git-material" of type "git" for pipeline "basic-pipeline-for-cctray"
 * Verify cctray feed contains stage "defaultStage" job "passing-job" with current activity "Sleeping" with label "1" and last status "Success"
 * Verify cctray feed contains stage "defaultStage" with relative weburl "/1/defaultStage/1" with lablel "1"
 * Verify cctray feed contains stage "defaultStage" and job "basic-pipeline-for-cctray-job" with relative weburl "/1/defaultStage/1/basic-pipeline-for-cctray-job" with lablel "1"
 * Verify cctray feed contains stage "defaultStage" and job "passing-job" with relative weburl "/1/defaultStage/1/passing-job" with lablel "1"

* Delete stopjob file
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Building" - On Swift Dashboard page

* Make API call to cctray feed
* Verify cctray feed contains stage "defaultStage" with current activity "Building" with label "1" and last status "Failure"
* Verify cctray feed contains stage "defaultStage" job "basic-pipeline-for-cctray-job" with current activity "Building" with label "1" and last status "Failure"
* Verify cctray feed contains stage "defaultStage" job "passing-job" with current activity "Building" with label "1" and last status "Success"

* Create a "stopjob" file
* Wait till "120" seconds for stage "defaultStage" shows status "Passed" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page

* Make API call to cctray feed
* Verify cctray feed contains stage "defaultStage" with current activity "Sleeping" with label "2" and last status "Success"
* Verify cctray feed contains stage "defaultStage" job "basic-pipeline-for-cctray-job" with current activity "Sleeping" with label "2" and last status "Success"
* Verify cctray feed contains stage "defaultStage" job "passing-job" with current activity "Sleeping" with label "2" and last status "Success"
* Delete stopjob file
* On stage details page "overview" tab for "basic-pipeline-for-cctray" label "2" stage name "defaultStage" counter "1"
* Rerun stage "defaultStage" - On Stage Details page


* On Swift Dashboard Page
* Verify stage "defaultStage" is "Building" on pipeline with label "2" and counter "2" - On Swift Dashboard page

* Create a "failjob" file
* Wait till "120" seconds for stage "defaultStage" shows status "Failed" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page



CCTray feed should not contain the breakers info, because the buildcause hasn't changed.
* Make API call to cctray feed
* Verify cctray feed contains stage "defaultStage" with current activity "Sleeping" with label "2 :: 2" and last status "Failure" with broken by authors of last commit for material "git-material" of type "git" for pipeline "basic-pipeline-for-cctray"
* Verify cctray feed contains stage "defaultStage" job "basic-pipeline-for-cctray-job" with current activity "Sleeping" with label "2 :: 2" and last status "Failure" with broken by authors of last commit for material "git-material" of type "git" for pipeline "basic-pipeline-for-cctray"
* Verify cctray feed contains stage "defaultStage" job "passing-job" with current activity "Sleeping" with label "2 :: 2" and last status "Success"
* Verify cctray feed contains stage "defaultStage" with relative weburl "/2/defaultStage/2" with lablel "2 :: 2"
* Verify cctray feed contains stage "defaultStage" and job "basic-pipeline-for-cctray-job" with relative weburl "/2/defaultStage/2/basic-pipeline-for-cctray-job" with lablel "2 :: 2"
* Verify cctray feed contains stage "defaultStage" and job "passing-job" with relative weburl "/2/defaultStage/2/passing-job" with lablel "2 :: 2"

* On Swift Dashboard Page
* Looking at pipeline "admin-pipeline-api" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" - On Swift Dashboard page

* Make API call to cctray feed
* Verify cctray feed contains stage "defaultStage" with current activity "Sleeping" with label "1" and last status "Success"

* Logout - from any page

* Login as "view"
* Make API call to cctray feed
* Verify cctray does not contain pipeline "admin-pipeline-api" with stage "defaultStage"
* Looking at pipeline "basic-pipeline-for-cctray" - On Swift Dashboard page
* Verify cctray feed contains stage "defaultStage" with current activity "Sleeping" with label "2 :: 2" and last status "Failure"




Teardown of contexts
____________________
* Capture go state "CCTrayFeed" - teardown
* With "1" live agents - teardown
* Logout - from any page
