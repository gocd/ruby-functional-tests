ArtifactsEdit
================

ArtifactsEdit
----------------

tags: artifact

Setup of contexts
* Basic Configuration - setup
* Using pipeline "edit-pipeline" - setup
* Capture go state "ArtifactsEdit" - setup

* On Job settings page of pipeline "edit-pipeline" stage "defaultStage" job "defaultJob"
* Open "Artifacts" tab - On Job settings page
* Add artifact of type "Build"
* Save artifact with values "source: build_source, destination: build_folder" at "1"
* Add artifact of type "Test"
* Save artifact with values "source: test_source, destination: test_folder" at "2"

* Looking at pipeline "edit-pipeline" - On Swift Dashboard page
* Verify artifact with type as "build" source as "build_source" and destination as "build_folder"  exists for "defaultJob" in "defaultStage"



teardown
_______________

* Capture go state "ArtifactsEdit" - teardown


