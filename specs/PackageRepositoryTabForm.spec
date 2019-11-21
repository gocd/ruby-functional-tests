PackageRepositoryTabForm
========================

Setup of contexts
* Setup http based yum repo - setup
* Package Repository configuration - setup
* Using pipeline "pipeline_with_yum_repo_package_as_material" - setup
* Capture go state "PackageRepositoryTabForm" - setup

PackageRepositoryTabForm
------------------------

tags: package-repository


* Open Package repositories page

* Enter repository name as "repo-1"
* Select "yum" plugin
* Enter repo url as "http://localhost:8081/http_repo1"
* Enter username as "user"
* Enter password as "password"
* Click save - Already on Package Repositories tab
* Verify repository listing contains "repo-1"

* On Swift Dashboard Page
* Edit pipeline "pipeline1"

* Open "Materials" tab - On Pipeline settings page
* Select add new material of type "Package"

* Select repository "repo-1"
* Select option "addNew" - On Package Material Creation Popup
* Enter package name "go-agent" and spec "go-agent"
* Save package material


Teardown of contexts
____________________
* Capture go state "PackageRepositoryTabForm" - teardown
* Logout - from any page
* Setup http based yum repo - teardown
