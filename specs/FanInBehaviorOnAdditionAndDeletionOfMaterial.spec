
FanInBehaviorOnAdditionAndDeletionOfMaterial
============================================

Setup of contexts
* Fanin Configuration - setup
* Using pipeline "basic-auto-pipeline, grandparent, parent-left, parent-right, child-down" - setup
* With "1" live agents - setup
* Capture go state "FanInBehaviorOnAdditionAndDeletionOfMaterials" - setup

FanInBehaviorOnAdditionAndDeletionOfMaterial
--------------------------------------------

tags: diamond dependency, fanin

* On Swift Dashboard Page
* Looking at pipeline "grandparent" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "parent-left" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "parent-right" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "child-down" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page

* On Swift Dashboard Page
* Looking at pipeline "parent-right" - On Swift Dashboard page
* Edit pipeline "parent-right"

* Open "Materials" tab - On Pipeline settings page

* Select add new material of type "Git"
* Copy over material url from material url as "material-for-basic-auto-pipeline"
* Check connectivity should be successful - Already on Git Material Creation Popup
* Save Changes

* On Swift Dashboard Page
* Looking at pipeline "basic-auto-pipeline" - On Swift Dashboard page
* With material "git" of type "git" for pipeline "basic-auto-pipeline"
* Checkin file "new-file-2" as user "go <go@po.com>" with message "Added new-file 2" - On Swift Dashboard page
* Remember current version as "g2"

* On Swift Dashboard Page
* Looking at pipeline "parent-left" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "2" - On Swift Dashboard page
* Looking at pipeline "child-down" - On Swift Dashboard page
* Verify pipeline does not get triggered


* Looking at pipeline "parent-right" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "2" - On Swift Dashboard page
* Looking at pipeline "child-down" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" and counter "1" - On Swift Dashboard page


* Open changes section - On Swift Dashboard page
* Looking at material of type "Pipeline" named "$parent-left$"
* Verify modification "0" has revision "$parent-left$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$parent-right$"
* Verify modification "0" has revision "$parent-right$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* On Swift Dashboard Page
* Looking at pipeline "parent-left" - On Swift Dashboard page
* Edit pipeline "parent-left"

* Open "Materials" tab - On Pipeline settings page
* Delete material with name "git"

* On Swift Dashboard Page
* Looking at pipeline "basic-auto-pipeline" - On Swift Dashboard page
* With material "git" of type "git" for pipeline "basic-auto-pipeline"
* Checkin file "new-file-3" as user "go <go@po.com>" with message "Added new-file 3" - On Swift Dashboard page
* Remember current version as "g3"

* On Swift Dashboard Page
* Looking at pipeline "parent-right" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "3" - On Swift Dashboard page
* Looking at pipeline "child-down" - On Swift Dashboard page
* Verify pipeline does not get triggered


* Looking at pipeline "parent-left" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "3" - On Swift Dashboard page
* Looking at pipeline "child-down" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "3" and counter "1" - On Swift Dashboard page


* Open changes section - On Swift Dashboard page
* Looking at material of type "Pipeline" named "$parent-left$"
* Verify modification "0" has revision "$parent-left$/3/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$parent-right$"
* Verify modification "0" has revision "$parent-right$/3/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup


Teardown of contexts
____________________
* Capture go state "FanInBehaviorOnAdditionAndDeletionOfMaterials" - teardown
* With "1" live agents - teardown


