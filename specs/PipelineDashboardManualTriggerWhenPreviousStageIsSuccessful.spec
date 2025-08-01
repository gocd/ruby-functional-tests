PipelineDashboardManualTriggerWhenPreviousStageIsSuccessful
============================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "manual-stages-with-previous-stage-successful" - setup
* With "1" live agents - setup
* Capture go state "PipelineDashboardManualTriggerWhenPreviousStageIsSuccessful" - setup

PipelineDashboardManualTriggerWhenPreviousStageIsSuccessful
----------------------------

tags: UI, refresh

* Turn on AutoRefresh - On Swift Dashboard page
* Looking at pipeline "manual-stages-with-previous-stage-successful" - On Swift Dashboard page

* Verify pipeline has no history - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "firstStage" is "Building" - On Swift Dashboard page
* Verify cannot trigger pipeline

* Verify stage "firstStage" does not have a manual gate - On Swift Dashboard page
* Verify stage "secondStage" has a manual gate - On Swift Dashboard page
* Verify stage "secondStage" has a manual gate in "disabled" state with message "Can not schedule next stage - Either the previous stage hasn't run or is in progress." - On Swift Dashboard page

* On stage details page "overview" tab for "manual-stages-with-previous-stage-successful" label "1" stage name "firstStage" counter "1"

* Cancel "firstStage" - On Stage Detail Page

* On Swift Dashboard Page

* Verify stage "firstStage" is "Cancelled" - On Swift Dashboard page
* Verify stage "firstStage" does not have a manual gate - On Swift Dashboard page

* Verify stage "secondStage" has a manual gate - On Swift Dashboard page
* Verify stage "secondStage" has a manual gate in "disabled" state with message "Can not schedule next stage - stage 'secondStage' is set to run only on success of previous stage, whereas, the previous stage 'firstStage' has Cancelled." - On Swift Dashboard page

* Trigger pipeline - On Swift Dashboard page
* Verify stage "firstStage" is "Building" - On Swift Dashboard page
* Create a "stopjob" file
* Verify stage "firstStage" is "Passed" - On Swift Dashboard page

* Verify stage "secondStage" has a manual gate - On Swift Dashboard page
* Verify stage "secondStage" has a manual gate in "enabled" state with message "Awaiting approval. Waiting for users with the operate permission to schedule 'secondStage' stage" - On Swift Dashboard page


Teardown of contexts
____________________
* Logout - from any page
* With "1" live agents - teardown
* Capture go state "PipelineDashboardManualTriggerWhenPreviousStageIsSuccessful" - teardown
