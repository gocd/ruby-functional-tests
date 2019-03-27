

FetchArtifactTask
=================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "downstream-pipeline,basic-pipeline-fast" - setup
* Capture go state "FetchArtifactTask" - setup

FetchArtifactTask
-----------------

tags: Fetch Artifact

* On Job settings page of pipeline "downstream-pipeline" stage "defaultStage" job "defaultJob"



* Add task "Fetch Artifact"
* Set task pipeline as "$basic-pipeline-fast$"
* Set task stage as "defaultStage"
* Set task pipeline as "defaultJob"
* Set task source file as "source_file"
* Check source is a file option
* Set task destination  as "dest_dir"
* Save Changes

* verifyTask
|Order_no|Task Type         |Run If Conditions |Properties                                                                                                                            |On Cancel     |
|--------|------------------|------------------|--------------------------------------------------------------------------------------------------------------------------------------|--------------|
|2       |Fetch Artifact    |Passed            |@Pipeline Name: $basic-pipeline-fast$, @Stage Name: defaultStage, @Job Name: defaultJob, Source File: source_file, Destination: dest_dir |No            |



* Looking at pipeline "downstream-pipeline" - On Swift Dashboard page
* Verify "fetchartifact" task with attributes "@pipeline: ${runtime_name:basic-pipeline-fast}, @stage: defaultStage, @job: defaultJob, @srcfile: source_file, @dest: dest_dir" exists for "defaultJob" in "defaultStage"

* Open task "2"

* Verify has "task[pipelineName](text_field): ${runtime_name:basic-pipeline-fast}"
* Verify has "task[stage](text_field): defaultStage"
* Verify has "task[job](text_field): defaultJob"
* Verify has "task[src](text_field): source_file"
* Verify has "task[isSourceAFile](check_box): true"
* Verify has "task[dest](text_field): dest_dir"
* Set "task[src](text_field): source_dir" - Already on Task edit popup
* Set "task[isSourceAFile](check_box): false" - Already on Task edit popup
* Set "task[dest](text_field): dest_dir2" - Already on Task edit popup
* Save and verify saved successfully

* Verify task "2" is "Fetch Artifact" task without on cancel and properties "Pipeline Name: ${runtime_name:basic-pipeline-fast}, Stage Name: defaultStage, Job Name: defaultJob, Source Directory: source_dir, Destination: dest_dir2" that runs if state is "Passed"

* For pipeline "downstream-pipeline"
* Verify "fetchartifact" task with attributes "@pipeline: ${runtime_name:basic-pipeline-fast}, @stage: defaultStage, @job: defaultJob, @srcdir: source_dir, @dest: dest_dir2" exists for "defaultJob" in "defaultStage"

* Open new task form "Fetch Artifact"

AutoComplete and Save
* Set "task[pipelineName](text_field): b" - Already on Task edit popup
* Auto complete should show up "${runtime_name:basic-pipeline-fast}" - Already on Task edit popup
* Select option "${runtime_name:basic-pipeline-fast}" - Already on Task edit popup
* Set "task[stage](text_field): d" - Already on Task edit popup
* Auto complete should show up "defaultStage" for textBox "1"
* Select option from suggestion at index "0" for text box "1"
* Set "task[job](text_field): d" - Already on Task edit popup
* Auto complete should show up "defaultJob" for textBox "2"
* Select option from suggestion at index "0" for text box "2"
* Set "task[src](text_field): source_dir" - Already on Task edit popup
* Save and verify saved successfully

* Verify task "3" is "Fetch Artifact" task without on cancel and properties "Pipeline Name: ${runtime_name:basic-pipeline-fast}, Stage Name: defaultStage, Job Name: defaultJob, Source Directory: source_dir" that runs if state is "Passed"

* For pipeline "downstream-pipeline"
* Verify "fetchartifact" task with attributes "@pipeline: ${runtime_name:basic-pipeline-fast}, @stage: defaultStage, @job: defaultJob, @srcdir: source_dir" exists for "defaultJob" in "defaultStage"

* Open new task form "Fetch Artifact"

Validations
* Verify has "task[pipelineName](text_field): NULL, task[stage](text_field): NULL, task[job](text_field):NULL"
* Verify has "task[src](text_field): NULL, task[isSourceAFile](check_box): false, task[dest](text_field):NULL"
* Set "task[stage](text_field): defaultStage" - Already on Task edit popup
* Set "task[job](text_field): defaultJob" - Already on Task edit popup
* Save and verify save failed
* Verify save failed with error message "Should provide either srcdir or srcfile"


Teardown of contexts
____________________
* Capture go state "FetchArtifactTask" - teardown
* Using pipeline "downstream-pipeline,basic-pipeline-fast" - teardown
* Basic configuration - teardown
