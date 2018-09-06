PipelineSelectorWithSecurity
============================

Setup of contexts
* Secure Configuration - setup
* Login as "pipelineSelectorAdmin" - setup
* Using pipeline "basic-pipeline-with-git-material, admin-pipeline, viewable-pipeline, manual-stages-that-run-till-file-exists, operable-pipeline" - setup
* Capture go state "PipelineSelectorWithSecurity" - setup

PipelineSelectorWithSecurity
----------------------------

tags: personalization, pipeline_selector, with_security, implementation_pending

* On Swift Dashboard Page
* Verify current view is "default"
* Edit current tab
* Verify groups "basic, admin-only, viewable, open-to-all,operable" are visible
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
* Start creating new view
* Set view name as "admin-basic-view"
* Select group "basic"
* Apply selections
* Verify current view is "admin-basic-view"

* Logout and login as "view"

* Verify current view is "default"
* Verify group "basic" is visible - On Swift Dashboard page
* Verify group "viewable" is visible - On Swift Dashboard page
* Verify group "open-to-all" is visible - On Swift Dashboard page
* Verify group "admin-only" is not visible - On Swift Dashboard page
* Verify group "operable" is not visible - On Swift Dashboard page
* Verify view "admin-basic-view" is not available

* Edit current tab

* Verify groups "basic, viewable, open-to-all" are visible
* Verify groups "admin-only,operable" are not visible
* Deselect group "open-to-all"
* Apply selections

* Verify group "basic" is visible - On Swift Dashboard page
* Verify pipeline "basic-pipeline-with-git-material" shows up - On Swift Dashboard page

* Verify group "viewable" is visible - On Swift Dashboard page
* Verify group "open-to-all" is not visible - On Swift Dashboard page
* Verify group "admin-only" is not visible - On Swift Dashboard page
* Verify group "operable" is not visible - On Swift Dashboard page

* Logout and login as "pipelineSelectorAdmin"

* Verify current view is "default"
* Verify group "basic" is not visible - On Swift Dashboard page
* Verify group "open-to-all" is visible - On Swift Dashboard page
* Verify group "viewable" is visible - On Swift Dashboard page
* Verify group "admin-only" is visible - On Swift Dashboard page
* Verify group "operable" is visible - On Swift Dashboard page
* Change view to "admin-basic-view"
* Verify group "basic" is visible - On Swift Dashboard page
* Verify group "open-to-all" is not visible - On Swift Dashboard page
* Verify group "viewable" is not visible - On Swift Dashboard page
* Verify group "admin-only" is not visible - On Swift Dashboard page
* Verify group "operable" is not visible - On Swift Dashboard page

* Logout and login as "operate"

* Verify current view is "default"
* Verify group "basic" is visible - On Swift Dashboard page
* Verify group "viewable" is visible - On Swift Dashboard page
* Verify group "open-to-all" is visible - On Swift Dashboard page
* Verify group "operable" is visible - On Swift Dashboard page
* Verify group "admin-only" is not visible - On Swift Dashboard page

* Edit current tab

* Verify groups "basic, viewable, open-to-all,operable" are visible
* Verify groups "admin-only" are not visible
* Verify view "admin-basic-view" is not available

* Logout and login as "operatorUser"

* Verify current view is "default"
* Verify group "basic" is visible - On Swift Dashboard page
* Verify group "viewable" is visible - On Swift Dashboard page
* Verify group "open-to-all" is visible - On Swift Dashboard page
* Verify group "admin-only" is not visible - On Swift Dashboard page
* Verify group "operable" is not visible - On Swift Dashboard page

* Edit current tab

* Verify groups "basic, viewable, open-to-all" are visible
* Verify groups "admin-only,operable" are not visible
* Verify view "admin-basic-view" is not available


Teardown of contexts
____________________
* As user "pipelineSelectorAdmin" for teardown
* Capture go state "PipelineSelectorWithSecurity" - teardown
* Logout - from any page


