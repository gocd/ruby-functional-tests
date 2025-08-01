

JobDetailsBreadCrumbs
=====================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "breadcrumb-pipeline" - setup
* Capture go state "JobDetailsBreadCrumbs" - setup

JobDetailsBreadCrumbs
---------------------

tags: breadcrumbs

* On Swift Dashboard Page
* Looking at pipeline "breadcrumb-pipeline" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Building" - On Swift Dashboard page

* On Job details page of pipeline "breadcrumb-pipeline" counter "1" stage "defaultStage" counter "1" job "defaultJob"

* Verify breadcrumb contains pipeline "breadcrumb-pipeline"
* Verify breadcrumb contains pipeline label "1"
* Verify breadcrumb contains stage run "defaultStage / 1"
* Verify breadcrumb contains link to pipeline "breadcrumb-pipeline" settings page
* Click on stage bread crumb

* Verify that "$breadcrumb-pipeline$/1/defaultStage/1" stage is displayed
* Cancel "defaultStage" - On Stage Detail Page
* Rerun stage "defaultStage" - On Stage Details page
* Click on stage bar run "2 of 2"
* On Job details page of pipeline "breadcrumb-pipeline" counter "1" stage "defaultStage" counter "2" job "defaultJob"

* Verify breadcrumb contains pipeline "breadcrumb-pipeline"
* Verify breadcrumb contains pipeline label "1"
* Verify breadcrumb contains stage run "defaultStage / 2"
* Verify breadcrumb contains link to value stream map on pipeline label "1" for pipeline "breadcrumb-pipeline" for counter "1"
* Verify breadcrumb contains link to pipeline "breadcrumb-pipeline" settings page
* Click on stage bread crumb

* Verify that "$breadcrumb-pipeline$/1/defaultStage/2" stage is displayed
* Cancel "defaultStage" - On Stage Detail Page
* On Job details page of pipeline "breadcrumb-pipeline" counter "1" stage "defaultStage" counter "2" job "defaultJob"

* Click on pipeline bread crumb

* Verify on pipeline history page for "breadcrumb-pipeline"
* Verify breadcrumb contains link to pipeline "breadcrumb-pipeline" settings page

Teardown of contexts
____________________
* Capture go state "JobDetailsBreadCrumbs" - teardown

