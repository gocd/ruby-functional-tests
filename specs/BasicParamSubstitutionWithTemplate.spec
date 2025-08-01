

BasicParamSubstitutionWithTemplate
==================================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "template-params-pipeline-trunk, template-params-pipeline-branch" - setup
* With "1" live agents - setup
* Capture go state "BasicParamSubstitutionWithTemplate" - setup

BasicParamSubstitutionWithTemplate
----------------------------------

tags: params, template

* On Swift Dashboard Page
* Trigger pipeline "template-params-pipeline-trunk" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* On Job details page of pipeline "template-params-pipeline-trunk" counter "1" stage "defaultStage" counter "1" job "defaultJob"
* Verify console log contains message "echo trunk-dir"

* On Swift Dashboard Page
* Trigger pipeline "template-params-pipeline-branch" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* On Job details page of pipeline "template-params-pipeline-branch" counter "1" stage "defaultStage" counter "1" job "defaultJob"
* Verify console log contains message "echo branch-dir"



Teardown of contexts
____________________
* Capture go state "BasicParamSubstitutionWithTemplate" - teardown
* With "1" live agents - teardown


