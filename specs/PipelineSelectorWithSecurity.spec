PipelineSelectorWithSecurity
============================

Setup of contexts
* Secure Configuration - setup
* Login as "pipelineSelectorAdmin" - setup
* Using pipeline "basic-pipeline-with-git-material, admin-pipeline, viewable-pipeline, manual-stages-that-run-till-file-exists, operable-pipeline" - setup
* Capture go state "PipelineSelectorWithSecurity" - setup

PipelineSelectorWithSecurity
----------------------------

tags: pipeline_selector, with_security, implementation_pending

* Verify current view is "Default"


* Open pipelines selector for "Default" view
* Verify groups "basic, admin-only, viewable, open-to-all,operable" are visible - Already on pipelines selector section
* Verify all pipelines are selected
* Deselect all pipelines
* Verify no pipelines are selected
* Select all pipelines
* Verify all pipelines are selected
* Deselect group "basic"
* Verify "basic" is deselected
* Expand group "basic"
* Verify all pipelines in group "basic" are deselected
* Expand group "open-to-all"
* Deselect pipeline "manual-stages-that-run-till-file-exists"
* Verify "open-to-all" is deselected
* Select pipeline "manual-stages-that-run-till-file-exists"
* Verify "open-to-all" is selected
* Apply selections

* Verify group "basic" is not visible - On Swift Dashboard page
* Verify group "admin-only" is visible - On Swift Dashboard page
* Verify group "viewable" is visible - On Swift Dashboard page
* Verify group "open-to-all" is visible - On Swift Dashboard page
* Verify group "operable" is visible - On Swift Dashboard page
* Create a view "admin-basic-view" and add gorup "basic"
* Verify current view is "admin-basic-view"

* Logout and login as "view"

* Verify current view is "Default"
* Verify group "basic" is visible - On Swift Dashboard page
* Verify group "viewable" is visible - On Swift Dashboard page
* Verify group "open-to-all" is visible - On Swift Dashboard page
* Verify group "admin-only" is not visible - On Swift Dashboard page
* Verify group "operable" is not visible - On Swift Dashboard page
* Verify view "admin-basic-view" is not available

* Open pipelines selector for "Default" view

* Verify groups "basic, viewable, open-to-all" are visible - Already on pipelines selector section
* Verify groups "admin-only,operable" are not visible - Already on pipelines selector section
* Deselect group "open-to-all"
* Apply selections

* Verify group "basic" is visible - On Swift Dashboard page
* Verify pipeline "basic-pipeline-with-git-material" shows up - On Swift Dashboard page

* Verify group "viewable" is visible - On Swift Dashboard page
* Verify group "open-to-all" is not visible - On Swift Dashboard page
* Verify group "admin-only" is not visible - On Swift Dashboard page
* Verify group "operable" is not visible - On Swift Dashboard page

* Logout and login as "pipelineSelectorAdmin"

* Verify current view is "Default"
* Verify group "basic" is not visible - On Swift Dashboard page
* Verify group "open-to-all" is visible - On Swift Dashboard page
* Verify group "viewable" is visible - On Swift Dashboard page
* Verify group "admin-only" is visible - On Swift Dashboard page
* Verify group "operable" is visible - On Swift Dashboard page
* Switch to view "admin-basic-view"
* Verify group "basic" is visible - On Swift Dashboard page
* Verify group "open-to-all" is not visible - On Swift Dashboard page
* Verify group "viewable" is not visible - On Swift Dashboard page
* Verify group "admin-only" is not visible - On Swift Dashboard page
* Verify group "operable" is not visible - On Swift Dashboard page

* Logout and login as "operate"

* Verify current view is "Default"
* Verify group "basic" is visible - On Swift Dashboard page
* Verify group "viewable" is visible - On Swift Dashboard page
* Verify group "open-to-all" is visible - On Swift Dashboard page
* Verify group "operable" is visible - On Swift Dashboard page
* Verify group "admin-only" is not visible - On Swift Dashboard page

* Open pipelines selector for "Default" view

* Verify groups "basic, viewable, open-to-all,operable" are visible - Already on pipelines selector section
* Verify groups "admin-only" are not visible - Already on pipelines selector section
* Verify view "admin-basic-view" is not available

* Logout and login as "operatorUser"

* Verify current view is "Default"
* Verify group "basic" is visible - On Swift Dashboard page
* Verify group "viewable" is visible - On Swift Dashboard page
* Verify group "open-to-all" is visible - On Swift Dashboard page
* Verify group "admin-only" is not visible - On Swift Dashboard page
* Verify group "operable" is not visible - On Swift Dashboard page

* Open pipelines selector for "Default" view

* Verify groups "basic, viewable, open-to-all" are visible - Already on pipelines selector section
* Verify groups "admin-only,operable" are not visible - Already on pipelines selector section
* Verify view "admin-basic-view" is not available


Teardown of contexts
____________________
* As user "pipelineSelectorAdmin" for teardown
* Capture go state "PipelineSelectorWithSecurity" - teardown
* Logout - from any page


