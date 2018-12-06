PipelineGroupSnippetEdit
========================

Setup of contexts
* Group admin security configuration - setup
* Login as "group1Admin" - setup
* Capture go state "PipelineGroupSnippetEdit" - setup

PipelineGroupSnippetEdit
------------------------

tags: pipeline_group_admin

* On Admin page
* Open config tab as group admin

Happy Path
* Verify group list has "group_name_to_be_changed,group5"
* Verify selected group is "group_name_to_be_changed"
* Edit config xml
* Change group name of "group_name_to_be_changed" to "new_group"
* Verify config save is successfull
* Verify group list has "new_group,group5"
* Verify that xml snippet contains "<pipelines group=\"new_group\">"

Validations
* Verify selected group is "new_group"
* Edit config xml
* Change group name of "new_group" to "foo%#"
* Verify error message "Failed to update group 'new_group'. Name is invalid. \"foo%#\" should conform to the pattern - [a-zA-Z0-9_\\-]{1}[a-zA-Z0-9_\\-.]*"

Verify navigation
* Open config tab from admin menu
* Verify group list has "new_group,group5"



Teardown of contexts
____________________
* Capture go state "PipelineGroupSnippetEdit" - teardown


