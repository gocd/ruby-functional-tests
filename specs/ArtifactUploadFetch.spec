

ArtifactUploadFetch
===================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline-artifacts" - setup
* With "1" live agents - setup
* Capture go state "ArtifactUploadFetch" - setup

ArtifactUploadFetch
-------------------

tags: fetch artifacts

* On Swift Dashboard Page
* Looking at pipeline "pipeline-artifacts" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Failed" on pipeline with label "1" - On Swift Dashboard page
* On Job details page of pipeline "pipeline-artifacts" counter "1" stage "defaultStage" counter "1" job "Job1"
* Verify in console that artifact "subfolder/another.zip" was uploaded to "file-with-dot-in-subfolder"
* Verify in console that artifact "something.jar" was uploaded to "jarfolder"
* Verify in console that artifact "some.txt.thing" was uploaded to "zipfolder"
* Verify in console that artifact "subfolder/another.zip" was uploaded to "all-in-subfolder"
* Verify in console that artifact "subfolder/file" was uploaded to "all-in-subfolder"
* Verify in console that artifact "something.zip" was uploaded to "allzip"
* Verify in console that artifact "subfolder/another.zip" was uploaded to "allzip/subfolder"

* On stage details page "overview" tab for "pipeline-artifacts" label "1" stage name "defaultStage" counter "1"

* Trigger stage "second" - On stage details page

* On Swift Dashboard Page
* Verify stage "second" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* On Job details page of pipeline "pipeline-artifacts" counter "1" stage "second" counter "1" job "Job2"

* Verify console log contains message "Fetching artifact [file-with-dot-in-subfolder] from"
* Verify console log contains message "Fetching artifact [jarfolder] from"
* Verify console log contains message "Fetching artifact [zipfolder] from"
* Verify console log contains message "Fetching artifact [all-in-subfolder] from"
* Verify console log contains message "Fetching artifact [allzip] from"




Teardown of contexts
____________________
* Capture go state "ArtifactUploadFetch" - teardown
* With "1" live agents - teardown
* Logout - from any page
