
ExtractTemplateFromPipeline
===========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "simple-pipeline,template-params-pipeline-trunk" - setup
* Capture go state "ExtractTemplateFromPipeline" - setup

ExtractTemplateFromPipeline
---------------------------

tags: Clicky Admin, template, #5785, 6821

* Looking at pipeline "simple-pipeline" - On Swift Dashboard page
* On Admin pipeline page

* Extract template for pipeline "simple-pipeline"
* Enter template name "template_from_pipeline" - On template popup
* Save template

* On Swift Dashboard Page
* Edit pipeline "simple-pipeline"

* Verify pipeline uses template "template_from_pipeline"
* Open "Parameters" tab
* Verify parameter with name "name" and value "value" is present

* Open "Environment Variables" tab
* Verify environment variable with name "NAME" and value "hucha_raghuveer" is present



* Open tab "General Options" - On Pipeline Creation Page
* Open template "template_from_pipeline"
* Open tab "Stages" - On Pipeline Creation Page
* Open stage "first"
* Open "Jobs" tab - On Stage settings page

* Open "Environment Variables" tab
* Verify environment variable with name "STAGE_LEVEL_VARIABLE" and value "stage" is present
* Verify environment variable with name "PARAM_VALUE_ENV_VAR" and value "#{name}" is present



* Open "Jobs" tab - On Stage settings page
* Open job "job1"
* Open "Environment Variables" tab
* Verify environment variable with name "JOB_LEVEL_VARIABLE" and value "job" is present

* On Admin pipeline page

* Verify that extract template is disabled for "template-params-pipeline-trunk"




Teardown of contexts
____________________
* Capture go state "ExtractTemplateFromPipeline" - teardown
