

EditPipelineWizardPagesAndTabs
==============================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "edit-pipeline" - setup
* With "1" live agents - setup
* Capture go state "EditPipelineWizardPagesAndTabs" - setup

EditPipelineWizardPagesAndTabs
------------------------------

tags: Clicky Admin

* On Swift Dashboard Page
* Looking at pipeline "edit-pipeline" - On Swift Dashboard page
* Edit pipeline "edit-pipeline"
* Enable pipeline config spa
* Verify reset button exists
* Enter "${COUNT}-pipelinename" for label template
* Enter "0 0 22 ? * MON-FRI" for cron time specifier
* Save Changes
* Verify the message "Saved Successfully" is present

* Open "Environment Variables" tab - On Pipeline settings page
* Verify reset button exists
* Add environment variable "os" with value "windows"
* Save Changes

* Open "Parameters" tab - On Pipeline settings page

* Verify reset button exists
* Add parameter name "foo" and value "bar"
* Save Changes

* Open "Stages" tab - On Pipeline settings page

* Verify "defaultStage" has "manual" trigger option with "1" jobs
* Add new stage
* Set stage as "defaultStage2" - On Stage settings page
* Set job name as "job1" - Already on Add New Job popup
* Add task "Custom Command" - Already on Add New stage popup
* Set command as "bash" - Already on Add New stage popup
* Set command args as "-c\necho 'Hello World!'" - Already on Add New stage popup
* Save job changes

* Open "Stages" tab - On Pipeline settings page
* Verify the stages are "defaultStage2"

* On Swift Dashboard Page
* Looking at pipeline "edit-pipeline" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage2" is "Passed" with label "1" - On Swift Dashboard page


Teardown of contexts
____________________
* Capture go state "EditPipelineWizardPagesAndTabs" - teardown
* With "1" live agents - teardown
