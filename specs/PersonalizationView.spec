PersonalizationView
============================

PersonalizationView
----------------------------
tags: personalization, with_security

Setup of contexts
* Secure Configuration - setup
* Login as "pipelineSelectorAdmin" - setup
* Using pipeline "basic-pipeline-with-git-material, admin-pipeline, viewable-pipeline, manual-stages-that-run-till-file-exists, operable-pipeline, failing-pipeline" - setup
* With "1" live agents - setup
* Capture go state "PersonalizationView" - setup

* On Swift Dashboard Page
* Verify current view is "default"
* Start creating new view
* Set view name as "View1"
* Verify groups "basic, admin-only, viewable, open-to-all,operable" are visible
* Verify no pipelines are selected
* Select all pipelines
* Verify all pipelines are selected
* Deselect all pipelines
* Verify no pipelines are selected
* Select all pipelines
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

* Edit current tab
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
* Verify groups "basic, admin-only, viewable, open-to-all,operable" are visible
* Expand group "viewable"
* Select pipeline "failing-pipeline"
* Apply selections
* Verify current view is "View2"
* Trigger pipeline "failing-pipeline" - On Swift Dashboard page
* Create a "failjob" file and validate pipeline completed
* Verify current view is "View2"
* Edit current tab
* Select filter state "failed"
* Select all pipelines
* Apply selections
* Verify pipeline "failing-pipeline" shows up - On Swift Dashboard page

* Start creating new view
* Set view name as "View3"
* Verify groups "basic, admin-only, viewable, open-to-all,operable" are visible
* Expand group "open-to-all"
* Select pipeline "manual-stages-that-run-till-file-exists"
* Apply selections
* Verify current view is "View3"
* Trigger pipeline "manual-stages-that-run-till-file-exists" - On Swift Dashboard page
* Edit current tab
* Select filter state "building"
* Select all pipelines
* Apply selections
* Verify current view is "View3"
* Verify pipeline "manual-stages-that-run-till-file-exists" shows up - On Swift Dashboard page
* Create a "stopjob" file

* Delete view "View3"
* Verify view "View3" is not available

* Logout and login as "view"
* Verify current view is "Default"
* Verify view "View1,View2" is not available

Teardown of contexts
____________________
* As user "pipelineSelectorAdmin" for teardown
* Capture go state "PersonalizationView" - teardown
* With "1" live agents - teardown
* Logout - from any page


