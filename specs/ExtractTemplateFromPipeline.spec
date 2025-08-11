
ExtractTemplateFromPipeline
===========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "simple-pipeline,template-params-pipeline-trunk" - setup
* Capture go state "ExtractTemplateFromPipeline" - setup

ExtractTemplateFromPipeline
---------------------------

tags: Clicky Admin, template

* Looking at pipeline "simple-pipeline" - On Swift Dashboard page
* On Admin pipeline page

* Extract template for pipeline "simple-pipeline"
* Enter template name "template_from_pipeline" - On template popup
* Save template

Wait for background conversion of pipeline to template to complete
* Wait for "5" seconds

* On Swift Dashboard Page
* Edit pipeline "simple-pipeline"
* Verify pipeline uses template "template_from_pipeline"
* Open "Parameters" tab - On Pipeline settings page
* Verify parameter with name "name" and value "value" is present

* Open "Environment Variables" tab - On Pipeline settings page
* Verify environment variable with name "NAME" and value "hucha_raghuveer" is present

* Open "General" tab - On Pipeline settings page
* Open template "template_from_pipeline"
* Open "Stages" tab - On Pipeline settings page
* Open stage "first"
* Open "Jobs" tab - On Stage settings page

* Open "Environment Variables" tab - On Pipeline settings page
* Verify environment variable with name "STAGE_LEVEL_VARIABLE" and value "stage" is present
* Verify environment variable with name "PARAM_VALUE_ENV_VAR" and value "#{name}" is present

* Open "Jobs" tab - On Stage settings page
* Open job "job1"
* Open "Environment Variables" tab - On Pipeline settings page
* Verify environment variable with name "JOB_LEVEL_VARIABLE" and value "job" is present

* On Admin pipeline page

* Verify that extract template is disabled for "template-params-pipeline-trunk"




Teardown of contexts
____________________
* Capture go state "ExtractTemplateFromPipeline" - teardown
