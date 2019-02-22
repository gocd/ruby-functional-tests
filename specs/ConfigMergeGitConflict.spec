
ConfigMergeGitConflict
======================

Setup of contexts
* ConflictingConfiguration - setup
* Login as "admin" - setup
* Capture go state "ConfigMergeGitConflict" - setup
* Using pipeline "basic-pipeline, upstream-pipeline,middle-pipeline" - setup

ConfigMergeGitConflict
----------------------

tags: 7303, 7270, 7278

Merge Conflict
* On Admin page
* Open "Config XML" tab

* Click edit Config XML
* Delete pipeline "basic-pipeline" - Configure cruise using api

* Change config to conflict
* Save Changes
* Verify that split pane appears
* Verify error message "Configuration file has been modified by someone else." - Already On New Pipeline Group Popup


Successfull merge
* Rename pipeline "middle-pipeline" to "middle-pipeline-new"


* Save Changes
* Verify the message "Saved successfully. The configuration was modified by someone else, but your changes were merged successfully." is present

Post validation failure
* Click edit Config XML
* Delete pipeline "upstream-pipeline" - Configure cruise using api

* Add downstream pipeline to create post validation conflict
* Save Changes
* Verify that split pane appears
* Verify post validation error is shown with message "Pipeline \"${runtime_name:upstream-pipeline}\" does not exist. It is used from pipeline \"downstream-pipeline\"."
* Click save - Already on Source Xml Tab
* Verify config gets saved successfully







Teardown of contexts
____________________

* Capture go state "ConfigMergeGitConflict" - teardown
* Logout - from any page


