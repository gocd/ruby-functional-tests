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
* Verify flash message for artifact "The artifact store TestArtifact was created successfully!"
* Expand plugin
* Verify if artifact store "TestArtifact" is present

* Clone artifact store "TestArtifact"
* Set id as "Cloned_TestArtifact"
* Save artifact store
* Verify flash message for artifact "The artifact store Cloned_TestArtifact was created successfully!"
* Verify if artifact store "Cloned_TestArtifact" is present

* Edit artifact store "Cloned_TestArtifact"   
* Save store details as "server_url: http://localhost:8253/go, username: admin, password: badger"
* Verify flash message for artifact "The artifact store Cloned_TestArtifact was updated successfully!"

* Delete artifact store spa "Cloned_TestArtifact"
* Confirm delete artifact store
* Verify flash message for artifact "The artifact store Cloned_TestArtifact was deleted successfully!"
* Verify if artifact store "Cloned_TestArtifact" is not present

teardown
_______________
* As user "admin" for teardown
* Capture go state "ExternalArtifacts" - teardown
* Logout - from any page
