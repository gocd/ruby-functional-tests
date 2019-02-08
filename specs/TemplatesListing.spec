

TemplatesListing
================

Setup of contexts
* Template admin configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline1,pipeline2,pipeline3,pipeline-down,pipeline-without-template" - setup
* Capture go state "TemplatesViewerAndEditor" - setup

TemplatesListing
----------------

tags:  Clicky Admin

* On Admin page
* Open "Templates" tab

* Verify that templates "simple-pass,default.pipeline,unused" are present - on Admin Templates tab
* Verify that template "simple-pass" is used by pipelines "pipeline1,pipeline2,pipeline3"
* Verify that template "default.pipeline" is used by pipelines "pipeline-down"
* Verify that template "unused" has message "No pipelines associated with this template"

* Verify that edit pipeline "pipeline1" lands on pipeline edit page
* Verify cannot delete templates "simple-pass,default.pipeline"
* Verify can delete templates "unused"
* Delete template "unused"
* Verify that templates "simple-pass,default.pipeline" are present - on Admin Templates tab
* Verify that templates "unused" are not present - on Admin Templates tab
* Logout and login as "group1Admin"
* On Admin page
* Verify templates tab is visible






Teardown of contexts
____________________
* Capture go state "TemplatesViewerAndEditor" - teardown
* Logout - from any page


