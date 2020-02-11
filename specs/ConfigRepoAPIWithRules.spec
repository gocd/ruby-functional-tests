ConfigRepoAPIWithRules
============================

Setup of contexts
* Secure Configuration - setup
* Capture go state "ConfigRepoAPIWithRules" - setup

ConfigRepoAPIWithRules
----------------------------

tags: config_repo_api, api, config_repo_api_rules

~~~~~~~~ create config repo ~~~~~~~~

* As user "admin"

* Create config repo "cr" with rules "allow:environment:dev_env"
* Get config repo "cr" should contain rules "allow:environment:dev_env"

* Update config repo "cr" with rules "allow:environment:qa_env"
* Get config repo "cr" should contain rules "allow:environment:qa_env"


Teardown of contexts
____________________

* Capture go state "ConfigRepoAPIWithRules" - teardown
