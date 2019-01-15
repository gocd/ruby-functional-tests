AddNewEnvironmentFormAndTabs
============================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "basic-pipeline, basic-pipeline-fast, pipeline-with-failing-stage" - setup
* Capture go state "AddNewEnvironmentFormAndTabs" - setup

AddNewEnvironmentFormAndTabs
----------------------------

tags: environment

* Click add new environment link

Add environment with only name
* Verify "FINISH" button in "env-name" is disabled
* Verify "Next" button in "env-name" is disabled
* Verify tabs "env-pipelines,env-agents,env-vars" are disabled
* Enter environment name "foo"
* Verify "FINISH" button in "env-name" is enabled
* Verify "Next" button in "env-name" is enabled
* Verify tabs "env-pipelines,env-agents,env-vars" are enabled
* Enter environment name ""
* Verify "FINISH" button in "env-name" is disabled
* Verify "Next" button in "env-name" is disabled
* Verify tabs "env-pipelines,env-agents,env-vars" are disabled
* Enter environment name "bar"
* Verify "FINISH" button in "env-name" is enabled
* Verify "Next" button in "env-name" is enabled
* Verify tabs "env-pipelines,env-agents,env-vars" are enabled

cancel button action
* Click Cancel button on tab "env-name"
* Verify on environments page
* Click add new environment link

* Enter environment name "foo"
* Verify on "env-name" tab
* Select tab "env-pipelines"
* Verify on "env-pipelines" tab
* Click Cancel button on tab "env-pipelines"

* Verify on environments page
* Click add new environment link

* Enter environment name "foo"
* Select tab "env-agents"
* Verify on "env-agents" tab
* Click Cancel button on tab "env-agents"

* Verify on environments page
* Click add new environment link

* Enter environment name "foo"
* Select tab "env-vars"
* Verify on "env-vars" tab
* Click Cancel button on tab "env-vars"

* Click add new environment link

* Enter environment name "foo"
* Verify on "env-name" tab
* Click "Next" button in "env-name"
* Verify on "env-pipelines" tab
* Click "Next" button in "env-pipelines"
* Verify on "env-agents" tab
* Click "Next" button in "env-agents"
* Verify on "env-vars" tab
* Click no "Next" button exists in "env-vars"

Teardown of contexts
____________________
* As user "admin" for teardown
* Logout - from any page
* Capture go state "AddNewEnvironmentFormAndTabs" - teardown


