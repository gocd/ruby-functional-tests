
PipelineLayoutStageActions
==========================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline-with-3-stages" - setup
* With "1" live agents - setup
* Capture go state "PipelineLayoutStageActions" - setup

PipelineLayoutStageActions
--------------------------

tags: pipeline layout

* Looking at pipeline "pipeline-with-3-stages" - On Swift Dashboard page
* Trigger pipeline "pipeline-with-3-stages" - On Swift Dashboard page
* Verify stage "first" is "building" - On Swift Dashboard page
* Create a "stopjob" file and validate pipeline completed
* Wait till stage "first" completed - On Swift Dashboard page
* Verify stage "first" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* On stage details page "overview" tab for "pipeline-with-3-stages" label "1" stage name "first" counter "1"


* Verify stage "first" has action "rerun"
* Verify stage "first" does not have action "trigger"
* Verify stage "first" does not have action "cancel"
* Verify stage "second" has action "trigger"
* Verify stage "second" does not have action "rerun"
* Verify stage "second" does not have action "cancel"
* Verify stage "third" does not have any action
* Rerun stage "first" - On Stage Details page

* On Swift Dashboard Page
* Verify stage "first" is "Building" on pipeline with label "1" - On Swift Dashboard page
* On stage details page "overview" tab for "pipeline-with-3-stages" label "1" stage name "first" counter "2"

* Verify stage "first" does not have action "rerun"
* Verify stage "first" does not have action "trigger"
* Verify stage "first" has action "cancel"
* Verify stage "second" does not have any action
* Verify stage "third" does not have any action
* Cancel "first" - On Stage Detail Page


* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-3-stages" - On Swift Dashboard page
* Verify stage "first" is "Cancelled" on pipeline with label "1" - On Swift Dashboard page
* On stage details page "overview" tab for "pipeline-with-3-stages" label "1" stage name "first" counter "2"

* Verify stage "first" has action "rerun"
* Verify stage "first" does not have action "trigger"
* Verify stage "first" does not have action "cancel"
* Verify stage "second" has action "trigger"
* Verify stage "second" does not have action "rerun"
* Verify stage "second" does not have action "cancel"
* Verify stage "third" does not have any action
* Trigger stage "second" - On stage details page

* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-3-stages" - On Swift Dashboard page
* Verify stage "second" is "Building" on pipeline with label "1" - On Swift Dashboard page
* On stage details page "overview" tab for "pipeline-with-3-stages" label "1" stage name "second" counter "1"

* Verify stage "first" does not have any action
* Verify stage "second" does not have action "trigger"
* Verify stage "second" does not have action "rerun"
* Verify stage "second" has action "cancel"
* Verify stage "third" does not have any action

* On Swift Dashboard Page
* Create a "stopjob" file and validate pipeline completed
* Verify stage "second" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* On stage details page "overview" tab for "pipeline-with-3-stages" label "1" stage name "second" counter "1"


* Verify stage "first" has action "rerun"
* Verify stage "first" does not have action "trigger"
* Verify stage "first" does not have action "cancel"
* Verify stage "second" has action "rerun"
* Verify stage "second" does not have action "trigger"
* Verify stage "second" does not have action "cancel"
* Verify stage "third" has action "trigger"
* Verify stage "third" does not have action "rerun"
* Verify stage "third" does not have action "cancel"

* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-3-stages" - On Swift Dashboard page
* Unlock the pipeline - On Swift Dashboard Page
* Trigger pipeline "pipeline-with-3-stages" - On Swift Dashboard page
* Verify stage "first" is "Building" on pipeline with label "2" - On Swift Dashboard page
* Create a "stopjob" file and validate pipeline completed
* Verify stage "first" is "Passed" on pipeline with label "2" - On Swift Dashboard page
* On stage details page "overview" tab for "pipeline-with-3-stages" label "1" stage name "first" counter "1"


another instance has lock
* Verify stage "first" does not have any action
* Verify stage "second" does not have any action
* Verify stage "third" does not have any action

* On Swift Dashboard Page
* On stage details page "overview" tab for "pipeline-with-3-stages" label "2" stage name "first" counter "1"


this instance has lock
* Verify stage "first" has action "rerun"
* Verify stage "first" does not have action "trigger"
* Verify stage "first" does not have action "cancel"
* Verify stage "second" has action "trigger"
* Verify stage "second" does not have action "rerun"
* Verify stage "second" does not have action "cancel"
* Verify stage "third" does not have any action


Teardown of contexts
____________________
* Capture go state "PipelineLayoutStageActions" - teardown
* Logout - from any page


