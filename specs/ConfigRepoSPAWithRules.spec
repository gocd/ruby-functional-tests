ConfigRepoSPAWithRules
=========

ConfigRepoSPAWithRules
-------------------
tags: config-repo-spa, spa, config-repo-rules

Setup of contexts
* Secure Configuration - setup
* Capture go state "ConfigRepoSPAWithRules" - setup

~~~~~~~~~~~~~ as admin ~~~~~~~~~~~~~~~~~
* Login as "admin"
* On Config repo page
* Verify that the page contains "config-repo"
* Create a new config repo environment with name "config-repo-environment" on repo "1"
* Wait for config repo changes to sync
* Verify that the "config-repo" is successfully parsed with environment "config-repo-environment"
* Create a new config repo environment with name "invalid-config-repo-environment" on repo "1"
* Wait for config repo changes to sync
* Verify that the "config-repo" has failed to parse with rule validation error on "invalid-config-repo-environment"

Teardown of contexts
____________________

* Capture go state "ConfigRepoSPAWithRules" - teardown
* Logout - from any page
