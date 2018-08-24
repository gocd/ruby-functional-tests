PersonalizationView
============================

Setup of contexts
* Secure Configuration - setup
* Login as "pipelineSelectorAdmin" - setup
* Using pipeline "basic-pipeline-with-git-material, admin-pipeline, viewable-pipeline, manual-stages-that-run-till-file-exists, operable-pipeline, failing-pipeline" - setup
* Capture go state "PersonalizationView" - setup

PersonalizationView
----------------------------

tags: pipeline_selector, with_security, implementation_pending

* Verify current view is "Default"

* Start creating new view
* Set view name as "View1"
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

* Open pipelines selector for "View1" view
* Set view name as "View1-changed"
* Select group "basic"
* Deselect group "open-to-all"
* Apply selections

* Verify current view is "View1-changed"
* Verify group "basic" is visible - On Swift Dashboard page
* Verify group "admin-only" is visible - On Swift Dashboard page
* Verify group "viewable" is visible - On Swift Dashboard page
* Verify group "open-to-all" is not visible - On Swift Dashboard page
* Verify group "operable" is visible - On Swift Dashboard page

* Start creating new view
* Set view name as "View2"
* Verify groups "basic, admin-only, viewable, open-to-all,operable" are visible - Already on pipelines selector section
* Select filter "failed"
* Deselect all pipelines
* Select pipeline "failing-pipeline"
* Apply selections
* Verify current view is "View2"
* Looking at pipeline "failing-pipeline"
* Trigger pipeline using Pipeline API
* Verify pipeline "failing-pipeline" is not visible - On Swift Dashboard page
* Create a "failjob" file
* Verify pipeline "failing-pipeline" shows up - On Swift Dashboard page
* Verify stage "defaultStage" is "Failed" - On Swift Dashboard page

* Start creating new view
* Set view name as "View3"
* Verify groups "basic, admin-only, viewable, open-to-all,operable" are visible - Already on pipelines selector section
* Select filter "building"
* Deselect all pipelines
* Select pipeline "manual-stages-that-run-till-file-exists"
* Apply selections
* Verify current view is "View3"
* Looking at pipeline "manual-stages-that-run-till-file-exists"
* Trigger pipeline using Pipeline API
* Verify pipeline "manual-stages-that-run-till-file-exists" shows up - On Swift Dashboard page
* Verify stage "defaultStage" is "Building" - On Swift Dashboard page
* Create a "stopjob" file
* Verify pipeline "manual-stages-that-run-till-file-exists" is not visible - On Swift Dashboard page

* Delete view "View3"
* Verify view "View3" is not available

* Logout and login as "view"
* Verify current view is "Default"
* Verify view "View1,View2" is not available

Teardown of contexts
____________________
* As user "pipelineSelectorAdmin" for teardown
* Capture go state "PersonalizationView" - teardown
* Logout - from any page


