BackupGoServer
==============

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "basic-pipeline" - setup
* Capture go state "BackupGoServer" - setup

BackupGoServer
--------------

tags: backup

* On server backup page

* Verify the location of the backup store is at "serverBackups"
* Perform server backup

* Verify back up completed with message "Backup Completed"
* Verify the last performed backup message contains "Last backup was taken by 'admin' at"

* Verify the "serverBackups" directory exists
* Verify that the db backup is present in the "serverBackups" directory
* Verify the "serverBackups" directory contains "config-repo.zip" file in the tree
* Verify the "serverBackups" directory contains "config-dir.zip" file in the tree
* Verify the "serverBackups" directory contains "version.txt" file in the tree
* Verify the "serverBackups" directory contains file named "version.txt" which has running go version


Teardown of contexts
____________________
* Capture go state "BackupGoServer" - teardown
* Logout - from any page
