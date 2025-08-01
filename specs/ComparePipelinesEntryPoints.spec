

ComparePipelinesEntryPoints
===========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "basic-environment-pipeline" - setup
* With "1" live agents - setup
* Capture go state "ComparePipelinesEntryPoints" - setup

ComparePipelinesEntryPoints
---------------------------

tags: compare_pipeline
* On Swift Dashboard Page
* Looking at pipeline "basic-environment-pipeline" - On Swift Dashboard page
* Trigger and cancel stage "defaultStage" "2" times
* On stage details page "overview" tab for "basic-environment-pipeline" label "2" stage name "defaultStage" counter "1"
* Verify stage history has "2, 1"
* Click compare link for pipeline counter "1"
* Verify that to pipeline textbox is populated with "1"
* Verify that from pipeline textbox is populated with "2"
* On Swift Dashboard Page
* On Pipeline Compare page from "1" build to "2"

Simple case of comparison
* Verify that to pipeline textbox is populated with "2"
* Verify that from pipeline textbox is populated with "1"

* On Swift Dashboard Page
* On stage details page "overview" tab for "basic-environment-pipeline" label "2" stage name "defaultStage" counter "1"
* Click Compare pipeline link - Already on stage details page
* Verify that to pipeline textbox is populated with "2"
* Verify that from pipeline textbox is populated with "1"




Teardown of contexts
____________________
* Capture go state "ComparePipelinesEntryPoints" - teardown
* With "1" live agents - teardown
