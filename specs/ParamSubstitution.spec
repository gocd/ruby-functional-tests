
ParamSubstitution
=================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "pipeline-with-wierd-command" - setup
* With "1" live agents - setup
* Capture go state "ParamSubstitution" - setup

ParamSubstitution
-----------------

tags: param, params

* Looking at pipeline "pipeline-with-wierd-command" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Failed" on pipeline with label "1" - On Swift Dashboard page

* On Job details page of pipeline "pipeline-with-wierd-command" counter "1" stage "defaultStage" counter "1" job "defaultJob"
* Verify console log contains message "some_command_that_can_never_ever_exist_with_tail"


Teardown of contexts
____________________
* Capture go state "ParamSubstitution" - teardown
* With "1" live agents - teardown
