

EditPipelineWizardReorderStages
===============================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "edit-pipeline-with-3-stages" - setup
* Capture go state "EditPipelineWizardReorderStages" - setup

EditPipelineWizardReorderStages
-------------------------------

tags: Clicky Admin

* On Swift Dashboard Page
* Looking at pipeline "edit-pipeline-with-3-stages" - On Swift Dashboard page
* Edit pipeline "edit-pipeline-with-3-stages"
* Open tab "Stages" - On Pipeline Creation Page

* Verify the stages are "defaultStage,second,third"
* Verify cannot move "defaultStage" to "up"
* Verify cannot move "third" to "down"
* Move stage "second" to "up"
* Verify the stages are "second,defaultStage,third"
* Move stage "defaultStage" to "down"
* Verify the stages are "second,third,defaultStage"




Teardown of contexts
____________________
* Capture go state "EditPipelineWizardReorderStages" - teardown



