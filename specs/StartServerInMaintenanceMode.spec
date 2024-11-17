StartServerInMaintenanceMode
=========

StartServerInMaintenanceMode
-------------------
tags: maintenance_mode, retry-flaky

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "wait-for-stop-job, basic-pipeline-fast, timer-triggered" - setup
* Capture go state "StartServerInMaintenanceMode" - setup

* On Maintenance mode SPA
* Verify server is not in maintenance mode

* On Swift Dashboard Page
* Verify maintenance mode banner is not shown

* Specify system property to start GoCD Server in maintenance mode

* Logout - from any page
* Restart server
* Login as "admin"

* On Maintenance mode SPA
* Verify server is in maintenance mode

* On Swift Dashboard Page
* Verify maintenance mode banner is shown

* Remove system property to start GoCD Server in maintenance mode

* Logout - from any page
* Restart server
* Login as "admin"

* On Maintenance mode SPA
* Verify server is not in maintenance mode

* On Swift Dashboard Page
* Verify maintenance mode banner is not shown


teardown
_______________
* As user "admin" for teardown
* Maintenance mode - teardown
* Logout - from any page
* Capture go state "StartServerInMaintenanceMode" - teardown
