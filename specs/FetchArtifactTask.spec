

FetchArtifactTask
=================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "downstream-pipeline,basic-pipeline-fast" - setup
* Capture go state "FetchArtifactTask" - setup

FetchArtifactTask
-----------------

tags: Fetch Artifact

* On Job settings page of pipeline "downstream-pipeline" stage "defaultStage" job "defaultJob"



* Add task "Fetch Artifact"
* Set task pipeline as "$basic-pipeline-fast$"
* Set task stage as "defaultStage"
* Set task job as "defaultJob"
* Set task source file as "source_file"
* Check source is a file option
* Set task destination  as "dest_dir"
* Save Changes

* verifyTask
|Order_no|Task Type         |Run If Conditions |Properties                                                                                                                            |On Cancel     |
|--------|------------------|------------------|--------------------------------------------------------------------------------------------------------------------------------------|--------------|
|2       |Fetch Artifact    |Passed            |Pipeline Name: $basic-pipeline-fast$ Stage Name: defaultStage Job Name: defaultJob Source File: source_file Destination: dest_dir       |No            |




* Open task "2"
* Set task source file as "source_dir"
* Uncheck source is a file option
* Set task destination  as "dest_dir2"
* Save Changes
* verifyTask
|Order_no|Task Type         |Run If Conditions |Properties                                                                                                                            |On Cancel     |
|--------|------------------|------------------|--------------------------------------------------------------------------------------------------------------------------------------|--------------|
|2       |Fetch Artifact    |Passed            |Pipeline Name: $basic-pipeline-fast$ Stage Name: defaultStage Job Name: defaultJob Source Directory: source_dir Destination: dest_dir2     |No            |

* Add task "Fetch Artifact"
* Set task stage as "defaultStage"
* Set task job as "defaultJob"
* Save Changes
* Verify error message "Should provide either srcdir or srcfile" - Already On New Pipeline Group Popup



Teardown of contexts
____________________
* Capture go state "FetchArtifactTask" - teardown
