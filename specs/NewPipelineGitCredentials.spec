NewPipelineGitCredentials
===========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "edit-pipeline" - setup
* With "1" live agents - setup
* Capture go state "NewPipelineGitCredentials" - setup
NewPipelineGitCredentials
-----------------------------

tags: create pipeline,git credentials


* Start add new pipeline in pipeline group "basic"
* Enter new pipeline name as "git-cred-url"

* Select material type as "Git"
* Set url "https://gocd_qa:$BITBUCKET_PASSWORD$@bitbucket.org/gocd_qa/git-functional-tests.git" for material  "git"
* Open Materials advanced settings
* Set branch as "master" for material "git"
* Check connectivity should be successful

* Set stage name as "defaultStage"
* Set task as "ls"
* Set job name as "defaultJob"
* Save pipeline "git-cred-url" successfully
 Verify "Pipeline successfully created." message is displayed
* Looking at pipeline "git-cred-url" - On Swift Dashboard page
* Unpause pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* Start add new pipeline in pipeline group "basic"
* Enter new pipeline name as "git-cred-attr"

* Select material type as "Git"
* Set url "https://bitbucket.org/gocd_qa/git-functional-tests.git" for material  "git"
* Open Materials advanced settings
* Set "git" username as "gocd_qa"
* Set "git" password as "$BITBUCKET_PASSWORD$"
* Set branch as "master" for material "git"
Removing the below step for polling of new changes - This option is removed from the new pipeline creation wizard
To bring it back after discussion and decide to provide the option on creation wizard
 Turn off Poll for new changes for "Git" material
* Check connectivity should be successful

* Set stage name as "defaultStage"
* Set task as "ls"
* Set job name as "defaultJob"
* Save pipeline "git-cred-attr" successfully
 Verify "Pipeline successfully created." message is displayed
* Looking at pipeline "git-cred-attr" - On Swift Dashboard page
* Unpause pipeline - On Swift Dashboard page
* Wait for "180" seconds till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "passed" - On Swift Dashboard page

* Start add new pipeline in pipeline group "basic"
* Enter new pipeline name as "git-ambiguous-attr"

* Select material type as "Git"
* Set url "https://foo:bar@git-functional-tests.git" for material  "git"
* Open Materials advanced settings
* Set "git" username as "foo"
* Set "git" password as "bar"
* Set branch as "master" for material "git"
* Check connectivity should be failed with message "- url: Ambiguous credentials, must be provided either in URL or as attributes." for "git"


Teardown of contexts
____________________
* Capture go state "NewPipelineGitCredentials" - teardown
* With "1" live agents - teardown
