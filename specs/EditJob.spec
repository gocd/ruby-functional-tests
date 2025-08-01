
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
* Save Changes
* Verify error message "Invalid name. This must be alphanumeric and can contain hyphens, underscores and periods (however, it cannot start with a period). The maximum allowed length is 255 characters." is shown for job name
* Set job as "new-shiny-but-valid-job-name" - On Job settings page
* Save Changes
* Verify the message "Saved Successfully!" is present

* Reload page
* Verify that job is named "new-shiny-but-valid-job-name"

* Open "Custom Tabs" tab - On Job settings page
* Enter custom tab name "first-tab" with path "some-path"
* Save Changes
* Verify the message "Saved Successfully!" is present

* Add a custom tab
* Enter custom tab name "first-tab" with path "some-path"
* Save Changes
* Verify the error message "Error(s): [Validation failed.]. Please correct and resubmit." is present
* Verify error message "Tab name 'first-tab' is not unique." on name on tab "1"
* Verify error message "Tab name 'first-tab' is not unique." on name on tab "2"


Teardown of contexts
____________________
* Logout - from any page
* Capture go state "EditJob" - teardown


