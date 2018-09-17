// --GO-LICENSE-START--
// Copyright 2015 ThoughtWorks, Inc.
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//    http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// --GO-LICENSE-END--

PipelineDependencyDiamond
=========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "d-up-left, d-up-right, d-down" - setup
* With "2" live agents - setup
* Capture go state "PipelineDependencyDiamond" - setup

PipelineDependencyDiamond
-------------------------

tags: diamond dependency, 3695, 3957, automate, fanin, New Item

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

* Looking at pipeline "d-up-left" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "d-up-right" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "d-down" - On Swift Dashboard page
* Verify stage "defaultStage" is "passed" on pipeline with label "1" - On Swift Dashboard page

* Looking at pipeline "d-up-left" - On Swift Dashboard page
* Checkin file "new-file-2" as user "go <go@po.com>" with message "Added new-file 2" - On Swift Dashboard page
* Remember current version as "g2"

* Looking at pipeline "d-up-right" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "passed" with label "2" - On Swift Dashboard page


* Looking at pipeline "d-up-left" - On Swift Dashboard page
* Checkin file "new-file-3" as user "go <go@po.com>" with message "Added new-file 3" - On Swift Dashboard page
* Remember current version as "g3"

* Trigger and wait for stage "defaultStage" is "passed" with label "2" - On Swift Dashboard page

* Looking at pipeline "d-up-left" - On Swift Dashboard page
* Checkin file "new-file-4" as user "go <go@po.com>" with message "Added new-file 4" - On Swift Dashboard page
* Remember current version as "g4"

* Looking at pipeline "d-up-right" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "passed" with label "3" - On Swift Dashboard page


* Looking at pipeline "d-down" - On Swift Dashboard page
* Verify stage "defaultStage" is with label "1" - On Swift Dashboard page

* Looking at pipeline "d-up-left" - On Swift Dashboard page
* Checkin file "new-file-5" as user "go <go@po.com>" with message "Added new-file 5" - On Swift Dashboard page
* Remember current version as "g5"

* Looking at pipeline "d-down" - On Swift Dashboard page
* Pause pipeline with reason "waiting for new revisions to appear" - On Swift Dashboard page
* Looking at pipeline "d-up-right" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "passed" with label "4" - On Swift Dashboard page
* Looking at pipeline "d-up-left" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "passed" with label "3" - On Swift Dashboard page

* Looking at pipeline "d-up-left" - On Swift Dashboard page
* Checkin file "new-file-6" as user "go <go@po.com>" with message "Added new-file 6" - On Swift Dashboard page
* Remember current version as "g6"

* Looking at pipeline "d-up-right" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "passed" with label "5" - On Swift Dashboard page

* Looking at pipeline "d-up-left" - On Swift Dashboard page
* Checkin file "new-file-7" as user "go <go@po.com>" with message "Added new-file 7" - On Swift Dashboard page
* Remember current version as "g7"

* Trigger and wait for stage "defaultStage" is "passed" with label "4" - On Swift Dashboard page

* Looking at pipeline "d-down" - On Swift Dashboard page
* Unpause pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page
* Open changes section - On Swift Dashboard page

* Looking at material of type "Pipeline" named "$d-up-left$"
* Verify modification "0" has revision "$d-up-left$/3/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$d-up-right$"
* Verify modification "0" has revision "$d-up-right$/4/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Git" named "git-second"
* Verify modification "0" has revision "g5" - On Build Cause popup
* Verify modification "1" has revision "g4" - On Build Cause popup
* Verify modification "2" has revision "g3" - On Build Cause popup
* Verify modification "3" has revision "g2" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* Looking at pipeline "d-up-right" - On Swift Dashboard page
* Open trigger with options - On Swift Dashboard page

* Using material "git-second" set revision to trigger with as "g3" - On Swift Dashboard page
* Trigger pipeline with options - On Swift Dashboard page

* Looking at pipeline "d-up-right" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "6" - On Swift Dashboard page

* Looking at pipeline "d-down" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "3" - On Swift Dashboard page
* Open changes section - On Swift Dashboard page

* Looking at material of type "Pipeline" named "$d-up-left$"
* Verify modification "0" has revision "$d-up-left$/2/defaultStage/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$d-up-right$"
* Verify modification "0" has revision "$d-up-right$/6/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Git" named "git-second"
* Verify modification "0" has revision "g3" - On Build Cause popup
* Verify material has not changed - On Build Cause popup

* Looking at pipeline "d-down" - On Swift Dashboard page
* Verify stage "defaultStage" is with label "3" - On Swift Dashboard page


Teardown of contexts
____________________
* Capture go state "PipelineDependencyDiamond" - teardown
* With "2" live agents - teardown