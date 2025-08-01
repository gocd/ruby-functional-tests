

PipelineUnlocking-ErrorMessages
===============================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "basic-pipeline-slow, basic-pipeline-fast, viewable-pipeline, admin-pipeline, environment-pipeline, environment-pipeline-locked" - setup
* Capture go state "PipelineUnlocking-ErrorMessages" - setup

PipelineUnlocking-ErrorMessages
-------------------------------

tags: pipeline-unlocking
* As user "view"
* Verify unauthorized to unlock "admin-pipeline"
* Verify unauthorized to unlock "viewable-pipeline"
* Verify unlocking "basic-pipeline-fast" is not acceptable because "No lock exists within the pipeline configuration for"
* Verify unlocking "basic-pipeline-slow" is not acceptable because "Lock exists within the pipeline configuration but no pipeline instance is currently in progress"
* Verify unlocking "environment-pipeline-locked" is not acceptable because "Lock exists within the pipeline configuration but no pipeline instance is currently in progress"
* Verify unlocking "environment-pipeline" is not acceptable because "No lock exists within the pipeline configuration for"
* Verify unlocking "foo" fails as pipeline is not found





Teardown of contexts
____________________
* Capture go state "PipelineUnlocking-ErrorMessages" - teardown
* Logout - from any page


