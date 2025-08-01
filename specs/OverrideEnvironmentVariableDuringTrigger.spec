OverrideEnvironmentVariableDuringTrigger
========================================

OverrideEnvironmentVariableDuringTrigger
----------------------------------------

tags: environment, override environment variables

Setup of contexts
* With Environments Configuration - setup
* Using pipeline "pipeline-with-environment-variables" - setup
* With "1" live agents - setup
* Capture go state "OverrideEnvironmentVariableDuringTrigger" - setup

* Add environment "test-env" to any "1" Idle agents - Using Agents API
* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-environment-variables" - On Swift Dashboard page
* Open trigger with options - On Swift Dashboard page
* Switch to Environment Variables tab - On Swift Dashboard page

* Change variable "ENVIRONMENT_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER" to "trigger-overrides-env"
* Change variable "PIPELINE_LEVEL_VARIABLE" to "\"''!@#$%^&*()<script>alert(0);</script>"
* Change variable "ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_STAGE" to ""
* Change variable "ENV_LEVEL_VARIABLE" to "blah"
* Change variable "ENV_LEVEL_VARIABLE" to "environment"
* Trigger pipeline with options - On Swift Dashboard page

* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-environment-variables" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "passed" on pipeline with label "1" - On Swift Dashboard page
* On Job details page of pipeline "pipeline-with-environment-variables" counter "1" stage "defaultStage" counter "1" job "pipeline-with-environment-variables-job"

* Verify console log contains message "setting environment variable 'ENVIRONMENT_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER' to value 'does-not-matter'"
* Verify console log contains message "overriding environment variable 'ENVIRONMENT_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER' with value 'trigger-overrides-env'"
* Verify console log contains message "setting environment variable 'PIPELINE_LEVEL_VARIABLE' to value 'pipeline'"
* Verify console log contains message "overriding environment variable 'PIPELINE_LEVEL_VARIABLE' with value '\"''!@#$%^&amp;*()&lt;script&gt;alert(0);&lt;/script&gt;'"
* Verify console log contains message "setting environment variable 'ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_STAGE' to value 'does-not-matter'"
* Verify console log contains message "overriding environment variable 'ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_STAGE' with value ''"
* Verify console log does not contains message "overriding environment variable 'ENV_LEVEL_VARIABLE'"

* Verify console log contains message "ENVIRONMENT_LEVEL_VARIABLE_OVERRIDDEN_BY_TRIGGER=trigger-overrides-env."
* Verify console log contains message "PIPELINE_LEVEL_VARIABLE=\"''!@#$%^&amp;*()&lt;script&gt;alert(0);&lt;/script&gt;."
* Verify console log contains message "ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_STAGE=."
* Verify console log contains message "ENV_LEVEL_VARIABLE_OVERRIDDEN_BY_PIPELINE=pipeline-overrides-env."

teardown
_______________
* Capture go state "OverrideEnvironmentVariableDuringTrigger" - teardown
* With "1" live agents - teardown
