PackageRepositoryTabForm
========================

Setup of contexts
* Setup http based yum repo - setup
* Package Repository configuration - setup
* Using pipeline "pipeline1" - setup
* Capture go state "PackageRepositoryTabForm" - setup

PackageRepositoryTabForm
------------------------

tags: package repository


* Open "Package Repositories" tab

 Enter repository name as "repo-1"
 Select "yum" plugin
 Enter repo url as "http://localhost:8081/${runtime_package_http_repo_name:http_repo1}"
 Verify check connection gives message containing "401"
 Click save - Already on Package Repositories tab
 Verify repository listing contains "repo-1"

* On Admin page
* Open "Package Repositories" tab

 Verify add new repository form is shown
 Click on "repo-1" in repository listing
 Verify repo details are filled with name "repo-1" plugin "yum" and non secure configuration "http://localhost:8081/${runtime_package_http_repo_name:http_repo1}"
 Enter username as "user"
 Enter password as "password"
 Verify check connection gives message containing "Connection OK"
 Click save - Already on Package Repositories tab
 Verify repo details are filled with name "repo-1" plugin "yum" and non secure configuration "http://localhost:8081/${runtime_package_http_repo_name:http_repo1},user"


* On Admin page
* Open "Pipelines" tab

* Edit pipeline "pipeline1"

 Open material listing page

 Open new package material creation popup

 Select repository "repo-1"
 Select option "addNew" - AlreadyOnPackageMaterialCreationPopup
 Enter package name "go-server" and spec "go-server"
 Verify check package gives message containing "HTTP/1.1 401 Unauthorized"


Teardown of contexts
____________________
* Capture go state "PackageRepositoryTabForm" - teardown
* Logout - from any page
* Setup http based yum repo - teardown
