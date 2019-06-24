
PipelineUsingTimerWithOnlyOnChangesOption
=========================================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "basic-pipeline-fast,downstream-pipeline" - setup
* With "1" live agents - setup
* Capture go state "PipelineUsingTimerWithOnlyOnChangesOption" - setup

PipelineUsingTimerWithOnlyOnChangesOption
-----------------------------------------

tags: timer

Changing pipeline config appropriately to use in this test

* On Swift Dashboard Page
* Looking at pipeline "downstream-pipeline" - On Swift Dashboard page
* Edit pipeline "downstream-pipeline"
* Update auto scheduling to false
* Save Changes
* Open "Materials" tab - On Pipeline settings page
* Edit material "git"
* Enter black list ""
* Save Changes

* On Swift Dashboard Page
* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "downstream-pipeline" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page


* Edit pipeline "downstream-pipeline"
* Verify only on changes checkbox is disabled
* Enter "0 0/2 * 1/1 * ? *" for cron time specifier
* Verify only on changes checkbox is enabled
* Save Changes

* On Swift Dashboard Page
* Wait till pipeline start building for "180" seconds - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" and counter "1" - On Swift Dashboard page
* Verify pipeline is triggered by "timer" - On Swift Dashboard page


* Edit pipeline "downstream-pipeline"
* Select onlyOnChanges flag to trigger pipeline only on new material
* Save Changes

* On Swift Dashboard Page
* Verify pipeline does not get triggered for "120" seconds

* With material "git" of type "git" for pipeline "downstream-pipeline"
* Checkin file "new_file.txt" as user "cceuser4" with message "comment abc" - On Swift Dashboard page
* Wait till pipeline start building for "180" seconds - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "3" and counter "1" - On Swift Dashboard page
* Verify pipeline is triggered by "timer" - On Swift Dashboard page
* On Swift Dashboard Page
* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "2" - On Swift Dashboard page
* On Swift Dashboard Page
* Looking at pipeline "downstream-pipeline" - On Swift Dashboard page
* Wait till pipeline start building for "180" seconds - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "4" and counter "1" - On Swift Dashboard page
* Verify pipeline is triggered by "timer" - On Swift Dashboard page



Teardown of contexts
____________________
* Capture go state "PipelineUsingTimerWithOnlyOnChangesOption" - teardown
* With "1" live agents - teardown
