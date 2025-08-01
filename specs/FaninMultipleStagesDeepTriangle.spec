
FaninMultipleStagesDeepTriangle
===============================

Setup of contexts
* Fanin Configuration - setup
* Using pipeline "DeepC1, DeepC2, DeepC3, DeepC4-auto, DeepC5, DeepC6" - setup
* With "3" live agents - setup
* Capture go state "FaninMultipleStagesDeepTriangle" - setup

FaninMultipleStagesDeepTriangle
-------------------------------

tags: diamond dependency, multiple stages

* On Swift Dashboard Page
* Looking at pipeline "DeepC1" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till stage "first_stage" completed - On Swift Dashboard page
* Verify stage "first_stage" is "Passed" on pipeline with label "1" - On Swift Dashboard page


* On Swift Dashboard Page
* Looking at pipeline "DeepC5" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till stage "first_stage" completed - On Swift Dashboard page
* Verify stage "first_stage" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* On Swift Dashboard Page
* Looking at pipeline "DeepC6" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till stage "first_stage" completed - On Swift Dashboard page
* Verify stage "first_stage" is "Passed" on pipeline with label "1" - On Swift Dashboard page



* On Swift Dashboard Page
* Looking at pipeline "DeepC1" - On Swift Dashboard page
* On stage details page "overview" tab for "DeepC1" label "1" stage name "first_stage" counter "1"
* Trigger stage "second_stage" - On stage details page
* On Swift Dashboard Page
* Wait till stage "second_stage" completed - On Swift Dashboard page
* Verify stage "second_stage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page


* On Swift Dashboard Page
* Looking at pipeline "DeepC5" - On Swift Dashboard page
* On stage details page "overview" tab for "DeepC5" label "1" stage name "first_stage" counter "1"
* Trigger stage "second_stage" - On stage details page
* On Swift Dashboard Page
* Wait till stage "second_stage" completed - On Swift Dashboard page
* Verify stage "second_stage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page

* On Swift Dashboard Page
* Looking at pipeline "DeepC6" - On Swift Dashboard page
* On stage details page "overview" tab for "DeepC6" label "1" stage name "first_stage" counter "1"
* Trigger stage "second_stage" - On stage details page
* On Swift Dashboard Page
* Wait till stage "second_stage" completed - On Swift Dashboard page
* Verify stage "second_stage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page



* On Swift Dashboard Page
* Looking at pipeline "DeepC2" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till stage "first_stage" completed - On Swift Dashboard page
* Verify stage "first_stage" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* On Swift Dashboard Page
* Looking at pipeline "DeepC2" - On Swift Dashboard page
* On stage details page "overview" tab for "DeepC2" label "1" stage name "first_stage" counter "1"
* Trigger stage "second_stage" - On stage details page
* On Swift Dashboard Page
* Wait till stage "second_stage" completed - On Swift Dashboard page
* Verify stage "second_stage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page


* On Swift Dashboard Page
* Looking at pipeline "DeepC3" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till stage "first_stage" completed - On Swift Dashboard page
* Verify stage "first_stage" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* On Swift Dashboard Page
* Looking at pipeline "DeepC3" - On Swift Dashboard page
* On stage details page "overview" tab for "DeepC3" label "1" stage name "first_stage" counter "1"
* Trigger stage "second_stage" - On stage details page
* On Swift Dashboard Page
* Wait till stage "second_stage" completed - On Swift Dashboard page
* Verify stage "second_stage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page


* On Swift Dashboard Page
* Looking at pipeline "DeepC4-auto" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "second_stage" is "passed" on pipeline with label "1" - On Swift Dashboard page

* On Swift Dashboard Page
* Looking at pipeline "DeepC1" - On Swift Dashboard page
* With material "git-one" of type "git" for pipeline "DeepC1"
* Checkin file "new-file-2" as user "go <go@po.com>" with message "Added new-file 2" - On Swift Dashboard page
* Remember current version as "git-one-g2"


* On Swift Dashboard Page
* Trigger pipeline - On Swift Dashboard page
* Looking at pipeline "DeepC1" - On Swift Dashboard page
* Wait till stage "first_stage" completed - On Swift Dashboard page
* Verify stage "first_stage" is "Passed" on pipeline with label "2" - On Swift Dashboard page

