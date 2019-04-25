

TfsPipelineLabelIncludesMaterialRevision
========================================

Setup of contexts
* Tfs configuration - setup
* Using pipeline "tfs_artifact_in_dest" - setup
* Capture go state "TfsPipelineLabelIncludesMaterialRevision" - setup

TfsPipelineLabelIncludesMaterialRevision
----------------------------------------

tags: tfs

* On Swift Dashboard Page
* Looking at pipeline "tfs_artifact_in_dest" - On Swift Dashboard page
* Edit pipeline "tfs_artifact_in_dest"


* Enter "${COUNT}-${tfs_mat}" for label template
* Save Changes

* On Swift Dashboard Page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline start building - On Swift Dashboard page
* On stage details page "jobs" tab for "tfs_artifact_in_dest" label "1" stage name "defaultStage" counter "1"

* Verify job "defaultJob" has state "Scheduled" and result "Active"

* On stage details page "materials" tab for "tfs_artifact_in_dest" label "1" stage name "defaultStage" counter "1"

* Looking at material of type "Tfs" named "tfs_mat"
* Verify current pipeline has label with counter "1" concatenated with material revision of modification "0"





Teardown of contexts
____________________
* Capture go state "TfsPipelineLabelIncludesMaterialRevision" - teardown
