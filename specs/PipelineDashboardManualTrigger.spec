PipelineDashboardManualTrigger
============================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "manual-stages-that-run-till-file-exists" - setup
* With "1" live agents - setup
* Capture go state "PipelineDashboardManualTrigger" - setup

PipelineDashboardManualTrigger
----------------------------

tags: UI, refresh

* Turn on AutoRefresh - On Swift Dashboard page
* Looking at pipeline "manual-stages-that-run-till-file-exists" - On Swift Dashboard page

* Verify pipeline has no history - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "firstStage" is "Building" - On Swift Dashboard page
* Verify cannot trigger pipeline

* Verify stage "firstStage" does not have a manual gate - On Swift Dashboard page
* Verify stage "secondStage" has a manual gate - On Swift Dashboard page
* Verify stage "secondStage" has a manual gate in "disabled" state with message "Can not schedule next stage - Either the previous stage hasn't run or is in progress." - On Swift Dashboard page

* Create a "stopjob" file
* Verify stage "firstStage" is "Passed" - On Swift Dashboard page
* Delete stopjob file
* Verify stage "firstStage" does not have a manual gate - On Swift Dashboard page
* Verify stage "secondStage" has a manual gate - On Swift Dashboard page

* Verify stage "secondStage" has a manual gate in "enabled" state with message "Awaiting approval. Waiting for users with the operate permission to schedule 'secondStage' stage" - On Swift Dashboard page

* Manually trigger stage "secondStage" - On Swift Dashboard page

* Verify stage "secondStage" has a manual gate in "disabled" state with message "Approved by 'admin'" - On Swift Dashboard page
* Create a "stopjob" file
* Verify stage "secondStage" is "Passed" - On Swift Dashboard page
* Delete stopjob file

* Trigger pipeline - On Swift Dashboard page
* Verify stage "firstStage" is "Building" - On Swift Dashboard page
* Verify cannot trigger pipeline

* Logout and login as "user1"
* Looking at pipeline "manual-stages-that-run-till-file-exists" - On Swift Dashboard page

* Verify stage "firstStage" does not have a manual gate - On Swift Dashboard page
* Verify stage "secondStage" has a manual gate - On Swift Dashboard page
* Verify stage "secondStage" has a manual gate in "disabled" state with message "Can not schedule next stage - You don't have permissions to schedule the next stage." - On Swift Dashboard page

* Create a "stopjob" file
* Verify stage "firstStage" is "Passed" - On Swift Dashboard page
* Verify stage "firstStage" does not have a manual gate - On Swift Dashboard page
* Verify stage "secondStage" has a manual gate - On Swift Dashboard page

* Verify stage "secondStage" has a manual gate in "disabled" state with message "Can not schedule next stage - You don't have permissions to schedule the next stage." - On Swift Dashboard page

Teardown of contexts
____________________
* Capture go state "PipelineDashboardManualTrigger" - teardown
* Logout - from any page
* With "1" live agents - teardown
