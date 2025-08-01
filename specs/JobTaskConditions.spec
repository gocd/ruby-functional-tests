

JobTaskConditions
=================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "pipeline.with.runif" - setup
* With "1" live agents - setup
* Capture go state "JobTaskConditions" - setup

JobTaskConditions
-----------------

tags: runif

* On Swift Dashboard Page
* Looking at pipeline "pipeline.with.runif" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "default.stage" is "failed" on pipeline with label "1" - On Swift Dashboard page
* On Job details page of pipeline "pipeline.with.runif" counter "1" stage "default.stage" counter "1" job "job.with.runif"


First task fails, second task is runif pass, third task is runif failed and the fourth is runif all.

* Verify console log contains message "failed"
* Verify console log does not contains message "Sleeping for 30 seconds so you can see the build in the new dashboard"
* Verify console log contains message "sleep 6"
* Verify console log contains message "Hello"




Teardown of contexts
____________________
* Capture go state "JobTaskConditions" - teardown
* With "1" live agents - teardown
