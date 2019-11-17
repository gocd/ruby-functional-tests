
AddNewTemplate
==============

Setup of contexts
* Basic Configuration - setup
* Using pipeline "pipeline-ls, simple-pipeline,template-params-pipeline-trunk" - setup
* Capture go state "AddNewTemplate" - setup

AddNewTemplate
--------------

tags: template

* On Admin Templates page

* Add new template

* Enter template name "some-funky-template" - On template page
* Save Template create

* Edit template "some-funky-template"

* Open tab "General Options" - On Pipeline Creation Page
* Open "Stages" tab
* Open stage "defaultStage"
* Open "Jobs" tab - On Stage settings page

* Verify "defaultJob" job is present
* Open job "defaultJob"


* Verify no tasks exists


Story: 5105 -  Create template from an existing pipeline

* On Admin Templates page

* Add new template
* Enter template name "template_from_pipeline" - On template page
* Select extract template from a existing pipeline
* Verify template can be extracted only from pipelines "pipeline-ls,simple-pipeline"
* Select pipeline "simple-pipeline" for template
* Save Template create

* On Admin pipeline page

* On Swift Dashboard Page
* Looking at pipeline "simple-pipeline" - On Swift Dashboard page

* Edit pipeline "simple-pipeline"

* Verify pipeline uses template "template_from_pipeline"
* Open "Parameters" tab
* Verify parameter with name "name" and value "value" is present

* Open "Environment Variables" tab
* Verify environment variable with name "NAME" and value "hucha_raghuveer" is present





Teardown of contexts
____________________
* Capture go state "AddNewTemplate" - teardown
