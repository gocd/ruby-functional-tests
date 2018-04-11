PipelineSelectorWithSecurity
============================

Setup of contexts
* Enable new dashboard toggles
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "basic-pipeline-with-git-material, admin-pipeline, viewable-pipeline, manual-stages-that-run-till-file-exists, operable-pipeline" - setup
* Capture go state "PipelineSelectorWithSecurity" - setup

PipelineSelectorWithSecurity
----------------------------

tags: pipeline_selector, with_security

* Turn on AutoRefresh - On Swift Dashboard page
* Open pipelines selector - On Swift Dashboard page

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

* Logout and login as "view"

* Verify group "basic" is visible - On Swift Dashboard page
* Verify group "viewable" is visible - On Swift Dashboard page
* Verify group "open-to-all" is visible - On Swift Dashboard page
* Verify group "admin-only" is not visible - On Swift Dashboard page
* Verify group "operable" is not visible - On Swift Dashboard page

* Open pipelines selector - On Swift Dashboard page

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

* Logout and login as "admin"

* Verify group "basic" is not visible - On Swift Dashboard page
* Verify group "open-to-all" is visible - On Swift Dashboard page
* Verify group "viewable" is visible - On Swift Dashboard page
* Verify group "admin-only" is visible - On Swift Dashboard page
* Verify group "operable" is visible - On Swift Dashboard page

* Open pipelines selector - On Swift Dashboard page

* Verify groups "basic, admin-only, viewable, open-to-all, operable" are visible - Already on pipelines selector section

* Logout and login as "operate"

* Verify group "basic" is visible - On Swift Dashboard page
* Verify group "viewable" is visible - On Swift Dashboard page
* Verify group "open-to-all" is visible - On Swift Dashboard page
* Verify group "operable" is visible - On Swift Dashboard page
* Verify group "admin-only" is not visible - On Swift Dashboard page

* Open pipelines selector - On Swift Dashboard page

* Verify groups "basic, viewable, open-to-all,operable" are visible - Already on pipelines selector section
* Verify groups "admin-only" are not visible - Already on pipelines selector section

* Logout and login as "operatorUser"
* Verify group "basic" is visible - On Swift Dashboard page
* Verify group "viewable" is visible - On Swift Dashboard page
* Verify group "open-to-all" is visible - On Swift Dashboard page
* Verify group "admin-only" is not visible - On Swift Dashboard page
* Verify group "operable" is not visible - On Swift Dashboard page

* Open pipelines selector - On Swift Dashboard page

* Verify groups "basic, viewable, open-to-all" are visible - Already on pipelines selector section
* Verify groups "admin-only,operable" are not visible - Already on pipelines selector section



Teardown of contexts
____________________
* Logout and login as "admin"
* Capture go state "PipelineSelectorWithSecurity" - teardown


