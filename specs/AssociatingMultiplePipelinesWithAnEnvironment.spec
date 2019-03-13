

AssociatingMultiplePipelinesWithAnEnvironment
=============================================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "environment-pipeline, basic-pipeline" - setup
* With "2" live agents - setup
* Capture go state "AssociatingMultiplePipelinesWithAnEnvironment" - setup

AssociatingMultiplePipelinesWithAnEnvironment
---------------------------------------------

tags:  environment, pipeline

This is to verify that only the agents associated with an evironment are used to build the pipeline

* Select All agents
* Add resources "linux"

* On Job settings page of pipeline "environment-pipeline" stage "defaultStage" job "short"
* Open "Job Settings" tab - On Job settings page
* set job resources as "linux"
* Save Changes
* On Swift Dashboard Page
* Looking at pipeline "environment-pipeline" - On Swift Dashboard page
* Trigger pipeline "environment-pipeline" - On Swift Dashboard page

* Verify there are "0" agents with state "Building"

* Add environment "uat" to any "2" Idle agents - Using Agents API
* Looking at environment "uat"
* Open Environment edit page for environment "uat"
* Edit pipelines
* Add pipeline "basic-pipeline" and save environment

* On Swift Dashboard Page
* Looking at pipeline "environment-pipeline" - On Swift Dashboard page
* Verify stage "defaultStage" is "Building" - On Swift Dashboard page
* Looking at pipeline "basic-pipeline" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Building" - On Swift Dashboard page



Teardown of contexts
____________________
* Capture go state "AssociatingMultiplePipelinesWithAnEnvironment" - teardown
* With "2" live agents - teardown



