DrainModeSPA
=========

DrainModeSPA
-------------------
tags: drain_mode

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "wait-for-stop-job, run-forever, long-mdu, basic-pipeline-fast, timer-triggered" - setup
* With "3" live agents - setup
* Capture go state "DrainModeSPA" - setup

* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "passed" - On Swift Dashboard page
* Looking at pipeline "run-forever" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Building" - On Swift Dashboard page
* Looking at pipeline "wait-for-stop-job" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Building" - On Swift Dashboard page

* Looking at pipeline "long-mdu" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page

* Looking at pipeline "timer-triggered" - On Swift Dashboard page
* Using timer with spec "0/30 * * 1/1 * ? *" 

* On Drain mode SPA
* Enable drain mode

* Verify in progress subsystems section shows pipeline "run-forever" counter "1" stage "defaultStage" counter "1" 
* Verify in progress subsystems section shows pipeline "wait-for-stop-job" counter "1" stage "defaultStage" counter "1" 
* Verify in progress subsystems section shows material "long_running_mdu"
* Verify in progress subsystems section does not show pipeline "basic-pipeline-fast" counter "1" stage "defaultStage" counter "1" 

* On Swift Dashboard Page
* Verify drain mode banner is shown

* On Drain mode SPA
* Cancel pipeline "run-forever" counter "1" stage "defaultStage" counter "1" - On Drain mode spa

* Verify in progress subsystems section shows pipeline "wait-for-stop-job" counter "1" stage "defaultStage" counter "1" 

* Looking at pipeline "wait-for-stop-job" - On Swift Dashboard page
* Create a "stopjob" file
* Verify stage "defaultStage" is "passed" - On Swift Dashboard page
* On Job details page of pipeline "wait-for-stop-job" counter "1" stage "defaultStage" counter "1" job "defaultJob"
* Verify console log contains message "Second task completed"

* On Swift Dashboard Page
* Looking at pipeline "timer-triggered" - On Swift Dashboard page
* Verify pipeline has no history - On Swift Dashboard page

* On Drain mode SPA
* Verify drain mode successful

* On Swift Dashboard Page
* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page

* Verify pipeline "basic-pipeline-fast" does not trigger and stays at label "1" - On Swift Dashboard page

* Attempt to pause pipline "basic-pipeline-fast" with cause "gauge testing it" and should return with http status "503"


 Verify server backup is successful
 Verify agent registaration is successful
 Restart server
 Verify server is not in drain mode

* On Drain mode SPA
* Disable drain mode

* On Swift Dashboard Page
* Looking at pipeline "admin-pipeline" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "passed" - On Swift Dashboard page


teardown
_______________
* Capture go state "DrainModeSPA" - teardown
* With "3" live agents - teardown


