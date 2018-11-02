EditExistingEnvironments
=================

EditExistingEnvironments
-------------------
tags: edit_environments

Setup of contexts
* With Environments Configuration - setup
* Using pipeline "environment-pipeline, environment-pipeline-locked, environment-failing-pipeline" - setup
* With "1" live agents - setup
* Capture go state "EditExistingEnvironments" - setup

* Looking at environment "uat"
* Open Environment edit page for environment "uat"

* Edit pipelines
* Remove pipelines "environment-pipeline,environment-pipeline-locked" and save environment
* Expand environment "uat"
* Verify pipelines "environment-failing-pipeline" are available on "uat" edit page
* Verify pipelines "environment-pipeline,environment-pipeline-locked" are not available on "uat" edit page


* Edit Agents
* Add agent "missing-agent" and save environment
* Expand environment "uat"
* Verify agents "missing-agent (10.232.3.1)" are available on "uat" edit page

* Edit Agents
* Select all agents and verify all are selected
* Save environment

* Expand environment "uat"
* Edit environment variables
* For variable at row "1" set name "another" value "abc"
* For variable at row "4" set name "correct" value "value"
* Add new variable
* Expand environment "uat"
* Verify environment variables "another = abc,correct = value" are available on "uat" edit page

teardown
_______________
* Capture go state "EditExistingEnvironments" - teardown
* With "1" live agents - teardown
