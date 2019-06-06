SecretConfigSPA
========

SecretConfigSPA
-----------
tags: secret-config-spa, spa

Setup of contexts
* Smoke Configuration - setup
* Login as "admin" - setup

* Go to Secret Management page
* Create new secret config "demo" with "/path/to/file.db" and resource as "first"
* Save secret config
* Verify flash message for secret config "The secret configuration demo was created successfully!"
* Verify if secret config "demo" is added

* Clone secret config "demo"
* Set secret config id as "clone_demo"
* Add new rule with directive "Deny", type "Pipeline Group" and resource "second"
* Save secret config
* Verify flash message for secret config "The secret configuration clone_demo was created successfully!"
* Verify if secret config "clone_demo" is added

* Edit secret config "clone_demo"
* Set filepath as "updated/path/to/file.db"
* Save secret config
* Verify flash message for secret config "The secret configuration clone_demo was updated successfully!"

* Delete secret config "clone_demo"
* Confirm delete secret config
* Verify flash message for secret config "Secret config with id 'clone_demo' was deleted successfully!"
* Verify if secret config "clone_demo" is not present

teardown
_______________
* As user "admin" for teardown
* With "1" live agents - teardown
* Logout - from any page
