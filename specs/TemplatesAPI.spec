TemplatesAPI
=========

TemplatesAPI
-------------------
tags: templates, api

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Capture go state "TemplatesAPI" - setup

* As user "admin"
* Create template "T1"
* Verify returned "200" response code
* Get template "T1"
* Update template "T1"
* Verify returned "200" response code

* As user "group1admin"
* Update template "T1"
* Verify returned "401" response code

* Create template "T2"
* Verify returned "200" response code

* Get all templates should return templates "T1,T2,Template-With-Admin"
* Update template "T2"
* Verify returned "200" response code

* As user "templateAdmin"
* Get all templates should return templates "Template-With-Admin"
* Update template "Template-With-Admin"
* Verify returned "200" response code

* Create template "T3"
* Verify returned "401" response code

* Update template "T2"
* Verify returned "401" response code

* As user "admin"
* Get all templates should return templates "T1,T2,Template-With-Admin"


teardown
_______________
* Capture go state "TemplatesAPI" - teardown
* Logout - from any page
