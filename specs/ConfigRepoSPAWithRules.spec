ConfigRepoSPAWithRules
=========

ConfigRepoSPAWithRules
-------------------
tags: config-repo-spa, spa, config-repo-rules

Setup of contexts
* Secure Configuration - setup
* Capture go state "ConfigRepoSPAWithRules" - setup
* Login as "admin" - setup

* On Config repo page
* Create a new config repo environment with name "team1-prod-environment" on repo "1"
* Wait for config repo changes to sync
* Verify that the "config-repo-with-rules" is successfully parsed with environment "team1-prod-environment"
* Create a new config repo environment with name "team2-prod-environment" on repo "1"
* Wait for config repo changes to sync
* Verify that the "config-repo-with-rules" has failed to parse with rule validation error on "environment" "team2-prod-environment"

* Create a new config repo pipeline with name "team1-prod-deployment" on repo "1" as downstream of "team1-stage-test"
* Verify pipeline "team1-prod-deployment" shows up - On Swift Dashboard page

* Create a new config repo pipeline with name "team2-prod-deployment" on repo "1" as downstream of "team2-stage-test"
* On Config repo page
* Wait for config repo changes to sync
* Verify that the "config-repo-with-rules" has failed to parse with rule validation error on "pipeline" "team2-stage-test"

* Create a new config repo pipeline with name "group-not-allowed" on repo "2" as downstream of "team1-stage-test"

* On Config repo page
* Wait for config repo changes to sync
* Verify that the "config-repo-with-rules-on-group" has failed to parse with rule validation error on "pipeline group" "configrepo"


Teardown of contexts
____________________

* Logout - from any page
* Capture go state "ConfigRepoSPAWithRules" - teardown
