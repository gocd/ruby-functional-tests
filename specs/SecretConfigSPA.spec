SecretConfigSPA
========

SecretConfigSPA
-----------
tags: secret-config-spa, spa

Setup of contexts
* Ldap server - start
* Login as "admin" - setup

* Go to Secret Management page
* Create new secret config "demo" with "/path/to/file.db"
* Save secret config
* Verify flash message for secret config "The secret configuration demo was created successfully!"
* Verify if secret config "demo" is added

teardown
_______________
* As user "admin" for teardown
* With "1" live agents - teardown
* Logout - from any page
* Ldap server - stop
