PipelinesUsingTimer
===================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "basic-pipeline-fast" - setup
* With "1" live agents - setup
* Capture go state "PipelinesUsingTimer" - setup

PipelinesUsingTimer
-------------------

tags:timer

Setting a timer that will never actually trigger the pipeline. (Assuming time travel will not happen within this twist test)
* On Swift Dashboard Page
* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Using timer with spec "* * * * * ? 2021"
* Setting first stage to auto approval

* On Swift Dashboard Page
* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page


* With material "git" of type "git" for pipeline "basic-pipeline-fast"
* Checkin file "foo.txt" as user "twist" with message "Added foo.txt" - On Swift Dashboard page


* On Swift Dashboard Page
* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page



Setting a timer that will constantly trigger the pipeline.

* Using timer with spec "0/30 * * * * ? *"
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "3" and counter "1" - On Swift Dashboard page

* Pause pipeline with reason "prevent another timer trigger before verification" - On Swift Dashboard page
* Verify pipeline is paused with reason "prevent another timer trigger before verification" by "anonymous" - On Swift Dashboard page
* Verify pipeline is triggered by "timer" - On Swift Dashboard page





Teardown of contexts
____________________
* Capture go state "PipelinesUsingTimer" - teardown
* With "1" live agents - teardown


