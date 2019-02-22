

ClickyAdminDirtyPageCheck
=========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "edit-pipeline" - setup
* Capture go state "ClickyAdminDirtyPageCheck" - setup

ClickyAdminDirtyPageCheck
-------------------------

tags: Clicky Admin, 4661

* On Swift Dashboard Page
* Looking at pipeline "edit-pipeline" - On Swift Dashboard page
* Edit pipeline "edit-pipeline"

Checking for textbox and checkbox
* Enter "${COUNT}-pipelinename" for label template
* Open tab "Parameters" - On Pipeline Creation Page
* Add parameter name "foo" and value "bar"
* Verify that dirty check is invoked
* Cancel dirty check prompt
* Click reset
* Open tab "General Options" - On Pipeline Creation Page
* Select automatic pipeline locking
* Open tab "Stages" - On Pipeline Creation Page
* Verify that dirty check is invoked
* Proceed with dirty check prompt

* Open stage "defaultStage"
* Select stage type as "auto"
* Click reset
* Select stage type as "auto"
* Select stage type as "manual"
* Open tab "Environment Variables" - On Pipeline Creation Page
* Proceed with dirty check prompt

* Verify heading "Environment Variables"




Teardown of contexts
____________________
* Capture go state "ClickyAdminDirtyPageCheck" - teardown



