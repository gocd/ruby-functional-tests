
ClonePipeline
=============

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "edit-pipeline" - setup
* Capture go state "ClonePipeline" - setup

ClonePipeline
-------------

tags: Clone

* On Admin pipeline page
* Verify "basic" has pipelines "edit-pipeline"
* Click clone button for pipeline "edit-pipeline"

* Enter pipeline name "Some Invalid Pipeline"
* Verify error message "Invalid name. This must be alphanumeric and can contain hyphens, underscores and periods (however, it cannot start with a period). The maximum allowed length is 255 characters." - Already On Clone Pipeline Popup
* Enter pipeline name "cloned-pipeline"
* Enter pipeline group name "basic" - Already On Clone Pipeline pop up
* Save Cloning
* Verify pipeline "cloned-pipeline" is paused with message "Paused by admin"

* On Admin pipeline page
* Verify "basic" has pipelines "edit-pipeline,cloned-pipeline"
* Click clone button for pipeline "edit-pipeline"
* Enter pipeline name "another-cloned-pipeline"
* Enter pipeline group name "defaultGroup" - Already On Clone Pipeline pop up
* Save Cloning
* Verify pipeline "another-cloned-pipeline" is paused with message "Paused by admin"

* On Admin pipeline page
* Verify "basic" has pipelines "edit-pipeline,cloned-pipeline"
* Verify "defaultGroup" has pipelines "another-cloned-pipeline"


Teardown of contexts
____________________
* Capture go state "ClonePipeline" - teardown
* Logout - from any page
