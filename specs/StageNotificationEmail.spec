StageNotificationEmail
======================

Setup of contexts
* Secure Configuration - setup
* SMTP server - start
* Using pipeline "pipeline-with-failing-stage" - setup
* Login as "admin" - setup
* With "1" live agents - setup
* Capture go state "StageNotificationEmail" - setup

StageNotificationEmail
----------------------

tags: notifications, mail sending

* Configure mail server with sender "gocd-sender@gocd.test" and admin "gocd-admin@gocd.test"

* Set current user email to "admin-user@gocd.test"

* On Preferences page
* Add new notification
* Set pipeline as "pipeline-with-failing-stage"
* Set stage as "defaultStage"
* Set event as "Fails"
* Set notification for all commits
* Save notification

* Looking at pipeline "pipeline-with-failing-stage" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till stage "defaultStage" completed - On Swift Dashboard page

* Verify SMTP server received email from "gocd-sender@gocd.test" to "admin-user@gocd.test" with subject containing " failed"
* Verify SMTP server received email containing "pipeline-with-failing-stage"


Teardown of contexts
____________________
* Capture go state "StageNotificationEmail" - teardown
* Logout - from any page
* With "1" live agents - teardown
* SMTP server - stop
