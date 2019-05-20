

TfsMaterialSchedulingAndMaterialModification
============================================

Setup of contexts
* Tfs configuration - setup
* Using pipeline "tfs-pipeline-with-multiple-stages" - setup
* With "1" live agents - setup
* Capture go state "TfsMaterialSchedulingAndMaterialModification" - setup

TfsMaterialSchedulingAndMaterialModification
--------------------------------------------

tags: tfs


* On Swift Dashboard Page
* Looking at pipeline "tfs-pipeline-with-multiple-stages" - On Swift Dashboard page
* Modify and checkin file "AnotherHelloWorld.txt" as "luser" with message "interesting comment by luser"


* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "stage1" is "Passed" on pipeline with label "1" - On Swift Dashboard page
* On stage details page "overview" tab for "tfs-pipeline-with-multiple-stages" label "1" stage name "stage1" counter "1"

* Trigger stage "stage2" - On stage details page

* On Swift Dashboard Page
* Wait till stage "stage2" completed - On Swift Dashboard page
* Looking at pipeline "tfs-pipeline-with-multiple-stages" - On Swift Dashboard page
* Edit pipeline "tfs-pipeline-with-multiple-stages"
* Open "Materials" tab - On Pipeline settings page
* Edit material "tfs_mat"
* Enter project path as "$/for_tests"
* Save Changes




now trigger pipeline again with new material change
* On Swift Dashboard Page
* Looking at pipeline "tfs-pipeline-with-multiple-stages" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "stage1" is "Passed" on pipeline with label "2" - On Swift Dashboard page


verify first instance built with older material
* On stage details page "overview" tab for "tfs-pipeline-with-multiple-stages" label "1" stage name "stage1" counter "1"


* Looking at material of type "Tfs" named "tfs_mat"
* Verify material has changed - Already On Build Cause Section
* Verify modification "0" is checked in by "go.tfs.user" with comment "interesting comment by luser"


verify second instance built with newer material
* On stage details page "overview" tab for "tfs-pipeline-with-multiple-stages" label "2" stage name "stage1" counter "1"
* Looking at material of type "Tfs" named "tfs_mat"
* Verify material has changed - Already On Build Cause Section
* Verify modification "0" is checked in by "go.tfs.user" with comment "Updated SecondAdd.txt"




Teardown of contexts
____________________
* Capture go state "TfsMaterialSchedulingAndMaterialModification" - teardown
* With "1" live agents - teardown
