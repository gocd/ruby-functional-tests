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

* Set pipeline as "basic-pipeline-with-git-material"
* Set stage as "defaultStage"
* Set event as "Fails"
* Add notification
* Verify "1" notifications are present

* Reload page
* Set event as "Breaks"
* Set notification for all commits
* Add notification
* Verify "2" notifications are present

* Delete notification "1"
* Verify "1" notifications are present
* Delete notification "1"
* Verify "0" notifications are present

teardown
_______________
* As user "admin" for teardown
* Logout - from any page

