ComparePipelineTimelineView
===========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "edit-pipeline" - setup
* Capture go state "ComparePipelineTimelineView" - setup

ComparePipelineTimelineView
---------------------------

tags: compare_pipeline

* Looking at pipeline "edit-pipeline" - On Swift Dashboard page
* Trigger and cancel stage "defaultStage" "12" times
* On Pipeline Compare page from "12" build to "12"

Basic functionality
 
* Verify that to pipeline textbox is populated with "12"
* Verify that from pipeline textbox is populated with "12"
* Click to browse the timeline on to suggestion box
* Verify selected pipeline label is "12"
* Verify that page has pipeline range "12" to "3"
* Click page "2" - On Pipeline Compare page
* Verify that page has pipeline range "2" to "1"
* Choose and select pipeline with label "1"

* Verify that to pipeline textbox is populated with "1"
* Verify that from pipeline textbox is populated with "12"
* Click to browse the timeline on from suggestion box
* Verify selected pipeline label is "12"
* Choose and select pipeline with label "3"

* Verify that to pipeline textbox is populated with "1"
* Verify that from pipeline textbox is populated with "3"


Teardown of contexts
____________________
* Capture go state "ComparePipelineTimelineView" - teardown
