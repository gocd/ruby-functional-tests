

ArtifactMD5VerificationSkip
===========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "artifact-md5-skip" - setup
* Capture go state "ArtifactMD5VerificationSkip" - setup
* With "1" live agents - setup

ArtifactMD5VerificationSkip
---------------------------

tags:Artifacts, MD5, ArtifactMD5VerificationSkip

* On Swift Dashboard Page
* Trigger pipeline "artifact-md5-skip" - On Swift Dashboard page
* Wait till stage "defaultStage" completed - On Swift Dashboard page

* For pipeline "artifact-md5-skip" label "1" stage "defaultStage" counter "1" job "defaultJob"
* Create artifact "new_artifact.txt" and Verify return code is "201" - Using Artifact Api

* On Job details page of pipeline "artifact-md5-skip" counter "1" stage "defaultStage" counter "1" job "defaultJob"
* Open "Artifacts" tab - On Job details page
* Verify artifacts tab contains file "new_artifact.txt"

* On stage details page "overview" tab for "artifact-md5-skip" label "1" stage name "defaultStage" counter "1"
* Trigger stage "secondStage" - On stage details page

* On Swift Dashboard Page
* Verify stage "secondStage" is "passed" - On Swift Dashboard page

* On Job details page of pipeline "artifact-md5-skip" counter "1" stage "secondStage" counter "1" job "defaultJob"

* Verify console log contains message "[WARN] The md5checksum property file was not found on the server. Hence, Go can not verify the integrity of the artifacts."
* Verify console log contains message "new_artifact.txt] without verifying the integrity of its contents"
* Verify console log does not contains message "new_artifact.txt] after verifying the integrity of its contents."



Teardown of contexts

____________________
* Capture go state "ArtifactMD5VerificationSkip" - teardown
* With "1" live agents - teardown



