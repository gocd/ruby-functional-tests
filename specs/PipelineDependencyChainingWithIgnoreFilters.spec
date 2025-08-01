

PipelineDependencyChainingWithIgnoreFilters
===========================================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "autoFirst, child-of-autoFirst, grandchild-of-autoFirst" - setup
* With "2" live agents - setup
* Capture go state "PipelineDependencyChainingWithIgnoreFilters" - setup

PipelineDependencyChainingWithIgnoreFilters
-------------------------------------------

tags: dependency pipeline


* On Swift Dashboard Page
* Looking at pipeline "autoFirst" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page

* Looking at pipeline "child-of-autoFirst" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page

* Looking at pipeline "grandchild-of-autoFirst" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page



SCM Trigger

* On Swift Dashboard Page
* Looking at pipeline "autoFirst" - On Swift Dashboard page
* With material "git-first" of type "git" for pipeline "autoFirst"
* Checkin file "git-file.oneignore" as user "go <go@po.com>" with message "Added git-new-file" - On Swift Dashboard page
* Looking at pipeline "child-of-autoFirst" - On Swift Dashboard page
* With material "git-first" of type "git" for pipeline "child-of-autoFirst"
* Checkin file "git-file.oneignore" as user "go <go@po.com>" with message "Added git-new-file" - On Swift Dashboard page
* Remember current version as "git-file"



Verify dependency chaining after scm does not trigger autoFirst pipeline (due to the ignore filter) but triggers child-of-autoFirst pipeline

* On Swift Dashboard Page
* Looking at pipeline "autoFirst" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page
* Looking at pipeline "child-of-autoFirst" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" and counter "1" - On Swift Dashboard page

* Open changes section - On Swift Dashboard page

* Looking at material of type "Git" named "$git-first$"
* Verify modification "0" has revision "git-file" - On Build Cause popup
* Verify material has changed - On Build Cause popup

* On Swift Dashboard Page
* Looking at pipeline "grandchild-of-autoFirst" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" and counter "1" - On Swift Dashboard page

* Open changes section - On Swift Dashboard page
* Looking at material of type "Pipeline" named "$child-of-autoFirst$"
* Verify modification "0" has revision "$child-of-autoFirst$/2/defaultStage/1" - On Build Cause popup
* Verify material has changed - On Build Cause popup


* On Swift Dashboard Page
* Looking at pipeline "autoFirst" - On Swift Dashboard page
* With material "git-first" of type "git" for pipeline "autoFirst"
* Checkin file "git-other-file.twoignore" as user "go <go@po.com>" with message "Added git-other-file" - On Swift Dashboard page
* Looking at pipeline "child-of-autoFirst" - On Swift Dashboard page
* With material "git-first" of type "git" for pipeline "child-of-autoFirst"
* Checkin file "git-other-file.twoignore" as user "go <go@po.com>" with message "Added git-other-file" - On Swift Dashboard page
* Looking at pipeline "grandchild-of-autoFirst" - On Swift Dashboard page
* With material "git-first" of type "git" for pipeline "grandchild-of-autoFirst"
* Checkin file "git-other-file.twoignore" as user "go <go@po.com>" with message "Added git-other-file" - On Swift Dashboard page
* Remember current version as "git-other"


* On Swift Dashboard Page
* Looking at pipeline "autoFirst" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" and counter "1" - On Swift Dashboard page

* Looking at pipeline "child-of-autoFirst" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" and counter "1" - On Swift Dashboard page

* Looking at pipeline "grandchild-of-autoFirst" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "3" and counter "1" - On Swift Dashboard page

* Open changes section - On Swift Dashboard page
* Looking at material of type "Git" named "$git-first$"
* Verify modification "0" has revision "git-other" - On Build Cause popup
* Verify material has changed - On Build Cause popup




Teardown of contexts
____________________
* Capture go state "PipelineDependencyChainingWithIgnoreFilters" - teardown
* With "2" live agents - teardown

