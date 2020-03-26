PackageRepositoryTabForm
========================

Setup of contexts
* Setup file based yum repo - setup
* Package Repository configuration - setup
* Using pipeline "pipeline_with_yum_repo_package_as_material" - setup
* With "1" live agents - setup
* Capture go state "PackageRepositoryTabForm" - setup

PackageRepositoryTabForm
------------------------

tags: package-repository


* Open Package repositories page
* Click on add package repository
* Enter repository name as "repo-1"
* Select "Yum Plugin" plugin
* Enter repo url as "file:///tmp/packagerepo/file_repo"
* Click save - Already on Package Repositories tab
* Verify repository listing contains "repo-1"

* On Swift Dashboard Page
* Edit pipeline "pipeline_with_yum_repo_package_as_material"

* Open "Materials" tab - On Pipeline settings page
* Select add new material of type "Package"

* Select repository "repo-1"
* Select option "addNew" - On Package Material Creation Popup
* Enter package name "go-agent" and spec "go-agent"
* Save package material

* On Swift Dashboard Page
* Looking at pipeline "pipeline_with_yum_repo_package_as_material" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait for "180" seconds till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "passed" - On Swift Dashboard page


Teardown of contexts
____________________
* Capture go state "PackageRepositoryTabForm" - teardown
* Logout - from any page
* With "1" live agents - teardown
* Setup file based yum repo - teardown
