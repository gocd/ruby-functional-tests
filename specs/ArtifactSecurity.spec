

ArtifactSecurity
=============================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "viewable-pipeline, 2-stage-viewable" - setup
* With "1" live agents - setup
* Capture go state "ArtifactSecurity" - setup

ArtifactSecurity
-----------------------------

tags: #2400, #2786, security, authorisation, authentication, #2514, automate, 6786

Admin can add/edit artifacts

* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* Looking at pipeline "2-stage-viewable" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "first" is "Passed" on pipeline with label "1" - On Swift Dashboard page



* For pipeline "viewable-pipeline" label "1" stage "defaultStage" counter "1" job "defaultJob"
* Create artifact "new_artifact.txt" and Verify return code is "201" - Using Artifact Api


* On Swift Dashboard Page


* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* On Job details page of pipeline "viewable-pipeline" counter "1" stage "defaultStage" counter "1" job "defaultJob"
* Open "Artifacts" tab - On Job details page
* Verify artifacts tab contains file "new_artifact.txt"

* For pipeline "viewable-pipeline" label "1" stage "defaultStage" counter "1" job "defaultJob"
* Append "foo bar baz" to artifact "new_artifact.txt" and Verify return code is "200" - Using Artifact Api


* Verify artifacts tab contains file "new_artifact.txt"
* Verify artifact "new_artifact.txt" contains text "foo bar baz"

Operate user can add/edit artifacts
* Logout and login as "operate"

* For pipeline "viewable-pipeline" label "1" stage "defaultStage" counter "1" job "defaultJob"
* Append "new text" to artifact "new_artifact.txt" and Verify return code is "200" - Using Artifact Api



View user cannot add/edit artifacts

* Logout and login as "view"

* For pipeline "viewable-pipeline" label "1" stage "defaultStage" counter "1" job "defaultJob"
* Create artifact "another_artifact.txt" and Verify return code is "403" - Using Artifact Api


* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* On Job details page of pipeline "viewable-pipeline" counter "1" stage "defaultStage" counter "1" job "defaultJob"
*  Open "Artifacts" tab - On Job details page


* Verify artifacts tab does not contain file "another_artifact.txt"

* For pipeline "viewable-pipeline" label "1" stage "defaultStage" counter "1" job "defaultJob"
* Append "foo bar baz" to artifact "another_artifact.txt" and Verify return code is "403" - Using Artifact Api



* Verify artifacts tab does not contain file "another_artifact.txt"



Teardown of contexts
____________________
* Logout - from any page
* With "1" live agents - teardown
* Capture go state "ArtifactAndPropertiesSecurity" - teardown
