ServerConfigurationMailHost
==============================

Setup of contexts
* Basic Configuration - setup
* Capture go state "ServerConfigurationMailHost" - setup
* SMTP server - start

ServerConfigurationMailHost
------------------------------

tags: server configuration, mail sending

* Configure mail server with sender "gocd-sender@gocd.test" and admin "gocd-admin@gocd.test"

* Send test email
* Verify test email connection succeeded

* Verify SMTP server received email from "gocd-sender@gocd.test" to "gocd-admin@gocd.test" with subject containing "Go Email Notification"
* Verify SMTP server received email containing "You received this configuration test email from Go Server"


Teardown of contexts
____________________
* Capture go state "ServerConfigurationMailHost" - teardown
* SMTP server - stop
