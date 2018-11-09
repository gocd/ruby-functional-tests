
ArtifactsEditValidations
========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "edit-pipeline" - setup
* Capture go state "ArtifactsEditValidations" - setup

ArtifactsEditValidations
------------------------

* On Job settings page of pipeline "edit-pipeline" stage "defaultStage" job "defaultJob"
* Open "Artifacts" tab - On Job settings page

Artifacts Field Validations

* ArtifactSetAndValidate
 |source |destination |messageForSource                                                                                                                    |messageForDestination                                                                                                                            |saveStatus                   |
 |-------|------------|------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------|
 |#      |../../      |Error when processing params for '#' used in field 'source', # must be followed by a parameter pattern or escaped by another #      |Invalid destination path. Destination path should match the pattern (([.]\\\/)?[.][^. ]+)\|([^. ].+[^. ])\|([^. ][^. ])\|([^. ])                 |Save failed, see errors below|
 |#source|#destination|Error when processing params for '#source' used in field 'source', # must be followed by a parameter pattern or escaped by another #|Error when processing params for '#destination' used in field 'destination', # must be followed by a parameter pattern or escaped by another #   |Save failed, see errors below|
 |##     |##          |                                                                                                                                    |                                                                                                                                                 |Saved successfully.          |


* On Pipeline settings page of pipeline "edit-pipeline"
* Open "Parameters" tab - On Pipeline settings page

* SetEnvironmentVariablesForJob
|index|name              |value             |
|-----|------------------|------------------|
|    1|source            |source_folder     |
|    2|destination       |destination_folder|

* On Job settings page of pipeline "edit-pipeline" stage "defaultStage" job "defaultJob"
* Open "Artifacts" tab - On Job settings page

* ArtifactSetAndValidate
     |source   |messageForSource  |destination   |messageForDestination  |saveStatus         |
     |---------|------------------|--------------|-----------------------|-------------------|
     |#{source}|                  |#{destination}|                       |Saved successfully.|
     |${source}|                  |${destination}|                       |Saved successfully.|


Teardown of contexts
____________________
* Capture go state "ArtifactsEditValidations" - teardown


