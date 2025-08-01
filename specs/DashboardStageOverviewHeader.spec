DashboardStageOverviewHeader
============

Setup of contexts

* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "VSM1" - setup
* With "2" live agents - setup
* Capture go state "DashboardStageOverviewHeader" - setup

DashboardStageOverviewHeader
------------

tags: stage-overview, UI, refresh

* Looking at pipeline "VSM1" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page

* Open stage overview for stage "defaultStage" - On Swift Dashboard page
* Verify stage overview has header "VSM1" "1" "defaultStage" "1"
* Verify stage overview renders stage triggered by "admin"
* Verify stage overview renders triggered by time and duration
* Verify stage overview renders rerun stage button in enabled state
* Verify stage overview renders stage settings button in enabled state

* Go to stage settings page from stage overview and verify page url for stage "defaultStage"

* On Swift Dashboard Page
* Looking at pipeline "VSM1" - On Swift Dashboard page
* Open stage overview for stage "defaultStage" - On Swift Dashboard page

* Go to stage details page from stage overview and verify page url for stage "defaultStage" "1"

* On Swift Dashboard Page
* Looking at pipeline "VSM1" - On Swift Dashboard page
* Open stage overview for stage "defaultStage" - On Swift Dashboard page

* Rerun stage from stage overview
* Verify stage overview has header "VSM1" "1" "defaultStage" "2"

* Verify stage overview renders cancel stage button in enabled state

* Cancel stage from stage overview

* Verify stage overview renders stage cancelled by "admin"
* Verify stage overview renders cancelled by time

* Go to stage details page from stage overview and verify page url for stage "defaultStage" "2"

* On Swift Dashboard Page
* Looking at pipeline "VSM1" - On Swift Dashboard page
* Open stage overview for stage "defaultStage" - On Swift Dashboard page


* Logout and login as "view"
* On Swift Dashboard Page
* Looking at pipeline "VSM1" - On Swift Dashboard page

* Open stage overview for stage "defaultStage" - On Swift Dashboard page
* Verify stage overview has header "VSM1" "1" "defaultStage" "2"
* Verify stage overview renders stage triggered by "admin"
* Verify stage overview renders triggered by time and duration
* Verify stage overview renders rerun stage button in disabled state
* Verify stage overview renders stage settings button in disabled state

* Go to stage details page from stage overview and verify page url for stage "defaultStage" "2"

Teardown of contexts
____________________
* As user "admin" for teardown
* With "2" live agents - teardown
* Capture go state "DashboardStageOverviewHeader" - teardown
