VsmAnalyticsRerunPipelineStage
==============

tags: VSM_analytics

Setup of contexts

* Secure Configuration - setup
* Configure analytics plugin
* Login as "admin" - setup
* Using pipeline "Rerun1,Rerun2,Rerun3,Rerun4" - setup
* With "2" live agents - setup
* Capture go state "AnalyticsPlugin" - setup

VsmAnalyticsRerunPipelineStage
------------------------------------

* Looking at pipeline "Rerun1" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" - On Swift Dashboard page

* Looking at pipeline "Rerun2" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" - On Swift Dashboard page

* Looking at pipeline "Rerun3" - On Swift Dashboard page
* Create a "failjob" file and validate pipeline completed
* Verify stage "defaultStage" is "Failed" - On Swift Dashboard page
* Verify stage "defaultStage" is with label "1" - On Swift Dashboard page

* Looking at pipeline "Rerun1" - On Swift Dashboard page
* Visit pipeline VSM page and verify VSM is rendered
* Start VSM analytics selections
* Select pipeline "Rerun4" for VSM analytics
* View VSM analytics
* Verify VSM trend has "1" workflows
* Verify VSM throughput is "0%"

* Looking at pipeline "Rerun3" - On Swift Dashboard page
* On stage details page "materials" tab for "Rerun3" label "1" stage name "defaultStage" counter "1"
* Rerun stage "defaultStage" - On Stage Details page
* On Swift Dashboard Page
* Create a "stopjob" file and validate pipeline completed
* Verify stage "defaultStage" is "Passed" - On Swift Dashboard page

* Looking at pipeline "Rerun1" - On Swift Dashboard page
* Visit pipeline VSM page and verify VSM is rendered
* Start VSM analytics selections
* Select pipeline "Rerun4" for VSM analytics
* View VSM analytics
* Verify VSM trend has "1" workflows
* Verify VSM throughput is "100%"


Teardown of contexts
____________________
* As user "admin" for teardown
* Capture go state "AnalyticsPlugin" - teardown
* With "2" live agents - teardown


