PipelineGroupSnippetEdit
========================

Setup of contexts
* Group admin security configuration - setup
* Login as "group1Admin" - setup
* Capture go state "PipelineGroupSnippetEdit" - setup

PipelineGroupSnippetEdit
------------------------

tags: pipeline_group_admin

* On Config XML snippets page

Happy Path
* Verify group list has "group-name-to-be-changed,group5"
* Verify selected group is "group-name-to-be-changed"
* Edit config xml
* Change group name of "group-name-to-be-changed" to "new_group"
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
