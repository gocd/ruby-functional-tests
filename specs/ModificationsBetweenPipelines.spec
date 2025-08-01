
ModificationsBetweenPipelines
=============================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "mingle-config-parent, pipeline-with-mingle-config" - setup
* With "1" live agents - setup
* Capture go state "ModificationsBetweenPipelines" - setup

ModificationsBetweenPipelines
-----------------------------

tags: card_activity

* On Swift Dashboard Page
* Looking at pipeline "mingle-config-parent" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "hello-world-1" - On Swift Dashboard page
* Looking at pipeline "pipeline-with-mingle-config" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* With material "pipeline-git0" of type "git" for pipeline "pipeline-with-mingle-config"
* Checkin file "foo.text" as user "user" with message "Comment user" - On Swift Dashboard page
* Remember current version as "git0-1-0"

* Checkin file "bar.text" as user "loser" with message "Comment loser" - On Swift Dashboard page
* Remember current version as "git0-1-1"

* Checkin file "baz.text" as user "user-loser" with message "Comment user-loser" - On Swift Dashboard page
* Remember current version as "git0-1-2"

* With material "pipeline-git" of type "git" for pipeline "pipeline-with-mingle-config"
* Checkin file "foo-git.c" as user "dev <dev@thoughtworks.com>" with message "foo added to git" - On Swift Dashboard page
* Remember current version as "git-1-0"

* Checkin file "bar-git.c" as user "other-dev <dev@thoughtworks.com>" with message "bar added to git" - On Swift Dashboard page
* Remember current version as "git-1-1"

* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-mingle-config" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page


* With material "pipeline-git0" of type "git" for pipeline "pipeline-with-mingle-config"
* Checkin file "hello.txt" as user "world" with message "hello world" - On Swift Dashboard page
* Remember current version as "git0-2-0"

* Checkin file "world.txt" as user "hello" with message "world hello" - On Swift Dashboard page
* Remember current version as "git0-2-1"

* With material "pipeline-git" of type "git" for pipeline "pipeline-with-mingle-config"
* Checkin file "hello-git.txt" as user "git-user <loser@thoughtworks.com>" with message "said hello to git" - On Swift Dashboard page
* Remember current version as "git-2-0"



* On Swift Dashboard Page
* Looking at pipeline "mingle-config-parent" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "hello-world-2" - On Swift Dashboard page

* Looking at pipeline "pipeline-with-mingle-config" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "3" - On Swift Dashboard page

* On Pipeline Compare page from "2" build to "3"
 Select "Changes" tab
* Verify displays revision "git0-2-0" having comment "hello world" under "Git"
* Verify displays revision "git0-2-1" having comment "world hello" under "Git"
* Verify displays revision "git-2-0" having comment "said hello to git" under "Git"
* Verify displays revision "$mingle-config-parent$/2/defaultStage/1" having label "hello-world-2" under pipeline named "$mingle-config-parent$"

Diff with nth previous pipeline with n being "2"

Select "Changes" tab

* On Pipeline Compare page from "1" build to "3"
* Verify displays revision "git0-1-0" having comment "Comment user" under "Git"
* Verify displays revision "git0-1-1" having comment "Comment loser" under "Git"
* Verify displays revision "git0-1-2" having comment "Comment user-loser" under "Git"
* Verify displays revision "git-1-0" having comment "foo added to git" under "Git"
* Verify displays revision "git-1-1" having comment "bar added to git" under "Git"
* Verify displays revision "$mingle-config-parent$/2/defaultStage/1" having label "hello-world-2" under pipeline named "$mingle-config-parent$"





Teardown of contexts
____________________
* With "1" live agents - teardown
* Capture go state "ModificationsBetweenPipelines" - teardown
