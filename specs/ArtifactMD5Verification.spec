
ArtifactMD5Verification
=======================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "artifact-md5-up" - setup
* Capture go state "ArtifactMD5Verification" - setup
* With "1" live agents - setup

ArtifactMD5Verification
-----------------------

tags: Agent, Artifacts, MD5, stage1



* Looking at pipeline "artifact-md5-up" - On Swift Dashboard page

* With material "junit-failures-material" of type "git" for pipeline "artifact-md5-up"
* Checkin file "abc.txt" as user "user" with message "Comment user" - On Swift Dashboard page

* Commit file "new_artifact.txt" to directory "baz"
* Commit file "another_artifact.txt" to directory "baz"

* On Swift Dashboard Page
* Trigger pipeline "artifact-md5-up" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* On Job details page of pipeline "artifact-md5-up" counter "1" stage "defaultStage" counter "1" job "defaultJob"

* Verify in console that artifact "abc.txt" was uploaded to "[defaultRoot]"
* Verify artifacts tab contains file "abc.txt"
* Verify in console that artifact "baz" was uploaded to "[defaultRoot]"
* Verify artifacts tab contains file "new_artifact.txt" in dir "baz"
* Verify artifacts tab contains file "another_artifact.txt"
* Verify artifacts tab contains file "md5.checksum" in dir "cruise-output"

* Navigate to stage "defaultStage" of run "1" having counter "1"

* Trigger stage "secondStage"

* On Pipeline Dashboard Page
* Verify stage "2" is "Passed" on pipeline with label "1"

* Navigate to stage "secondStage" of run "1" having counter "1"

* Go to jobs tab
* Navigate to job "defaultJob"

* Open console tab
* Verify console log contains message "abc.txt] after verifying the integrity of its contents."
* Verify console log contains message "foo/bar] after verifying the integrity of its contents."
* Verify console log does not contains message "Go could not verify the integrity of its contents."





Teardown of contexts
____________________
* With "1" live agents - teardown
* Capture go state "ArtifactMD5Verification" - teardown



