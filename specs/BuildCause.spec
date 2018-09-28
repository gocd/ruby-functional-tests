BuildCause
==========

Setup of contexts
* Basic Configuration - setup
* Using pipeline "basic-pipeline-run-till-file-exists, downstream" - setup
* With "1" live agents - setup
* Capture go state "BuildCause" - setup

BuildCause
----------

tags: new_dasboard, build_cause

* Looking at pipeline "basic-pipeline-run-till-file-exists" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Create a "stopjob" file and validate pipeline completed
* Verify pipeline is triggered by "anonymous" - On Swift Dashboard page
* On stage details page "materials" tab for "basic-pipeline-run-till-file-exists" label "1" stage name "defaultStage" counter "1"

* Looking at material of type "Git" named "git"
* Verify modification "0" has latest revision
* Verify material has changed - Already On Build Cause Section

* On Swift Dashboard Page
* Looking at pipeline "downstream" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Create a "stopjob" file and validate pipeline completed
* On stage details page "materials" tab for "downstream" label "1" stage name "defaultStage" counter "1"

* Looking at material of type "Pipeline" named "basic-pipeline-run-till-file-exists-downstream"
* Verify modification "0" has revision "basic-pipeline-run-till-file-exists/1/defaultStage/1" - Already On Build Cause Section
* Verify material has changed - Already On Build Cause Section

* Looking at pipeline "basic-pipeline-run-till-file-exists" - On Swift Dashboard page
* Checkin file "foo.txt" as user "user" with message "Comment user" - On Swift Dashboard page
* Checkin file "bar.txt" as user "loser" with message "Comment loser" - On Swift Dashboard page

* On Swift Dashboard Page
* Trigger pipeline - On Swift Dashboard page
* Create a "stopjob" file and validate pipeline completed

* On stage details page "materials" tab for "basic-pipeline-run-till-file-exists" label "2" stage name "defaultStage" counter "1"
* Looking at material of type "Git" named "git"

* Verify modification "0" is checked in by "loser" with comment "Comment loser"
* Verify modification "1" is checked in by "user" with comment "Comment user"
* Verify material has changed - Already On Build Cause Section

* On Swift Dashboard Page
* Looking at pipeline "basic-pipeline-run-till-file-exists" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Create a "stopjob" file and validate pipeline completed
* On stage details page "materials" tab for "basic-pipeline-run-till-file-exists" label "3" stage name "defaultStage" counter "1"

* Looking at material of type "Git" named "git"
* Verify modification "0" is checked in by "loser" with comment "Comment loser"
* Verify material has not changed - Already On Build Cause Section


* On Swift Dashboard Page
* Looking at pipeline "downstream" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Create a "stopjob" file and validate pipeline completed

* On stage details page "materials" tab for "downstream" label "2" stage name "defaultStage" counter "1"
* Looking at material of type "Pipeline" named "basic-pipeline-run-till-file-exists"
* Verify modification "0" has revision "basic-pipeline-run-till-file-exists/3/defaultStage/1" - Already On Build Cause Section
* Verify material has changed - Already On Build Cause Section

* On Swift Dashboard Page
* Looking at pipeline "downstream" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Create a "stopjob" file and validate pipeline completed

* On stage details page "materials" tab for "downstream" label "3" stage name "defaultStage" counter "1"
* Looking at material of type "Pipeline" named "basic-pipeline-run-till-file-exists"
* Verify modification "0" has revision "basic-pipeline-run-till-file-exists/3/defaultStage/1" - Already On Build Cause Section
* Verify material has not changed - Already On Build Cause Section


Teardown of contexts
____________________
* Capture go state "BuildCause" - teardown
* With "1" live agents - teardown
