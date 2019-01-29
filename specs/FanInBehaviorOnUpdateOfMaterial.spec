

FanInBehaviorOnUpdateOfMaterial
===============================

Setup of contexts
* Fanin Configuration - setup
* Using pipeline "d-up-left, d-up-right, d-down, basic-auto-pipeline" - setup
* With "1" live agents - setup
* Capture go state "FanInBehaviorOnChangeOfMaterials" - setup

FanInBehaviorOnUpdateOfMaterial
-------------------------------

tags: diamond dependency, fanin

                          git [g1, g2, g3, g4, g5, g6, g7]  ----------------------------------------+
                                 /                              \                                                          |
                               /                                 \                                                         |
                             /                                    \                                                        |
                           V                                      \                                                       |
left [l1(g1), l2(g3), l3(g5), l3(g7)                  V                                                     |
                    \                 right [r1(g1), r2(g2), r3(g4), r4(g5), r5(g6), r6(g3)]       |
                     \                                               /                                                    |
                      \                                            /                                                      |
                       \                                         /                                                        |
                        V                                      V                                                        |
                     down[d1(l1, r1, g1), d2(l3, r4, g5), d3(l2, r6, g3)] <------------------+


* On Swift Dashboard Page
* Looking at pipeline "d-up-left" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page

* Looking at pipeline "d-up-right" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page

* Looking at pipeline "d-down" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page
* Verify pipeline is triggered by "changes" - On Swift Dashboard page
* Click on history - On Swift Dashboard page


* Looking at pipeline with label "1"
* Verify pipeline is triggered by "changes" - On History page

* On Swift Dashboard Page
* Looking at pipeline "d-up-left" - On Swift Dashboard page
* Edit pipeline "d-up-left"

* Open "Materials" tab - On Pipeline settings page

* Edit material "git-second"
* Copy over material url from material url as "material-for-basic-auto-pipeline"
* Check connectivity should be successful - Already on Git Material Creation Popup
* Save Changes


* On Swift Dashboard Page
* Looking at pipeline "d-up-right" - On Swift Dashboard page
* Edit pipeline "d-up-right"
* Open "Materials" tab - On Pipeline settings page
* Edit material "git-second"

* Copy over material url from material url as "material-for-basic-auto-pipeline"
* Check connectivity should be successful - Already on Git Material Creation Popup
* Save Changes


* On Swift Dashboard Page
* Looking at pipeline "basic-auto-pipeline" - On Swift Dashboard page
* With material "git" of type "git" for pipeline "basic-auto-pipeline"
* Checkin file "new-file-2" as user "go <go@po.com>" with message "Added new-file 2" - On Swift Dashboard page
* Remember current version as "g2"

* On Swift Dashboard Page
* Looking at pipeline "d-up-left" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "2" - On Swift Dashboard page


* Looking at pipeline "d-down" - On Swift Dashboard page
* Verify pipeline "d-down" does not trigger and stays at label "1" - On Swift Dashboard page

* Looking at pipeline "d-up-right" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "2" - On Swift Dashboard page

* Looking at pipeline "d-down" - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" and counter "1" - On Swift Dashboard page
* Open changes section - On Swift Dashboard page

* Looking at material of type "Pipeline" named "$d-up-left$"
* Verify modification "0" has revision "$d-up-left$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$d-up-right$"
* Verify modification "0" has revision "$d-up-right$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup








Teardown of contexts
____________________
* Capture go state "FanInBehaviorOnChangeOfMaterials" - teardown
* With "1" live agents - teardown


