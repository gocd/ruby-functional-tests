

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

* Verify reset button exists
* Enter "${COUNT}-pipelinename" for label template
* Enter "0 0 22 ? * MON-FRI" for cron time specifier
* Save Changes
* Verify "Saved successfully." message is displayed
* Open tab "Materials" - On Pipeline Creation Page
* Verify "Add Material" link is present

* Open tab "Environment Variables" - On Pipeline Creation Page
* Verify reset button exists
* Enter Environment variable name "os" with value "windows"
* Save Changes

* Open tab "Parameters" - On Pipeline Creation Page

* Verify reset button exists
* Add parameter name "foo" and value "bar"
* Save Changes

* Open tab "Stages" - On Pipeline Creation Page

* Verify "defaultStage" has "Manual" trigger option with "1" jobs
* Add new stage
* Set stage as "defaultStage2" - On Add new stage pop up
* Set job name as "job1" - Already on Add New stage popup
* Add task "More.." - Already on Add New stage popup
* Set command as "bash" - Already on Add New stage popup
* Set command args as "-c\necho 'Hello World!'" - Already on Add New stage popup
* Save Changes

* Open tab "Stages" - On Pipeline Creation Page
* Verify the stages are "defaultStage2"

* On Swift Dashboard Page
* Looking at pipeline "edit-pipeline" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage2" is "Passed" with label "1" - On Swift Dashboard page


Teardown of contexts
____________________
* Capture go state "EditPipelineWizardPagesAndTabs" - teardown
* With "1" live agents - teardown
