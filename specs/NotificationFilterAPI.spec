NotificationFilterAPI
=====================

NotificationFilterAPI
---------------------
tags: notification_filter, api

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "admin-pipeline, admin-pipeline-api" - setup
* Capture go state "NotificationFilterAPI" - setup

* As user "admin"

* On Server Configuration page

* On Email server configuration

* Set SMTP server hostname as "chimisc01.thoughtworks.com"
* Set SMTP server port as "25"
* Enable SMTPs
* Set SMTP server username as "gauge"
* Set SMTP server password as "tester"
* Set sender email as "ccedev@thoughtworks.com"
* Set administrator email as "admin@thoughtworks.com"

* Save Server Configuration

* Verify server configuration save is successful


* Create notification filter for pipeline "admin-pipeline" stage "defaultStage" event "All" and match commit "False"
* Verify returned "200" response code
* Get notification filter "1"
* Verify returned "200" response code
* Verify notification filter is set for pipeline "admin-pipeline" stage "defaultStage" event "All" and match commit "False"

* Create notification filter for pipeline "admin-pipeline-api" stage "defaultStage" event "Fails" and match commit "True"
* Verify returned "200" response code

* List all notification filter should show "1, 2" filters

* Update notification filter "1" by changing the "event" to "Breaks"
* Get notification filter "1"
* Verify returned "200" response code
* Verify notification filter is set for pipeline "admin-pipeline" stage "defaultStage" event "Breaks" and match commit "false"

* Delete notification filter "2"
* List all notification filter should show "1" filters

* Create notification filter for pipeline "non-existing-pipeline" stage "defaultStage" event "Fails" and match commit "True"
* Verify returned "422" response code

* Create notification filter for pipeline "admin-pipeline" stage "nonExistingStage" event "Fails" and match commit "True"
* Verify returned "422" response code

* As user "group1Admin"

* Create notification filter for pipeline "admin-pipeline" stage "defaultStage" event "All" and match commit "False"
* Verify returned "200" response code
* Get notification filter "3"
* Verify returned "200" response code
* Verify notification filter is set for pipeline "admin-pipeline" stage "defaultStage" event "All" and match commit "False"

* Create notification filter for pipeline "admin-pipeline-api" stage "defaultStage" event "Fixed" and match commit "True"
* Verify returned "200" response code

* List all notification filter should show "3, 4" filters

* Update notification filter "3" by changing the "event" to "Cancelled"
* Get notification filter "3"
* Verify returned "200" response code
* Verify notification filter is set for pipeline "admin-pipeline" stage "defaultStage" event "Cancelled" and match commit "false"

* Delete notification filter "3"
* List all notification filter should show "4" filters

* As user "view"

* Get notification filter "1"
* Verify returned "404" response code

* Create notification filter for pipeline "admin-pipeline" stage "defaultStage" event "All" and match commit "False"
* Verify returned "200" response code
* Get notification filter "5"
* Verify returned "200" response code
* Verify notification filter is set for pipeline "admin-pipeline" stage "defaultStage" event "All" and match commit "False"

* Create notification filter for pipeline "admin-pipeline-api" stage "defaultStage" event "Fails" and match commit "True"
* Verify returned "200" response code

* List all notification filter should show "5, 6" filters

* Update notification filter "5" by changing the "event" to "Fails"
* Get notification filter "5"
* Verify returned "200" response code
* Verify notification filter is set for pipeline "admin-pipeline" stage "defaultStage" event "Fails" and match commit "false"

* Delete notification filter "5"
* List all notification filter should show "6" filters

* Create notification filter for pipeline "[Any Pipeline]" stage "[Any Stage]" event "Fails" and match commit "False"
* Verify returned "200" response code


teardown
_______________
* As user "admin" for teardown
* Capture go state "NotificationFilterAPI" - teardown
* Logout - from any page
