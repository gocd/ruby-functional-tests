
TfsArtifactUpload
=================

Setup of contexts
* Tfs configuration - setup
* Using pipeline "tfs_artifact_in_dest,tfs_artifact_in_child_directory,tfs_generated_file_gets_deleted" - setup
* With "1" live agents - setup
* Capture go state "TfsArtifactUpload" - setup

TfsArtifactUpload
-----------------

tags: tfs

Rajeshvaran's Regression Suite - 7.1.1 - artifacts are generated in the working folder of TFS on agent
* On Swift Dashboard Page
* Looking at pipeline "tfs_artifact_in_dest" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page
* On Stage settings page of pipeline "tfs_artifact_in_dest" stage "defaultStage"
* Select Clean working directory
* Save Changes

* On Swift Dashboard Page
* Looking at pipeline "tfs_artifact_in_dest" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page

* Looking at pipeline "tfs_artifact_in_child_directory" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* Looking at pipeline "tfs_generated_file_gets_deleted" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Failed" on pipeline with label "1" - On Swift Dashboard page


Teardown of contexts
____________________
* Capture go state "TfsArtifactUpload" - teardown
* With "1" live agents - teardown
