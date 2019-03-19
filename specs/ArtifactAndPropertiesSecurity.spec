

ArtifactAndPropertiesSecurity
=============================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "viewable-pipeline, 2-stage-viewable" - setup
* With "1" live agents - setup
* Capture go state "ArtifactAndPropertiesSecurity" - setup

ArtifactAndPropertiesSecurity
-----------------------------

tags: #2400, #2786, security, authorisation, authentication, #2514, automate, 6786

Admin can add/edit artifacts and add/view job properties

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

* verify property "foo" with value "bar" for pipeline "viewable-pipeline" stage "defaultStage" label "1" counter "1" job "defaultJob" can be added


Operate user can add/edit artifacts and view/add properties using api
* Logout and login as "operate"

* For pipeline "viewable-pipeline" label "1" stage "defaultStage" counter "1" job "defaultJob"
* Append "new text" to artifact "new_artifact.txt" and Verify return code is "200" - Using Artifact Api



* verify property "prop_name_by_operate" with value "prop_value_by_operate" for pipeline "viewable-pipeline" stage "defaultStage" label "1" counter "1" job "defaultJob" can be added

View user cannot add/edit artifacts and add properties using api

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

 verify property "quux" with value "baz" for pipeline "viewable-pipeline" stage "defaultStage" label "1" counter "1" job "defaultJob" cannot be added
|






Teardown of contexts
____________________
* Capture go state "ArtifactAndPropertiesSecurity" - teardown
* With "1" live agents - teardown
* Logout - from any page
