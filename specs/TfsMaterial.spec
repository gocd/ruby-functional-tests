

TfsMaterial
===========

Setup of contexts
* Tfs configuration - setup
* Using pipeline "basic-tfs-pipeline" - setup
* With "2" live agents - setup
* Capture go state "TfsMaterial" - setup

TfsMaterial
-----------

tags: tfs

Add resource "tfs" to an agent - Using Agents API

* On Swift Dashboard Page
* Looking at pipeline "basic-tfs-pipeline" - On Swift Dashboard page
* Edit pipeline "basic-tfs-pipeline"
* Open "Materials" tab - On Pipeline settings page
* Edit material "tfs_mat"
* Make autoupdate to be "true" - Already on edit material popup
* Save Changes

* On Swift Dashboard Page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page


* Modify and checkin file "IgnoredFile.ignore.txt" as "ignoreuser" with message "should be ignored"
* Verify pipeline does not get triggered

* Modify and checkin file "Folder with space/tobeignored.txt" as "ignoreuser" with message "should be ignored again"
* Verify pipeline does not get triggered

* On Swift Dashboard Page
* Looking at pipeline "basic-tfs-pipeline" - On Swift Dashboard page
* Edit pipeline "basic-tfs-pipeline"
* Open "Materials" tab - On Pipeline settings page
* Edit material "tfs_mat"
* Invert material
* Save Changes
* On Stage settings page of pipeline "basic-tfs-pipeline" stage "defaultStage"
* Change approval type to "auto"
* Save Changes

* On Swift Dashboard Page
* Modify and checkin file "IgnoredFile.ignore.txt" as "ignoreuser" with message "should NOT be ignored"
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page
* Modify and checkin file "Folder with space/tobeignored.txt" as "ignoreuser" with message "should NOT be ignored again"
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "3" - On Swift Dashboard page


* On Swift Dashboard Page
* On Stage settings page of pipeline "basic-tfs-pipeline" stage "defaultStage"
* Change approval type to "manual"
* Save Changes

* On Swift Dashboard Page
* Looking at pipeline "basic-tfs-pipeline" - On Swift Dashboard page
* Edit pipeline "basic-tfs-pipeline"
* Open "Materials" tab - On Pipeline settings page
* Edit material "tfs_mat"
* Make autoupdate to be "false" - Already on edit material popup
* Save Changes

* On Swift Dashboard Page
* Modify and checkin file "HelloWorld.txt" as "luser" with message "interesting comment by luser"
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "4" - On Swift Dashboard page

* On stage details page "materials" tab for "basic-tfs-pipeline" label "4" stage name "defaultStage" counter "1"
* Looking at material of type "Tfs" named "tfs_mat"
* Verify modification "0" is checked with comment "interesting comment by luser"
* Verify material has changed - Already On Build Cause Section



* On Swift Dashboard Page
* Looking at pipeline "basic-tfs-pipeline" - On Swift Dashboard page
* Edit pipeline "basic-tfs-pipeline"
* Open "Materials" tab - On Pipeline settings page
* Edit material "tfs_mat"
* Enter destination directory ""
* Save Changes

* On Swift Dashboard Page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "5" - On Swift Dashboard page

* On Swift Dashboard Page
* Looking at pipeline "basic-tfs-pipeline" - On Swift Dashboard page
* Edit pipeline "basic-tfs-pipeline"
* Open "Materials" tab - On Pipeline settings page
* Edit material "tfs_mat"
* Enter destination directory "new_dest"
* Save Changes

* On Swift Dashboard Page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "6" - On Swift Dashboard page

* On Stage settings page of pipeline "basic-tfs-pipeline" stage "defaultStage"
* Select Clean working directory
* Save Changes

* On Swift Dashboard Page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "7" - On Swift Dashboard page

* On Job details page of pipeline "basic-tfs-pipeline" counter "7" stage "defaultStage" counter "1" job "defaultJob"
* Verify console log contains message "Cleaning working directory"




Teardown of contexts
_____________________
* Capture go state "TfsMaterial" - teardown
* With "2" live agents - teardown
