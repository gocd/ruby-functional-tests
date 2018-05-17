ArtifactStoreAPI
=========

ArtifactStoreAPI
-------------------
tags: artifact_stores, api

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Capture go state "ArtifactStoreAPI" - setup

* As user "admin"
* Create artifact store "A1"
* Verify returned "200" response code
* Get artifact store "A1"
* Update artifact store "A1"
* Verify returned "200" response code

* Create artifact store "A2"
* Verify returned "200" response code

* Create artifact store "A3"
* Verify returned "200" response code
* Delete artifact store "A3"
* Verify returned "200" response code

* Get all artifact stores should return "A1,A2"
* Update artifact store "A2"
* Verify returned "200" response code

* As unauthenticated user
* Try to create artifact store "A3"
* Verify returned "401" response code
* Try to update artifact store "A2"
* Verify returned "401" response code
* Try to get artifact store "A1"
* Verify returned "401" response code
* Try to get all artifact stores
* Verify returned "401" response code
* Try to delete artifact store "A1"
* Verify returned "401" response code

* As user "view"
* Try to create artifact store "A3"
* Verify returned "403" response code
* Try to update artifact store "A2"
* Verify returned "403" response code
* Try to get artifact store "A1"
* Verify returned "403" response code
* Try to get all artifact stores
* Verify returned "403" response code
* Try to delete artifact store "A1"
* Verify returned "403" response code

* As user "admin"
* Get all artifact stores should return "A1,A2"


teardown
_______________
* As user "admin" for teardown
* Capture go state "ArtifactStoreAPI" - teardown
* Logout - from any page
