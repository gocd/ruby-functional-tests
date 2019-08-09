NewPipelineHgCredentials
===========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "edit-pipeline" - setup
* With "1" live agents - setup
* Capture go state "NewPipelineHgCredentials" - setup
NewPipelineHgCredentials
-----------------------------

tags: create pipeline,hg credentials


* Start add new pipeline in pipeline group "basic"
* Enter new pipeline name as "hg-cred-url"

* Select material type as "Mercurial"
* Set url "https://gocd_qa:$BITBUCKET_PASSWORD$@bitbucket.org/gocd_qa/hg-functional-tests" for material  "hg"
* Open Materials advanced settings
* Set branch as "default" for material "hg"
* Check connectivity should be successful

* Set stage name as "defaultStage"
* Set task as "ls"
* Set job name as "defaultJob"
* Save pipeline "hg-cred-url" successfully
 Verify "Pipeline successfully created." message is displayed
* Looking at pipeline "hg-cred-url" - On Swift Dashboard page
* Unpause pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* Start add new pipeline in pipeline group "basic"
* Enter new pipeline name as "hg-cred-attr"

* Select material type as "Mercurial"
* Set url "https://bitbucket.org/gocd_qa/hg-functional-tests" for material  "hg"
* Open Materials advanced settings
* Set "hg" username as "gocd_qa"
* Set "hg" password as "$BITBUCKET_PASSWORD$"
* Set branch as "default" for material "hg"
Removing the below step for polling of new changes - This option is removed from the new pipeline creation wizard
To bring it back after discussion and decide to provide the option on creation wizard
  Turn off Poll for new changes for "Hg" material
* Check connectivity should be successful

* Set stage name as "defaultStage"
* Set task as "ls"
* Set job name as "defaultJob"
* Save pipeline "hg-cred-attr" successfully
 Verify "Pipeline successfully created." message is displayed
* Looking at pipeline "hg-cred-attr" - On Swift Dashboard page
* Unpause pipeline - On Swift Dashboard page
* Wait for "180" seconds till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "passed" - On Swift Dashboard page

* Start add new pipeline in pipeline group "basic"
* Enter new pipeline name as "hg-ambiguous-attr"

* Select material type as "Mercurial"
* Set url "https://foo:bar@hg-functional-tests" for material  "hg"
* Open Materials advanced settings
* Set "hg" username as "foo"
* Set "hg" password as "bar"
* Set branch as "default" for material "hg"
* Check connectivity should be failed with message "- url: Ambiguous credentials, must be provided either in URL or as attributes." for "hg"

* Start add new pipeline in pipeline group "basic"
* Enter new pipeline name as "hg-ambiguous-attr"

* Select material type as "Mercurial"
* Set url "https://foo:bar@hg-functional-testssoo##default" for material  "hg"
* Open Materials advanced settings
* Set branch as "default" for material "hg"
* Check connectivity should be failed with message "- url: Ambiguous branch, must be provided either in URL or as an attribute." for "hg"


Teardown of contexts
____________________
* Capture go state "NewPipelineHgCredentials" - teardown
* With "1" live agents - teardown
