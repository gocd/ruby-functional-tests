

StageSecurityForAutoApproval
============================


Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline-with-auto-stage-security" - setup
* With "1" live agents - setup
* Capture go state "StageSecurityForAutoApproval" - setup

StageSecurityForAutoApproval
----------------------------

tags: Stage Security
* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-auto-stage-security" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Verify stage "first" is "Building" on pipeline with label "1" - On Swift Dashboard page


* Create a "stopjob" file

* Verify stage "first" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* Logout - from any page

* Login as "view"

* As user "view"
* Verify cannot trigger pipeline
* On stage details page "overview" tab for "pipeline-with-auto-stage-security" label "1" stage name "first" counter "1"

* Verify stage "first" does not have any action

* Logout - from any page

* Login as "operate"

* As user "operate"


* Verify can trigger pipeline
* Verify trigger with option is enabled
* On stage details page "overview" tab for "pipeline-with-auto-stage-security" label "1" stage name "first" counter "1"


* Verify stage "first" has action "rerun"
* Rerun stage "first" - On Stage Details page
* Verify stage "first" has action "cancel"
* Cancel "first" - On Stage Detail Page
* Logout - from any page

* Login as "operate"

* As user "operate"


* Verify can trigger pipeline
* Verify trigger with option is enabled
* On stage details page "overview" tab for "pipeline-with-auto-stage-security" label "1" stage name "first" counter "1"


* Verify stage "first" has action "Rerun"
* Rerun stage "first" - On Stage Details page
* Verify stage "first" has action "Cancel"
* Cancel "first" - On Stage Detail Page



Teardown of contexts
____________________
* Capture go state "StageSecurityForAutoApproval" - teardown
* With "1" live agents - teardown

