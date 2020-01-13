

PipelineApis
============

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "basic-pipeline-fast-api,downstream-pipeline-api,run.till.file.exists-api,admin-pipeline,pipeline-with-environment-variables" - setup
* With "3" live agents - setup
* Capture go state "PipelineApis" - setup

PipelineApis
------------

tags: schedule, api


* On Swift Dashboard Page
* Looking at pipeline "downstream-pipeline-api" - On Swift Dashboard page
* Setting first stage to auto approval

* Add environment "uat" to any "2" Idle agents - Using Agents API

* Looking at pipeline "admin-pipeline" - On Swift Dashboard page

* With variable "VAR_NOT_CONFIGURED" set to "foo"
* Schedule should return code "422"

* Looking at pipeline "pipeline-with-environment-variables" - On Swift Dashboard page

* Using latest revision of material of type "git" named "env-var-material" for pipeline "pipeline-with-environment-variables"
* With variable "ENVIRONMENT_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER" set to "trigger-overrides-env"
* With variable "PIPELINE_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER" set to "trigger-overrides-pipeline"
* With variable "STAGE_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER" set to "trigger-overrides-stage"
* With variable "JOB_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER" set to "trigger-overrides-job"
* Schedule should return code "202"


* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-environment-variables" - On Swift Dashboard page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Verify stage "defaultStage" is with label "1" - On Swift Dashboard page
* On Job details page of pipeline "pipeline-with-environment-variables" counter "1" stage "defaultStage" counter "1" job "pipeline-with-environment-variables-job"


* Verify console log contains message "setting environment variable 'ENVIRONMENT_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER' to value 'does-not-matter'"
* Verify console log contains message "setting environment variable 'PIPELINE_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER' to value 'does-not-matter'"
* Verify console log contains message "setting environment variable 'STAGE_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER' to value 'does-not-matter'"
* Verify console log contains message "setting environment variable 'JOB_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER' to value 'does-not-matter'"
* Verify console log contains message "setting environment variable 'JOB_LEVEL_VARIABLE' to value 'pipeline-with-environment-variables-job'"
* Verify console log contains message "overriding environment variable 'ENVIRONMENT_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER' with value 'trigger-overrides-env'"
* Verify console log contains message "overriding environment variable 'PIPELINE_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER' with value 'trigger-overrides-pipeline'"
* Verify console log contains message "overriding environment variable 'STAGE_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER' with value 'trigger-overrides-stage'"
* Verify console log contains message "overriding environment variable 'JOB_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER' with value 'trigger-overrides-job'"
* Verify console log does not contains message "overriding environment variable 'JOB_LEVEL_VARIABLE'"


* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-environment-variables" - On Swift Dashboard page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Verify stage "defaultStage" is with label "1" - On Swift Dashboard page
* On Job details page of pipeline "pipeline-with-environment-variables" counter "1" stage "defaultStage" counter "1" job "another-job"



* Verify console log contains message "setting environment variable 'ENVIRONMENT_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER' to value 'does-not-matter'"
* Verify console log contains message "setting environment variable 'PIPELINE_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER' to value 'does-not-matter'"
* Verify console log contains message "setting environment variable 'STAGE_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER' to value 'does-not-matter'"
* Verify console log contains message "setting environment variable 'JOB_LEVEL_VARIABLE' to value 'another-job'"
* Verify console log contains message "overriding environment variable 'ENVIRONMENT_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER' with value 'trigger-overrides-env'"
* Verify console log contains message "overriding environment variable 'PIPELINE_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER' with value 'trigger-overrides-pipeline'"
* Verify console log contains message "overriding environment variable 'STAGE_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER' with value 'trigger-overrides-stage'"
* Verify console log does not contains message "setting environment variable 'JOB_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER'"
* Verify console log does not contains message "overriding environment variable 'JOB_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER'"
* Verify console log does not contains message "overriding environment variable 'JOB_LEVEL_VARIABLE'"


* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-environment-variables" - On Swift Dashboard page
* Wait till "60" seconds for stage "secondStage" shows status "passed" - On Swift Dashboard page
* On Job details page of pipeline "pipeline-with-environment-variables" counter "1" stage "secondStage" counter "1" job "foo"





* Verify console log contains message "setting environment variable 'ENVIRONMENT_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER' to value 'does-not-matter'"
* Verify console log contains message "setting environment variable 'PIPELINE_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER' to value 'does-not-matter'"
* Verify console log does not contains message "environment variable 'STAGE_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER'"
* Verify console log contains message "setting environment variable 'JOB_LEVEL_VARIABLE' to value 'foo'"
* Verify console log contains message "overriding environment variable 'ENVIRONMENT_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER' with value 'trigger-overrides-env'"
* Verify console log contains message "overriding environment variable 'PIPELINE_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER' with value 'trigger-overrides-pipeline'"
* Verify console log contains message "overriding environment variable 'JOB_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER' with value 'trigger-overrides-job'"
* Verify console log does not contains message "overriding environment variable 'JOB_LEVEL_VARIABLE'"


* Attempt to get scheduled list of jobs should return with status "200"

* Logout - from any page

* Login as "view"

* Looking at pipeline "admin-pipeline" - On Swift Dashboard page
* Schedule should return code "403"
* Looking at pipeline "doesnt-exist" - On Swift Dashboard page
* Schedule should return code "404"
* Looking at pipeline "basic-pipeline-fast-api" - On Swift Dashboard page
* Using "foo" revision of "material-that-doesn't-exist" of type "git" for pipeline "basic-pipeline-fast-api"
* Schedule should return code "422"
* Looking at pipeline "downstream-pipeline-api" - On Swift Dashboard page
* Using stage "defaultStage" of upstream pipeline "run.till.file.exists-api" with counter "1"
* Schedule should return code "422"

* Looking at pipeline "basic-pipeline-fast-api" - On Swift Dashboard page
* Schedule should return code "202"

* On Swift Dashboard Page
* Looking at pipeline "basic-pipeline-fast-api" - On Swift Dashboard page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Verify stage "defaultStage" is with label "1" - On Swift Dashboard page
* Looking at pipeline "downstream-pipeline-api" - On Swift Dashboard page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Verify stage "defaultStage" is with label "1" - On Swift Dashboard page

* Looking at pipeline "basic-pipeline-fast-api" - On Swift Dashboard page
* Schedule should return code "202"

* On Swift Dashboard Page
* Looking at pipeline "basic-pipeline-fast-api" - On Swift Dashboard page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Verify stage "defaultStage" is with label "2" - On Swift Dashboard page
* Looking at pipeline "downstream-pipeline-api" - On Swift Dashboard page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Verify stage "defaultStage" is with label "2" - On Swift Dashboard page
* Using latest revision of material of type "git" named "downstream_git_material" for pipeline "downstream-pipeline-api"
* Schedule should return code "202"

* On Swift Dashboard Page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Verify stage "defaultStage" is with label "3" - On Swift Dashboard page
* Open changes section - On Swift Dashboard page

* Looking at material of type "Pipeline" named "$basic-pipeline-fast-api$"
* Verify modification "0" has revision "$basic-pipeline-fast-api$/2/defaultStage/1" - On Build Cause popup

* Looking at pipeline "run.till.file.exists-api" - On Swift Dashboard page
* Schedule should return code "202"
* On Swift Dashboard Page

* Verify stage "defaultStage" is "Building" - On Swift Dashboard page

* Schedule should return code "409"

* Attempt to get scheduled list of jobs should return with status "403"



Teardown of contexts
____________________
* Capture go state "PipelineApis" - teardown
* With "3" live agents - teardown
* Logout - from any page
