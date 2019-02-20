

EditPipelineWizardPagesAndTabs
==============================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "edit-pipeline" - setup
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
* Open tab "Project Management" - On Pipeline Creation Page

* Verify reset button exists
* Select tracking tool as "mingle"
* Set mingle URL as "https://mingle09.thoughtworks.com"
* Set mingle project identifier as "go"
* Set MQA grouping conditions as "select from CARD"
* Save Changes
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
* Set job name as "job1" - on Job popup
* Add task "More.." - Already on Add New Job popup
* Set command as "ls" - On Job popup
* Save Changes

* Open tab "Stages" - On Pipeline Creation Page
* Verify the stages are "defaultStage2"





Teardown of contexts
____________________
* Capture go state "EditPipelineWizardPagesAndTabs" - teardown



