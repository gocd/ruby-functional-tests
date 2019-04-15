PassEnvironmentVariablesToAJob
==============================

Setup of contexts
* With Environments Configuration - setup
* Using pipeline "pipeline-with-environment-variables" - setup
* With "1" live agents - setup
* Capture go state "PassEnvironmentVariablesToAJob" - setup

PassEnvironmentVariablesToAJob
------------------------------

tags: environment,environment variables,WIP

This is to verify that only the agents associated with an evironment are used to build the pipeline
* Add environment "test-env" to any "1" Idle agents - Using Agents API

* Looking at environment "test-env"
* Open Environment edit page for environment "test-env"
* Edit environment variables
* For variable at row "5" set name "VARIABLE_TEST" value "variable test value"
* Add new variable
* Open Environment edit page for environment "test-env"
* Edit environment variables
* For variable at row "6" set name "GO_ENVIRONMENT_NAME" value "overriden value"
* Add new variable
* On Pipeline settings page of pipeline "pipeline-with-environment-variables"
* Open "Environment Variables" tab - On Pipeline settings page
* Add environment variable "VNC" with value "Y"
* Save Changes

Pipeline with environment variables
* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-environment-variables" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "passed" on pipeline with label "1" - On Swift Dashboard page
* On Job details page of pipeline "pipeline-with-environment-variables" counter "1" stage "defaultStage" counter "1" job "pipeline-with-environment-variables-job"

* Verify console log contains message "setting environment variable 'GO_ENVIRONMENT_NAME' to value 'test-env'"
* Verify console log contains message "overriding environment variable 'GO_ENVIRONMENT_NAME' with value 'overriden value'"
* Verify console log contains message "setting environment variable 'VARIABLE_TEST' to value 'variable test value'"
* Verify console log contains message "setting environment variable 'ENV_LEVEL_VARIABLE' to value 'environment'"
* Verify console log contains message "setting environment variable 'ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_PIPELINE' to value 'does-not-matter'"
* Verify console log contains message "setting environment variable 'ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_STAGE' to value 'does-not-matter'"
* Verify console log contains message "setting environment variable 'ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_JOB' to value 'does-not-matter'"
* Verify console log contains message "setting environment variable 'PIPELINE_LEVEL_VARIABLE' to value 'pipeline'"
* Verify console log contains message "overriding environment variable 'ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_PIPELINE' with value 'pipeline-overrides-env'"
* Verify console log contains message "setting environment variable 'PIPELINE_LEVEL_VARIABLE_OVERRIDDEN_BY_JOB' to value 'job-overrides-pipeline'"
* Verify console log contains message "setting environment variable 'STAGE_LEVEL_VARIABLE' to value 'stage'"
* Verify console log contains message "overriding environment variable 'ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_STAGE' with value 'stage-overrides-env'"
* Verify console log contains message "setting environment variable 'PIPELINE_LEVEL_VARIABLE_OVERRIDDEN_BY_STAGE' to value 'stage-overrides-pipeline'"
* Verify console log contains message "setting environment variable 'JOB_LEVEL_VARIABLE' to value 'job'"
* Verify console log contains message "overriding environment variable 'ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_JOB' with value 'job-overrides-env'"
* Verify console log contains message "setting environment variable 'STAGE_LEVEL_VARIABLE_OVERRIDDEN_BY_JOB' to value 'job-overrides-stage'"
* Verify console log contains message "overriding environment variable 'VNC' with value 'Y'"

Verify variables value as echoed as part of task
* Verify console log contains message "STAGE_LEVEL_VARIABLE=stage."
* Verify console log contains message "ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_STAGE=stage-overrides-env."
* Verify console log contains message "ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_PIPELINE=pipeline-overrides-env."
* Verify console log contains message "PIPELINE_LEVEL_VARIABLE_OVERRIDDEN_BY_ONE_JOB_ONLY=job-overrides-pipeline."
* Verify console log contains message "PIPELINE_LEVEL_VARIABLE_OVERRIDDEN_BY_ONE_STAGE_ONLY=stage-overrides-pipeline."

* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-environment-variables" - On Swift Dashboard page
* On Job details page of pipeline "pipeline-with-environment-variables" counter "1" stage "defaultStage" counter "1" job "another-job"

* Verify console log contains message "setting environment variable 'ENV_LEVEL_VARIABLE' to value 'environment'"
* Verify console log contains message "setting environment variable 'ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_PIPELINE' to value 'does-not-matter'"
* Verify console log contains message "setting environment variable 'ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_STAGE' to value 'does-not-matter'"
* Verify console log contains message "setting environment variable 'ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_JOB' to value 'does-not-matter'"
* Verify console log contains message "setting environment variable 'PIPELINE_LEVEL_VARIABLE' to value 'pipeline'"
* Verify console log contains message "overriding environment variable 'ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_PIPELINE' with value 'pipeline-overrides-env'"
* Verify console log contains message "setting environment variable 'PIPELINE_LEVEL_VARIABLE_OVERRIDDEN_BY_JOB' to value 'another-job-overrides-pipeline'"
* Verify console log contains message "setting environment variable 'STAGE_LEVEL_VARIABLE' to value 'stage'"
* Verify console log contains message "overriding environment variable 'ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_STAGE' with value 'stage-overrides-env'"
* Verify console log contains message "setting environment variable 'PIPELINE_LEVEL_VARIABLE_OVERRIDDEN_BY_STAGE' to value 'stage-overrides-pipeline'"
* Verify console log contains message "setting environment variable 'JOB_LEVEL_VARIABLE' to value 'another-job'"
* Verify console log contains message "overriding environment variable 'ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_JOB' with value 'another-job-overrides-env'"
* Verify console log contains message "setting environment variable 'STAGE_LEVEL_VARIABLE_OVERRIDDEN_BY_JOB' to value 'another-job-overrides-stage'"

* Verify console log contains message "JOB_LEVEL_VARIABLE=another-job."
* Verify console log contains message "ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_STAGE=stage-overrides-env."
* Verify console log contains message "ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_JOB=another-job-overrides-env."
* Verify console log contains message "PIPELINE_LEVEL_VARIABLE_OVERRIDDEN_BY_STAGE=stage-overrides-pipeline."
* Verify console log contains message "PIPELINE_LEVEL_VARIABLE_OVERRIDDEN_BY_JOB=another-job-overrides-pipeline."
* Verify console log contains message "PIPELINE_LEVEL_VARIABLE_OVERRIDDEN_BY_ONE_JOB_ONLY=value-set-by-pipeline."

Verify console of second stage

* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-environment-variables" - On Swift Dashboard page
* On Job details page of pipeline "pipeline-with-environment-variables" counter "1" stage "secondStage" counter "1" job "job"

* Verify console log contains message "ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_STAGE=secondstage-overrides-env."
* Verify console log contains message "ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_JOB=second-job-overrides-env."
* Verify console log contains message "PIPELINE_LEVEL_VARIABLE_OVERRIDDEN_BY_STAGE=secondstage-overrides-pipeline."
* Verify console log contains message "PIPELINE_LEVEL_VARIABLE_OVERRIDDEN_BY_JOB=second-job-overrides-pipeline."
* Verify console log contains message "PIPELINE_LEVEL_VARIABLE_OVERRIDDEN_BY_ONE_STAGE_ONLY=value-set-by-pipeline."

Teardown of contexts
____________________
* Capture go state "PassEnvironmentVariablesToAJob" - teardown
* With "1" live agents - teardown
