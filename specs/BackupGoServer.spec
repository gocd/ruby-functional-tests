BackupGoServer
==============

Setup of contexts
* Secure Configuration - setup
* SMTP server - start
* Login as "admin" - setup
* Using pipeline "basic-pipeline" - setup
* Capture go state "BackupGoServer" - setup

BackupGoServer
--------------

tags: backup, mail sending

* Configure mail server with sender "gocd-sender@gocd.test" and admin "gocd-admin@gocd.test"

* On server backup page
* Enable backup email notifications

* Verify the location of the backup store is at "serverBackups"
* Perform server backup

* Verify back up completed with message "Backup was generated successfully."
* Verify the last performed backup message contains "Last backup was taken by 'admin' at"

* Verify the "serverBackups" directory exists
* Verify that the db backup is present in the "serverBackups" directory
* Verify the "serverBackups" directory contains "config-repo.zip" file in the tree
* Verify the "serverBackups" directory contains "config-dir.zip" file in the tree
* Verify the "serverBackups" directory contains "version.txt" file in the tree
* Verify the "serverBackups" directory contains file named "version.txt" which has running go version

* Verify SMTP server received email from "gocd-sender@gocd.test" to "gocd-admin@gocd.test" with subject containing "Server Backup Completed Successfully"
* Verify SMTP server received email containing "This backup was triggered by 'admin'"


Teardown of contexts
____________________
* Capture go state "BackupGoServer" - teardown
* Logout - from any page
* SMTP server - stop
