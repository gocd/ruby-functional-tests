NewPipelineHgCredentials
===========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "edit-pipeline" - setup
* With "1" live agents - setup
* Capture go state "NewPipelineHgCredentials" - setup
NewPipelineHgCredentials
-----------------------------

tags: create pipeline, hg credentials


* Start add new pipeline in pipeline group "basic"
* Enter new pipeline name as "hg-cred-url"

* Select material type as "Mercurial"
* Set url "https://$HELIXTEAMHUB_USERNAME$:$HELIXTEAMHUB_PASSWORD$@helixteamhub.cloud/gocdcommunity/projects/gocd_qa/repositories/mercurial/hg-functional-tests" for material  "hg"
* Open Materials advanced settings
* Set branch as "default" for material "hg"
* Check connectivity should be successful

* Set stage name as "defaultStage"
* Set task as "ls"
* Set job name as "defaultJob"
* Save pipeline "hg-cred-url" successfully
* Looking at pipeline "hg-cred-url" - On Swift Dashboard page
* Unpause pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* Start add new pipeline in pipeline group "basic"
* Enter new pipeline name as "hg-cred-attr"

* Select material type as "Mercurial"
* Set url "https://helixteamhub.cloud/gocdcommunity/projects/gocd_qa/repositories/mercurial/hg-functional-tests" for material  "hg"
* Open Materials advanced settings
* Set "hg" username as "$HELIXTEAMHUB_USERNAME$"
* Set "hg" password as "$HELIXTEAMHUB_PASSWORD$"
* Set branch as "default" for material "hg"
* Check connectivity should be successful

* Set stage name as "defaultStage"
* Set task as "ls"
* Set job name as "defaultJob"
* Save pipeline "hg-cred-attr" successfully
* Looking at pipeline "hg-cred-attr" - On Swift Dashboard page
* Unpause pipeline - On Swift Dashboard page
* Wait for "60" seconds till pipeline completed - On Swift Dashboard page
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
