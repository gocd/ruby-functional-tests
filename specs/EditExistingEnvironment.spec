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

* Looking at environment "test-env"
* Open Environment edit page for environment "test-env"

* Edit pipelines
* Remove pipelines "environment-pipeline,environment-pipeline-locked" and save environment
* Expand environment "test-env"
* Verify pipelines "environment-failing-pipeline" are available on "test-env" edit page
* Verify pipelines "environment-pipeline,environment-pipeline-locked" are not available on "test-env" edit page


* Edit Agents
* Add agent "missing-agent" and save environment
* Expand environment "test-env"
* Verify agents "missing-agent (10.232.3.1)" are available on "test-env" edit page

* Edit Agents
* Select all agents and verify all are selected
* Save environment

* Expand environment "test-env"
* Edit environment variables
* For variable at row "1" set name "another" value "abc"
* For variable at row "4" set name "correct" value "value"
* Add new variable
* Expand environment "test-env"
* Verify environment variables "another = abc,correct = value" are available on "test-env" edit page

teardown
_______________
* Capture go state "EditExistingEnvironments" - teardown
* With "1" live agents - teardown
