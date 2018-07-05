ExternalArtifacts
=========

ExternalArtifacts
-------------------
tags: external_artifacts

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Capture go state "ExternalArtifacts" - setup

* Start creating artifact store for plugin "plugin-name"
* Specify store details as "key1:value1" "key2:value2"
* On Job settings page of pipeline "pipeline_name"
* Open Artifacts tab
* Add artifact of type "External"
* Use external artifact plugin "plugin-name"
* Save artifact details as "key1:value1" "key2:value2"
* On Swift Dashboard Page
* Click on pipeline "downstream" for editing
* Open stage listing page
* Open stage "defaultStage"
* Open jobs
* Open job "defaultJob"
* Add task "Fetch Artifact" of type "External"
* Save task details as "key1:value1" "key2:value2"
* Looking at pipeline "upstream" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed
* Verify stage "firstStage" is "passed" - On Swift Dashboard page
* Looking at pipeline "downstream" - On Swift Dashboard page
* Wait till pipeline completed
* Verify stage "firstStage" is "passed" - On Swift Dashboard page

More steps on console logs verification and artifacts tab verification on job details page to be added here

teardown
_______________
* As user "admin" for teardown
* Capture go state "ExternalArtifacts" - teardown
* Logout - from any page