* On Swift Dashboard Page
* Looking at pipeline "DeepC1" - On Swift Dashboard page
* On stage details page "overview" tab for "DeepC1" label "2" stage name "first_stage" counter "1"
* Trigger stage "second_stage" - On stage details page
* On Swift Dashboard Page
* Wait till stage "second_stage" completed - On Swift Dashboard page
* Verify stage "second_stage" is "Passed" on pipeline with label "2" and counter "1" - On Swift Dashboard page

* On Swift Dashboard Page
* Looking at pipeline "DeepC4-auto" - On Swift Dashboard page
* Verify pipeline does not get triggered

* On Swift Dashboard Page
* Looking at pipeline "DeepC2" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till stage "first_stage" completed - On Swift Dashboard page
* Verify stage "first_stage" is "Passed" on pipeline with label "2" - On Swift Dashboard page

* On Swift Dashboard Page
* Looking at pipeline "DeepC3" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till stage "first_stage" completed - On Swift Dashboard page
* Verify stage "first_stage" is "Passed" on pipeline with label "2" - On Swift Dashboard page


* On Swift Dashboard Page
* Looking at pipeline "DeepC4-auto" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "second_stage" is "passed" on pipeline with label "2" - On Swift Dashboard page


* Open changes section - On Swift Dashboard page
* Looking at material of type "Pipeline" named "$DeepC3$"
* Verify modification "0" has revision "$DeepC3$/2/first_stage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$DeepC1$"
* Verify modification "0" has revision "$DeepC1$/2/first_stage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$DeepC5$"
* Verify modification "0" has revision "$DeepC5$/1/first_stage/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$DeepC6$"
* Verify modification "0" has revision "$DeepC6$/1/second_stage/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup


* On Swift Dashboard Page
* Looking at pipeline "DeepC5" - On Swift Dashboard page
* With material "git-two" of type "git" for pipeline "DeepC5"
* Checkin file "new-file-2" as user "go <go@po.com>" with message "Added new-file 2" - On Swift Dashboard page
* Remember current version as "git-two-g2"


* On Swift Dashboard Page
* Looking at pipeline "DeepC5" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till stage "first_stage" completed - On Swift Dashboard page
* Verify stage "first_stage" is "Passed" on pipeline with label "2" - On Swift Dashboard page


* On Swift Dashboard Page
* Looking at pipeline "DeepC5" - On Swift Dashboard page
* On stage details page "overview" tab for "DeepC5" label "2" stage name "first_stage" counter "1"
* Trigger stage "second_stage" - On stage details page
* On Swift Dashboard Page
* Wait till stage "second_stage" completed - On Swift Dashboard page
* Verify stage "second_stage" is "Passed" on pipeline with label "2" and counter "1" - On Swift Dashboard page



* On Swift Dashboard Page
* Looking at pipeline "DeepC6" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till stage "first_stage" completed - On Swift Dashboard page
* Verify stage "first_stage" is "Passed" on pipeline with label "2" - On Swift Dashboard page

* On Swift Dashboard Page
* Looking at pipeline "DeepC6" - On Swift Dashboard page
* On stage details page "overview" tab for "DeepC6" label "2" stage name "first_stage" counter "1"
* Trigger stage "second_stage" - On stage details page
* On Swift Dashboard Page
* Wait till stage "second_stage" completed - On Swift Dashboard page
* Verify stage "second_stage" is "Passed" on pipeline with label "2" and counter "1" - On Swift Dashboard page

* On Swift Dashboard Page
* Looking at pipeline "DeepC4-auto" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "second_stage" is "passed" on pipeline with label "3" - On Swift Dashboard page


* Open changes section - On Swift Dashboard page
* Looking at material of type "Pipeline" named "$DeepC3$"
* Verify modification "0" has revision "$DeepC3$/2/first_stage/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$DeepC1$"
* Verify modification "0" has revision "$DeepC1$/2/first_stage/1" - On Build Cause popup
* Verify material has not changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$DeepC5$"
* Verify modification "0" has revision "$DeepC5$/2/first_stage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup
* Looking at material of type "Pipeline" named "$DeepC6$"
* Verify modification "0" has revision "$DeepC6$/2/second_stage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup


Teardown of contexts
____________________
* With "3" live agents - teardown
* Capture go state "FaninMultipleStagesDeepTriangle" - teardown
