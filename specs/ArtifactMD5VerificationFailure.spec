

ArtifactMD5VerificationFailure
==============================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "artifact-md5-mismatch" - setup
* Capture go state "ArtifactMD5VerificationFailure" - setup
* With "1" live agents - setup

ArtifactMD5VerificationFailure
------------------------------

tags: Artifacts, MD5

Failure Scenario - MD5 Mismatch

* Looking at pipeline "artifact-md5-mismatch" - On Swift Dashboard page

* With material "junit-failures-material" of type "git" for pipeline "artifact-md5-mismatch"
* Checkin file "new_artifact.txt" as user "user" with message "Comment user" - On Swift Dashboard page

* On Swift Dashboard Page
* Trigger pipeline "artifact-md5-mismatch" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* On Job details page of pipeline "artifact-md5-mismatch" counter "1" stage "defaultStage" counter "1" job "defaultJob"



* Verify in console that artifact "new_artifact.txt" was uploaded to ""
* Open "Artifacts" tab - On Job details page
* Verify artifacts tab contains file "new_artifact.txt"
* Verify artifacts tab contains file "md5.checksum" in dir "cruise-output"

* For pipeline "artifact-md5-mismatch" label "1" stage "defaultStage" counter "1" job "defaultJob"
* Append "foo bar baz" to artifact "new_artifact.txt" and Verify return code is "200" - Using Artifact Api


* On stage details page "overview" tab for "artifact-md5-mismatch" label "1" stage name "defaultStage" counter "1"
* Trigger stage "secondStage" - On stage details page

* On Swift Dashboard Page
* Wait till "100" seconds for stage "secondStage" shows status "Failed" - On Swift Dashboard page
* Verify stage "secondStage" is "failed" - On Swift Dashboard page

* On Job details page of pipeline "artifact-md5-mismatch" counter "1" stage "secondStage" counter "1" job "defaultJob"
* Verify console log contains message "[ERROR] Verification of the integrity of the artifact [new_artifact.txt] failed. The artifact file on the server may have changed since its original upload."


Teardown of contexts
____________________
* With "1" live agents - teardown
* Capture go state "ArtifactMD5VerificationFailure" - teardown


