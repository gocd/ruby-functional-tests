
ConfigMergeGitConflictForGroupAdmin
======================================

Setup of contexts
* ConfigMergeGitConflictForGroupAdmin - setup
* Login as "group1Admin" - setup
* Capture go state "ConfigMergeGitConflictForGroupAdmin" - setup

ConfigMergeGitConflictForGroupAdmin
--------------------------------------

tags:Config XML

Merge Conflict
* On Swift Dashboard Page
* Looking at pipeline "P1" - On Swift Dashboard page
* On Config XML snippets page

* Click edit Config XML - On Config XML snippets page

* Rename pipeline "P1" to "P_NEW"

* Rename pipeline "P1" to "P_conflict" - On Config XML snippets page
* Click save - On Admin Config XML page
* Verify error message "Someone has modified the configuration and your changes are in conflict. Please review, amend and retry." - Already On New Pipeline Group Popup

* Click Cancel - On Config XML snippets page

Post validation failure
* Click edit Config XML - On Config XML snippets page

* Rename pipeline "P2" to "P"

* Rename pipeline "P3" to "P" - On Config XML snippets page
* Click save - On Admin Config XML page
* Verify post validation error is shown with message "You have defined multiple pipelines called 'P'. Pipeline names must be unique."

* Click Cancel - On Config XML snippets page


Successful Merge
* Click edit Config XML - On Config XML snippets page

* Rename pipeline "P3" to "P-rename"

* Rename pipeline "P4" to "P-merge" - On Config XML snippets page
* Click save - On Admin Config XML page
* Verify the message "Saved configuration successfully. The configuration was modified by someone else, but your changes were merged successfully." is present on rails page


Teardown of contexts
____________________
* Capture go state "ConfigMergeGitConflictForGroupAdmin" - teardown
* Logout - from any page
