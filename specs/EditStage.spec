
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
* Verify error message "Invalid name. This must be alphanumeric and can contain hyphens, underscores and periods (however, it cannot start with a period). The maximum allowed length is 255 characters." is shown for stage name
* Set stage as "new-shiny-but-valid-stage-name" - On Stage settings page
* Save Changes
* Verify the message "Saved Successfully" is present
* Verify that stage is named "new-shiny-but-valid-stage-name"

* On Stage settings page of pipeline "edit-pipeline" stage "new-shiny-but-valid-stage-name"

* Verify that stage is named "new-shiny-but-valid-stage-name"


Teardown of contexts
____________________
* Logout - from any page
* Capture go state "EditStage" - teardown



