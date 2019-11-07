RPMPackageWithMultipleRepositoryPipeline
==========================================

Setup of contexts
* Package configuration - setup
* Using pipeline "A2" - setup
* Setup file system based yum repos "repo1;repo2" - setup
* With "1" live agents in directory "RPMPackageWithMultipleRepositories" - setup
* Capture go state "RPMPackageWithMultipleRepositories" - setup

RPMPackageWithMultipleRepositoryPipeline
------------------------------------------

tags: #7467, Yum repo package, plugins-tests

* Looking at pipeline "A2" - On Swift Dashboard page
* Verify stage "1" is "Passed" - On Swift Dashboard page
* Verify pipeline is triggered by "changes" - On Swift Dashboard page


* Looking at pipeline "A2" - On Swift Dashboard page
* Open changes section - On Swift Dashboard page

* Looking at material of type "Package" named "$repo-1:P-2$"
* Verify modification "0" has revision "go-server-13.1.0-122.noarch" - On Build Cause popup
* Looking at material of type "Package" named "$repo-1:Q-2$"
* Verify modification "0" has revision "go-agent-13.1.0-16714.noarch" - On Build Cause popup

* On stage details page "materials" tab for "A2" label "1" stage name "defaultStage" counter "1"

* Looking at material of type "Package" named "repo-1:P-2"
* Verify modification "0" has revision "go-server-13.1.0-122.noarch" - Already On Build Cause Section
* Verify modification "0" is checked in by "anonymous" with comment "Trackback: Not Provided"
* Verify material has changed - Already On Build Cause Section
* Looking at material of type "Package" named "repo-2:Q-2"
* Verify modification "0" has revision "go-agent-13.1.0-16714.noarch" - Already On Build Cause Section
* Verify modification "0" is checked in by "anonymous" with comment "Trackback: Not Provided"
* Verify material has changed - Already On Build Cause Section

* On Swift Dashboard Page
* Looking at pipeline "A2" - On Swift Dashboard page

* On stage details page "materails" tab for "A2" label "1" stage name "defaultStage" counter "1"

* Looking at material of type "Package" named "repo-1:P-2"
* Verify modification "0" has revision "go-server-13.1.0-122.noarch" - Already On Build Cause Section

* Looking at material of type "Package" named "repo-1:P-2"

* Verify modification "0" is checked in by "anonymous" with comment "Trackback: Not Provided"

* Looking at material of type "Package" named "repo-1:Q-2"
* Verify modification "1" is checked in by "anonymous" with comment "Trackback: Not Provided"


* On Job details page of pipeline "A2" counter "1" stage "defaultStage" counter "1" job "defaultJob"


* Verify material tab contains revision for package materials "repo-1:P-2=go-server-13.1.0-122.noarch,repo-2:Q-2=go-agent-13.1.0-16714.noarch,modifiable_git=Added rake file and related task"

* On Admin page
* Open "Templates" tab

* Edit template "A-series"

* Open stages tab

* Open stage "defaultStage"

* Select stage type as "manual"
* Click save - Already on Edit Stage Page
* Verify that stage saved successfully - Already on edit stage page

* Publish artifacts "go-server-13.1.0-123.noarch.rpm" to "repo1"

* On Swift Dashboard Page
* Looking at pipeline "A2" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "2" - On Swift Dashboard page

* Open changes section - On Swift Dashboard page

* Looking at material of type "Package" named "$repo-1:P-2$"
* Verify modification "0" has revision "go-server-13.1.0-123.noarch" - On Build Cause popup


Teardown of contexts
____________________
* Capture go state "RPMPackageWithMultipleRepositories" - teardown
* With "1" live agents in directory "RPMPackageWithMultipleRepositories" - teardown
* Setup file system based yum repos "repo1;repo2" - teardown
* Using pipeline "A2" - teardown
* Package configuration - teardown
