ExternalArtifacts
=========

ExternalArtifacts
-------------------
tags: external_artifacts

Setup of contexts
* External Artifacts Configuration - setup
* Login as "admin" - setup
* Using pipeline "upstream, downstream" - setup
* With "1" live agents - setup
* Capture go state "ExternalArtifacts" - setup

* Start creating artifact store for plugin "Dummy artifact plugin" with id "TestArtifact"
* Save store details as "server_url: http://localhost:8253/go, username: admin, password: badger"
* On Job settings page of pipeline "upstream" stage "defaultStage" job "defaultJob"
* Open "Artifacts" tab - On Job settings page
* Add artifact of type "External"
* Start creating external artifact with values "external_artifacts_id: test_artifact, external_artifacts_store_id: TestArtifact"
* Save external artifact with values "source: artifact.txt, destination: test_folder"

* On Job settings page of pipeline "downstream" stage "defaultStage" job "defaultJob"
* Open "Tasks" tab - On Job settings page
* Add task "Fetch Artifact"
* Select artifact type "External" pipeline "upstream" stage "defaultStage" job "defaultJob" artifact id "test_artifact" path "test_folder"
* Save task details


* Looking at pipeline "upstream" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "passed" - On Swift Dashboard page

* On Job details page of pipeline "upstream" counter "1" stage "defaultStage" counter "1" job "defaultJob"
* Verify console log contains message "Start to upload pluggable artifact using plugin `cd.go.artifact.dummy`"

* Looking at pipeline "downstream" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "passed" - On Swift Dashboard page

* On Job details page of pipeline "downstream" counter "1" stage "defaultStage" counter "1" job "defaultJob"
* Verify console log contains message "Fetching pluggable artifact using plugin cd.go.artifact.dummy"


teardown
_______________
* As user "admin" for teardown
* Capture go state "ExternalArtifacts" - teardown
* With "1" live agents - teardown
* Logout - from any page
