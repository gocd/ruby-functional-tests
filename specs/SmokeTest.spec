SmokeTest
=========

SmokeTest
-------------------
tags: smoke, run-on-docker

Setup of contexts
* Smoke Configuration - setup
* Login as "admin" - setup
* Using pipeline "basic-pipeline-with-git-material" - setup
* With "1" live agents - setup
* Capture go state "SmokeTest" - setup

* Looking at pipeline "basic-pipeline-with-git-material" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" - On Swift Dashboard page

* On Preferences page
* Verify page title is "Preferences"

teardown
_______________
* With "1" live agents - teardown
* Capture go state "SmokeTest" - teardown
