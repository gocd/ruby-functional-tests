

TemplatesListing
================

Setup of contexts
* Template admin configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline1,pipeline2,pipeline3,pipeline-down,pipeline-without-template" - setup
* Capture go state "TemplatesViewerAndEditor" - setup

TemplatesListing
----------------

tags:  templates

* On Admin Templates page

* Verify that templates "simple-pass,default.pipeline,unused-template" are present - on Admin Templates tab
* Verify that template "simple-pass" is used by pipelines "pipeline1,pipeline2,pipeline3"
* Verify that template "default.pipeline" is used by pipelines "pipeline-down"
* Verify that template "unused-template" has message "No pipelines associated with this template"

* Verify that edit pipeline "pipeline1" lands on pipeline edit page
* On Admin Templates page
* Verify cannot delete templates "simple-pass,default.pipeline"
* Verify can delete templates "unused-template"
* Delete template "unused-template"
* Verify that templates "simple-pass,default.pipeline" are present - on Admin Templates tab
* Verify that templates "unused-template" are not present - on Admin Templates tab
* Logout and login as "group1Admin"
* On Admin Templates page



Teardown of contexts
____________________
* Capture go state "TemplatesViewerAndEditor" - teardown
* Logout - from any page
