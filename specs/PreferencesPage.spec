PreferencesPage
========

PreferencesPage
--------
tags: preferences, spa

Setup of contexts
* Mailhost configuration - setup
* Login as "admin" - setup
* Looking at pipeline "basic-pipeline-with-git-material" - On Swift Dashboard page

* On Preferences page
* Verify "0" notifications are present

* Add new notification
* Set pipeline as "basic-pipeline-with-git-material"
* Set stage as "defaultStage"
* Set event as "Fails"
* Save notification
* Verify "1" notifications are present

* Add new notification
* Set event as "Breaks"
* Set notification for all commits
* Save notification
* Verify "2" notifications are present

* Delete notification "1"
* Confirm delete notification
* Verify "1" notifications are present
* Delete notification "1"
* Confirm delete notification
* Verify "0" notifications are present

teardown
_______________
* As user "admin" for teardown
* Logout - from any page

