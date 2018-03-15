PipelineDashboardAutoRefresh
============================

Setup of contexts
* Enable new dashboard toggles
* Basic Configuration - setup
* Using pipeline "basic-pipeline-run-till-file-exists" - setup
* With "1" live agents - setup
* Capture go state "PipelineDashboardAutoRefresh" - setup

PipelineDashboardAutoRefresh
----------------------------

tags: UI, refresh

* Turn on AutoRefresh - On Swift Dashboard page
* Looking at pipeline "basic-pipeline-run-till-file-exists" - On Swift Dashboard page
* Verify pipeline is in group "basic" - On Swift Dashboard page
* Verify pipeline has no history - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "1" is "Building" - On Swift Dashboard page
* Verify cannot trigger pipeline
* Create a "stopjob" file
* Verify stage "1" is "Passed" - On Swift Dashboard page
* Verify can trigger pipeline


Teardown of contexts
____________________
* Capture go state "PipelineDashboardAutoRefresh" - teardown
* With "1" live agents - teardown

