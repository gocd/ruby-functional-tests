
ConfigMergeGitConflict
======================

Setup of contexts
* ConflictingConfiguration - setup
* Login as "admin" - setup
* Capture go state "ConfigMergeGitConflict" - setup
* Using pipeline "basic-pipeline, upstream-pipeline,middle-pipeline" - setup

ConfigMergeGitConflict
----------------------

tags: Config XML

Merge Conflict
* On Swift Dashboard Page
* Looking at pipeline "middle-pipeline" - On Swift Dashboard page
* On Admin Config XML page

* Click edit Config XML
* Delete pipeline "basic-pipeline" - Configure cruise using api

* Change config to conflict
* Click save - Already on config XML Tab
* Verify that split pane appears
* Verify error message "Configuration file has been modified by someone else." - Already On New Pipeline Group Popup


Successfull merge
* Rename pipeline "middle-pipeline" to "middle-pipeline-new"
* Click save - Already on config XML Tab
* Verify the message "Saved successfully. The configuration was modified by someone else, but your changes were merged successfully." is present

Post validation failure
* On Swift Dashboard Page
* Looking at pipeline "upstream-pipeline" - On Swift Dashboard page
* On Admin Config XML page
* Click edit Config XML
* Delete pipeline "upstream-pipeline" - Configure cruise using api
* Add downstream pipeline to create post validation conflict
* Click save - Already on config XML Tab
* Verify that split pane appears
* Verify post validation error is shown with message "Pipeline '$upstream-pipeline$' does not exist. It is used from pipeline 'downstream-pipeline'."

* Click save - Already on config XML Tab








Teardown of contexts
____________________

* Capture go state "ConfigMergeGitConflict" - teardown
* Logout - from any page
