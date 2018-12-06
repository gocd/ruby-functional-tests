
GlobalMessages
==============

Setup of contexts
* Basic Configuration - setup
* Using pipeline with nonexisting material "basic-pipeline-fast" - setup
* Capture go state "GlobalMessages" - setup

GlobalMessages
--------------

tags: error_messages

* Changing the artifacts location to "somethingNew"
* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page

* On Admin page

* Verify there are "2" errors
* Verify there are "1" warnings

* Open error messages popup

* Verify message contains "Could not trigger pipeline"
* Verify message contains "The change in the artifacts directory location will not take effect until the Go Server is restarted"

* Changing the artifacts location to "artifacts"

* On Swift Dashboard Page
* Verify there are "2" errors
* Verify there are no warnings

* Open error messages popup

* Verify message do not contain "The change in the artifacts directory location will not take effect until the Go Server is restarted"

* Close the error popup

Teardown of contexts
____________________
* Capture go state "GlobalMessages" - teardown



