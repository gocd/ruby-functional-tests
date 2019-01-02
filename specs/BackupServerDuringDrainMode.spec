BackupServerDuringDrainMode
=========

BackupServerDuringDrainMode
-------------------
tags: drain_mode

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "basic-pipeline-fast" - setup
* With "1" live agents - setup
* Capture go state "DrainModeSPA" - setup

* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "passed" - On Swift Dashboard page

* On Drain mode SPA
* Enable drain mode
* Verify drain mode completed

* On server backup page
* Perform server backup
* Verify back up completed with message "Backup was generated successfully."

* Logout - from any page
* Restart server
* Login as "admin"

* On Drain mode SPA
* Verify server is not in drain mode


teardown
_______________
* As user "admin" for teardown
* Drain mode - teardown
* Logout - from any page
* Capture go state "DrainModeSPA" - teardown
* With "1" live agents - teardown



