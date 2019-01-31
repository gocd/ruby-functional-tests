
PipelineLayoutOperatePermissions
================================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "2-stage-viewable" - setup
* With "1" live agents - setup
* Capture go state "PipelineLayoutOperatePermissions" - setup

PipelineLayoutOperatePermissions
--------------------------------

tags: pipeline layout

* Looking at pipeline "2-stage-viewable" - On Swift Dashboard page
* Trigger pipeline "2-stage-viewable" - On Swift Dashboard page
* Wait till stage "first" completed - On Swift Dashboard page
* Verify stage "first" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* On stage details page "overview" tab for "2-stage-viewable" label "1" stage name "first" counter "1"


* Wait for jobs to show "Passed: 1" with jobs "defaultJob"
* Verify rerun is enabled for stage "first"
* Verify Trigger is enabled for stage "second"

* Logout and login as "view"

* Looking at pipeline "2-stage-viewable" - On Swift Dashboard page

* On stage details page "jobs" tab for "2-stage-viewable" label "1" stage name "first" counter "1"

* Verify stage "first" does not have any action
* Verify stage "second" does not have any action

* Logout and login as "operate"

* Looking at pipeline "2-stage-viewable" - On Swift Dashboard page
* On stage details page "jobs" tab for "2-stage-viewable" label "1" stage name "first" counter "1"

* Verify rerun is enabled for stage "first"
* Verify stage "second" does not have any action



Teardown of contexts
____________________
* As user "admin" for teardown
* Capture go state "PipelineLayoutOperatePermissions" - teardown
* Logout - from any page
