
FetchArtifactFromAncestorUI
===========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "uppest_pipeline, upper_pipeline, upper_peer_pipeline, up_pipeline, down_pipeline" - setup
* Capture go state "FetchMaterialFromAncestorUI" - setup

FetchArtifactFromAncestorUI
---------------------------

tags: Fetch Artifact

* On Job settings page of pipeline "down_pipeline" stage "down-stage2" job "down-job2"
* Add task "Fetch Artifact"
* Set task pipeline as "$uppest_pipeline$/$upper_pipeline$/$up_pipeline$"
* Set task stage as "uppest-stage1"
* Set task job as "uppest-job1"
* Set task source file as "source_file"
* Check source is a file option
* Set task destination as "dest_dir"
* Save task changes


* verifyTask
|Order_no|Task Type         |Run If Conditions |Properties                                                                                    |On Cancel     |
|--------|------------------|------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
|1       |Fetch Artifact    |passed            |Pipeline-Name: $uppest_pipeline$/$upper_pipeline$/$up_pipeline$, Stage-Name: uppest-stage1, Job-Name: uppest-job1, Source: source_file, Destination: dest_dir   |No            |

* Add task "Fetch Artifact"
* Set task stage as "down-stage1"
* Set task job as "down-job1"
* Set task source file as "src_dir"
* Save task changes

* verifyTask
|Order_no|Task Type         |Run If Conditions |Properties                                                      |On Cancel |
|--------|------------------|------------------|----------------------------------------------------------------|----------|
|2       |Fetch Artifact    |passed            |Stage-Name: down-stage1, Job-Name: down-job1, Source: src_dir   |No        |

* On Swift Dashboard Page
* Looking at pipeline "down_pipeline" - On Swift Dashboard page
* Edit pipeline "parent-left"
* Enable pipeline config spa
* Open "Materials" tab - On Pipeline settings page
* Select add new material of type "Pipeline"
* Set pipeline and stage as "$uppest_pipeline$:uppest-stage2"
* Save material

* Verify that material "$uppest_pipeline$" can be deleted
* Verify that material "$up_pipeline$" can be deleted

* Delete material with name "$up_pipeline$"
* Verify the error message "Cannot delete the material as it is used in a fetch artifact task" is present

Teardown of contexts
____________________
* Capture go state "FetchMaterialFromAncestorUI" - teardown
