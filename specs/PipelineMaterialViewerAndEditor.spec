

PipelineMaterialViewerAndEditor
===============================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "two-stage-pipeline, edit-pipeline" - setup
* Capture go state "PipelineMaterialViewerAndEditor" - setup

PipelineMaterialViewerAndEditor
-------------------------------

tags: Clicky Admin

* On Swift Dashboard Page
* Looking at pipeline "edit-pipeline" - On Swift Dashboard page
* Edit pipeline "edit-pipeline"


* Open "Materials" tab - On Pipeline settings page

* Select add new material of type "Pipeline"
* Set material name as "pipeline_material"
* Set pipeline Stage as "$two-stage-pipeline$ [defaultStage]"
* Save Changes
* Verify material "pipeline_material" is exist with URL "$two-stage-pipeline$ / defaultStage"

* Edit material "pipeline_material"
* Set pipeline Stage as "$two-stage-pipeline$ [anotherStage]"
* Save Changes
* Verify material "pipeline_material" is exist with URL "$two-stage-pipeline$ / anotherStage"



Teardown of contexts
____________________
* Capture go state "PipelineMaterialViewerAndEditor" - teardown



