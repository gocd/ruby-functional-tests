
EditStage
=========

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "edit-pipeline" - setup
* Capture go state "EditStage" - setup

EditStage
---------

tags: Clicky Admin

* On Stage settings page of pipeline "edit-pipeline" stage "defaultStage"

* Set stage as "some really horrible stage name" - On Stage settings page
* Save Changes
* Verify error message "Invalid stage name 'some really horrible stage name'. This must be alphanumeric and can contain underscores, hyphens and periods (however, it cannot start with a period). The maximum allowed length is 255 characters." is shown - Already On Job Edit Page
* Set stage as "new-shiny-but-valid-stage-name" - On Stage settings page
* Save Changes
* Verify the message "Saved successfully." is present
* Verify that stage is named "new-shiny-but-valid-stage-name"

* On Stage settings page of pipeline "edit-pipeline" stage "new-shiny-but-valid-stage-name"

* Verify that stage is named "new-shiny-but-valid-stage-name"


Teardown of contexts
____________________
* Capture go state "EditStage" - teardown
* Logout - from any page



