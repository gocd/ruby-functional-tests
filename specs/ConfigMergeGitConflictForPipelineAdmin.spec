
ConfigMergeGitConflictForPipelineAdmin
======================================

Setup of contexts
* ConflictingConfigurationForPipelineAdmin - setup
* Login as "group1Admin" - setup
* Capture go state "ConfigMergeGitConflictForPipelineAdmin" - setup

ConfigMergeGitConflictForPipelineAdmin
--------------------------------------

tags:Config XML

Merge Conflict
* On Swift Dashboard Page
* Looking at pipeline "P1" - On Swift Dashboard page
* On Config XML snippets page

* Click edit Config XML


* Rename pipeline "P1" to "P_NEW"

* Rename pipeline "P1" to "P_conflict" - Already On Pipeline Group Xml
* Click save - Already on config XML Tab
* Verify error message "Someone has modified the configuration and your changes are in conflict. Please review, amend and retry." - Already On New Pipeline Group Popup

* Click Cancel - Already on group admin config XML Tab

Post validation failure
* Click edit Config XML

* Rename pipeline "P2" to "P"

* Rename pipeline "P3" to "P" - Already On Pipeline Group Xml
* Click save - Already on config XML Tab
* Verify post validation error is shown with message "You have defined multiple pipelines called 'P'. Pipeline names must be unique."

* Click Cancel - Already on group admin config XML Tab


Successful Merge
* Click edit Config XML

* Rename pipeline "P3" to "P-rename"

* Rename pipeline "P4" to "P-merge" - Already On Pipeline Group Xml
* Click save - Already on config XML Tab
* Verify the message "Saved configuration successfully. The configuration was modified by someone else, but your changes were merged successfully." is present


Teardown of contexts
____________________
* Capture go state "ConfigMergeGitConflictForPipelineAdmin" - teardown
* Logout - from any page
