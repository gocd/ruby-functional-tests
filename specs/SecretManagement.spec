SecretManagement
=======

Setup of contexts
* Secure Configuration - setup
* Prepare secret config json "dev_secrets.json" with secrets "dev-password: value"
* Prepare secret config json "test_secrets.json" with secrets "test-password: value"
* Prepare secret config json "prod_secrets.json" with secrets "prod-password: value"
* Login as "admin" - setup
* Using pipeline "In-group-DEV, In-group-TEST, In-group-PROD, In-env-PROD" - setup
* With "2" live agents - setup
* Capture go state "SecretManagement" - setup

SecretManagement
-------

tags: secret_management

* Add environment "PROD_ENV" to any "1" Idle agents - Using Agents API

* Create secret config "DEV" for secret file "dev_secrets.json" rules "allow:*:DEV_*, deny:*:TEST_*, deny:*:PROD_*" - Using Secret Config API
* Looking at pipeline "In-group-DEV" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* On Job details page of pipeline "In-group-DEV" counter "1" stage "defaultStage" counter "1" job "defaultJob"
* Verify console log contains message "Using env var : ******"

* Create secret config "TEST" for secret file "test_secrets.json" rules "allow:*:TEST_*, deny:*:DEV_*, deny:*:PROD_*" - Using Secret Config API
* Looking at pipeline "In-group-TEST" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* On Job details page of pipeline "In-group-TEST" counter "1" stage "defaultStage" counter "1" job "defaultJob"
* Verify console log contains message "Using env var : ******"

* Create secret config "PROD" for secret file "prod_secrets.json" rules "allow:*:PROD_*, deny:*:DEV_*, deny:*:TEST_*" - Using Secret Config API
* Looking at pipeline "In-group-PROD" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* On Job details page of pipeline "In-group-PROD" counter "1" stage "defaultStage" counter "1" job "defaultJob"
* Verify console log contains message "Using env var : ******"

* Looking at pipeline "In-env-PROD" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* On Job details page of pipeline "In-env-PROD" counter "1" stage "defaultStage" counter "1" job "defaultJob"
* Verify console log contains message "Using environment level var : ******"

* Update secret config "TEST" for secret file "test_secrets.json" rules "allow:*:DEV_*, deny:*:TEST_*, deny:*:PROD_*" - Using Secret Config API
* Looking at pipeline "In-group-TEST" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "failed" on pipeline with label "2" - On Swift Dashboard page
* On Job details page of pipeline "In-group-TEST" counter "2" stage "defaultStage" counter "1" job "defaultJob"
* Verify console log contains message "does not have permission to refer to secrets using secret config 'TEST'"

* Update secret config "PROD" for secret file "prod_secrets.json" rules "deny:*:DEV_*, deny:*:TEST_*, allow:environment:PROD_ENV" - Using Secret Config API
* Looking at pipeline "In-group-PROD" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "failed" on pipeline with label "2" - On Swift Dashboard page
* On Job details page of pipeline "In-group-PROD" counter "2" stage "defaultStage" counter "1" job "defaultJob"
* Verify console log contains message "does not have permission to refer to secrets using secret config 'PROD'"

* Looking at pipeline "In-env-PROD" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page
* On Job details page of pipeline "In-env-PROD" counter "2" stage "defaultStage" counter "1" job "defaultJob"
* Verify console log contains message "Using environment level var : ******"


Teardown of contexts
____________________
* As user "admin" for teardown
* Capture go state "SecretManagement" - teardown
* Logout - from any page
* With "2" live agents - teardown
