
EditJob
=======

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "edit-pipeline" - setup
* Capture go state "EditJob" - setup

EditJob
-------

tags: Clicky Admin

* On Job settings page of pipeline "edit-pipeline" stage "defaultStage" job "defaultJob"
* Open "Job Settings" tab - On Job settings page
* Set job as "some really bad name" - On Job settings page
* Save Job Settings
* Verify error message "Invalid job name 'some really bad name'. This must be alphanumeric and may contain underscores and periods. The maximum allowed length is 255 characters." is shown - Already On Job Edit Page
* Set job as "new-shiny-but-valid-job-name" - On Job settings page
* Save Job Settings
* Verify the message "Saved successfully." is present

* Verify that job is named "new-shiny-but-valid-job-name"

* Open "Custom Tabs" tab - On Job settings page

* Enter custom tab name "first-tab" with path "some-path"
* Save Changes
* Verify the message "Saved successfully." is present
* Enter custom tab name "first-tab" with path "some-path"
* Save Changes
* Verify the message "Save failed, see errors below" is present
* Verify error message "Tab name 'first-tab' is not unique." on name on tab "1"
* Verify error message "Tab name 'first-tab' is not unique." on name on tab "2"


Teardown of contexts
____________________
* Capture go state "EditJob" - teardown
* Logout - from any page


