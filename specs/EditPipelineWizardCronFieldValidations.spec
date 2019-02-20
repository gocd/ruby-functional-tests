

EditPipelineWizardCronFieldValidations
======================================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "edit-pipeline" - setup
* Capture go state "EditPipelineWizardCronFieldValidations" - setup

EditPipelineWizardCronFieldValidations
--------------------------------------

tags:Clicky Admin

* On Swift Dashboard Page
* Looking at pipeline "edit-pipeline" - On Swift Dashboard page
* Edit pipeline "edit-pipeline"

* Open tab "Parameters" - On Pipeline Creation Page

* Add parameter name "cron_time_specifier" and value "0 30 10-13 ? * WED-FRI"
* Add parameter name "partial_cron_time_specifier" and value "0 30 10-13 ? *"
* Save Changes

* Open tab "General Options" - On Pipeline Creation Page

* Set cron field as "#{cron_time_specifier}" and validate error message as "Saved successfully."
* Set cron field as "#{partial_cron_time_specifier} WED-FRI" and validate error message as "Saved successfully."
* Set cron field as "#(cron_time_specifier} #{partial_cron_time_specifier}" and validate error message as "Save failed, see errors below"
* Set cron field as "${env_cron_time_specifier}" and validate error message as "Save failed, see errors below"
* Set cron field as "${env_partial_cron_specifier}" and validate error message as "Save failed, see errors below"

* Open tab "Environment Variables" - On Pipeline Creation Page

* Enter Environment variable name "env_cron_specifier" with value "0 30 10-13 ? * WED-FRI"
* Enter Environment variable name "env_partial_cron_specifier" with value "0 30 10-13 ? * "
* Save Changes


* Open tab "General Options" - On Pipeline Creation Page

* Set cron field as "${env_cron_specifier}" and validate error message as "Save failed, see errors below"
* Set cron field as "${env_partial_cron_specifier}" and validate error message as "Save failed, see errors below"



Teardown of contexts
____________________
* Capture go state "EditPipelineWizardCronFieldValidations" - teardown



