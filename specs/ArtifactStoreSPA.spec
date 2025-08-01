ArtifactStoreSPA
=========

ArtifactStoreSPA
-------------------
tags: artifact-store-spa-foo, spa

Setup of contexts
* External Artifacts Configuration - setup
* Login as "admin" - setup

* Go to artifact stores page
* Start creating artifact store for plugin "Dummy artifact plugin" with id "TestArtifact"
* Save store details as "server_url: http://localhost:8253/go, username: admin, password: badger"
* Expand plugin
* Verify if artifact store "TestArtifact" is present

* Clone artifact store "TestArtifact"
* Set id as "Cloned_TestArtifact"
* Save artifact store
* Verify if artifact store "Cloned_TestArtifact" is present

* Edit artifact store "Cloned_TestArtifact"
* Save store details as "server_url: http://localhost:8253/go, username: admin, password: badger"

* Delete artifact store spa "Cloned_TestArtifact"
* Confirm delete artifact store
* Verify if artifact store "Cloned_TestArtifact" is not present

teardown
_______________
* As user "admin" for teardown
* Logout - from any page
* Capture go state "ExternalArtifacts" - teardown
