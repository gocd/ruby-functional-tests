
StageLocking
============

Setup of contexts
* Basic Configuration - setup
* Using pipeline "pipeline-with-lock" - setup
* With "1" live agents - setup
* Capture go state "StageLocking" - setup

StageLocking
------------

tags: stage-locking
* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-lock" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "stage-1" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* Schedule should return code "409"


* Verify stage "stage-2" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* Schedule should return code "202"








Teardown of contexts
____________________
* Capture go state "StageLocking" - teardown
* With "1" live agents - teardown


