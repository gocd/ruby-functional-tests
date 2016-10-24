SmokeTest
=========

SmokeTest
-------------------
tags: smoke

Setup of contexts
* SmokeConfiguration - setup
* Login as "admin" - setup
* Using pipeline "basic-pipeline-with-git-material" - setup
* With "1" live agents - setup
* Capture go state "SmokeTest" - setup


* Trigger "basic-pipeline-with-git-material"
* Looking at pipeline "basic-pipeline-with-git-material"
* Verify stage "1" is "Passed" on pipeline with label "1"

teardown
_______________
* Capture go state "SmokeTest" - teardown
* With "1" live agents - teardown
