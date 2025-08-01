

FetchArtifactFromAncestor
=========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "uppest_pipeline, upper_pipeline, upper_peer_pipeline, up_pipeline, down_pipeline" - setup
* With "2" live agents - setup
* Capture go state "FetchMaterialFromAncestor" - setup

FetchArtifactFromAncestor
-------------------------

tags: fetchartifact

* On Swift Dashboard Page
* Looking at pipeline "uppest_pipeline" - On Swift Dashboard page
* With material "git_material" of type "git" for pipeline "uppest_pipeline"
* Checkin file "first" as user "user" with message "comment user" - On Swift Dashboard page
 

* Looking at pipeline "uppest_pipeline" - On Swift Dashboard page
* With material "git_material" of type "git" for pipeline "uppest_pipeline"
* Checkin file "second" as user "user" with message "comment user" - On Swift Dashboard page

* On Swift Dashboard Page
* Looking at pipeline "uppest_pipeline" - On Swift Dashboard page
* Trigger and wait for stage "uppest-stage3" is "Passed" with label "1" - On Swift Dashboard page


* Looking at pipeline "upper_pipeline" - On Swift Dashboard page
* Trigger and wait for stage "upper-stage1" is "Passed" with label "1" - On Swift Dashboard page

* Looking at pipeline "uppest_pipeline" - On Swift Dashboard page
* Trigger and wait for stage "uppest-stage3" is "Passed" with label "2" - On Swift Dashboard page

* Looking at pipeline "upper_peer_pipeline" - On Swift Dashboard page
* Trigger and wait for stage "upper-peer-stage1" is "Passed" with label "1" - On Swift Dashboard page


* Looking at pipeline "up_pipeline" - On Swift Dashboard page
* Trigger and wait for stage "up-stage1" is "Passed" with label "1" - On Swift Dashboard page

* Looking at pipeline "down_pipeline" - On Swift Dashboard page
* Trigger and wait for stage "down-stage1" is "Passed" with label "1" - On Swift Dashboard page

* On Job details page of pipeline "down_pipeline" counter "1" stage "down-stage1" counter "1" job "down-job1"


* Verify console says that artifact "first" was fetched from "$uppest_pipeline$/1/uppest-stage1/latest/uppest-job1" for path "$uppest_pipeline$/$upper_pipeline$/$up_pipeline$" from "uppest-stage1/uppest-job1"
* Verify console says that artifact "first" was fetched from "$uppest_pipeline$/2/uppest-stage1/1/uppest-job1" for path "$uppest_pipeline$/$upper_peer_pipeline$/$up_pipeline$" from "uppest-stage1/uppest-job1"


* On Swift Dashboard Page
* Looking at pipeline "upper_pipeline" - On Swift Dashboard page
* On Job details page of pipeline "upper_pipeline" counter "1" stage "upper-stage1" counter "1" job "upper-job1"
* Verify console says that artifact "first" was fetched from "$uppest_pipeline$/1/uppest-stage1/latest/uppest-job1" for path "$uppest_pipeline$" from "uppest-stage1/uppest-job1"




Teardown of contexts
____________________
* With "2" live agents - teardown
* Capture go state "FetchMaterialFromAncestor" - teardown
