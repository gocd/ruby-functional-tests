

AssociatingAPipelineWithAnEnvironmentWithNoAgents
=================================================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "environment-pipeline" - setup
* With "2" live agents - setup
* Capture go state "AssociatingAPipelineWithAnEnvironmentWithNoAgents" - setup

AssociatingAPipelineWithAnEnvironmentWithNoAgents
-------------------------------------------------

tags: environment

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



Teardown of contexts
____________________
* With "2" live agents - teardown
* Capture go state "AssociatingAPipelineWithAnEnvironmentWithNoAgents" - teardown
