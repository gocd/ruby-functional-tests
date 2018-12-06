
CruiseErrorMessages
===================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline with nonexisting material "basic-pipeline-with-all-materials" - setup
* Capture go state "CruiseErrorMessages" - setup

CruiseErrorMessages
-------------------

tags: error_messages
* Looking at pipeline "basic-pipeline-with-all-materials" - On Swift Dashboard page
* Using timer with spec "* ? ? ? * ? 2012"
* Trigger pipeline - On Swift Dashboard page
* On Admin page
* Verify there are "5" errors
* Open error messages popup

* Verify error description contains "Failed to run git clone command"
* Verify error description contains "Error while executing [hg clone"
* Verify error description contains "Error performing command: --- Command --- svn log"
* Verify error description contains "Error while executing [p4 login]"
* Verify message contains "Invalid Configuration"
* Verify error description contains "Invalid content was found starting with element 'timer'"

* On Swift Dashboard Page
* Turn on AutoRefresh - On Swift Dashboard page
* set timer with spec "* * * * * ? 2012" on server 

* Verify there are "4" errors
* Open error messages popup

* Verify message do not contain "Invalid Configuration"
* Verify error description does not contain "Invalid content was found starting with element 'timer'"

* Make cruise config file invalid

* On Admin page
* Verify there are "5" errors
* Open error messages popup

* Verify message contains "Invalid Configuration"
* Wait for "50" seconds
* Verify error description contains "Invalid content was found starting with element 'pipelines'."
* Close the error popup

Teardown of contexts
____________________
* Capture go state "CruiseErrorMessages" - teardown



