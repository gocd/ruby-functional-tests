PackageRepositorySPA
========================

Setup of contexts
* Package Repository configuration - setup
* Using pipeline "pipeline_with_yum_repo_package_as_material" - setup
* Capture go state "PackageRepositoryTabForm" - setup

PackageRepositorySPA
------------------------

tags: package-repository

* Open Package repositories page
* Click on add package repository
* Enter repository name as "repo-name"
* Select "Yum Plugin" plugin
* Enter repo url as "file:///tmp/packagerepo/file_repo/"
* Click save - Already on Package Repositories tab
* Verify message "The package repository repo-name was created successfully!" for package repo spa
* Verify repository listing contains "repo-name"
* Open Configuration for "repo-name"
* Verify that following configurations exist for "repo-name"
        | id                        | value                              |
        |---------------------------| -----------------------------------|
        | key-value-value-plugin-id | yum                                |
        | key-value-value-repo-url  | file:///tmp/packagerepo/file_repo/ |

~~~~~~~~~~~~~~~~~~ Clone package repo ~~~~~~~~~~~~~~~~~~

* Clone package repository "repo-name"
* Enter repository name as "clone"
* Click save - Already on Package Repositories tab
* Verify message "The package repository clone was created successfully!" for package repo spa
* Verify repository listing contains "clone"

~~~~~~~~~~~~~~~~~~ Edit package repo ~~~~~~~~~~~~~~~~~~

* Edit package repository "clone"
* Enter repo url as "file:///tmp/packagerepo/new_repo/"
* Click save - Already on Package Repositories tab
* Verify message "The package repository clone was updated successfully!" for package repo spa

~~~~~~~~~~~~~~~~~~ Delete package repo ~~~~~~~~~~~~~~~~~~

* Delete package repository "clone"
* Confirm delete package repository
* Verify message "The package repository clone was deleted successfully!" for package repo spa
* Verify repository listing does not contains "clone"

~~~~~~~~~~~~~~~~~~ Add package ~~~~~~~~~~~~~~~~~~

* Open Package repositories page
* Click on add package for "repo-name"
* Set package name as "pkg-name"
* Set spec as "yum-spec"
* Click save - Already on Package Repositories tab
* Verify message "The package pkg-name was created successfully!" for package repo spa
* Verify package "pkg-name" exists
* Open package panel for "pkg-name"
* Verify that following package configurations exist for "pkg-name"
        | id                           | value     |
        |----------------------------- | ----------|
        | key-value-value-name         | pkg-name  |
        | key-value-value-auto-update  | false     |
        | key-value-value-package-spec | yum-spec  |

~~~~~~~~~~~~~~~~~~ Clone package ~~~~~~~~~~~~~~~~~~

* Clone package "pkg-name"
* Set package name as "clone-pkg"
* Set spec as "cloned-yum-spec"
* Click save - Already on Package Repositories tab
* Verify message "The package clone-pkg was created successfully!" for package repo spa
* Verify package "clone-pkg" exists

~~~~~~~~~~~~~~~~~~ Edit package ~~~~~~~~~~~~~~~~~~

* Edit package "clone-pkg"
* Set spec as "update-yum-spec"
* Click save - Already on Package Repositories tab
* Verify message "The package clone-pkg was updated successfully!" for package repo spa

~~~~~~~~~~~~~~~~~~ Delete package ~~~~~~~~~~~~~~~~~~

* Delete package "clone-pkg"
* Confirm delete package repository
* Verify message "The package clone-pkg was deleted successfully!" for package repo spa
* Verify package "clone-pkg" does not exists

~~~~~~~~~~~~~~~~~~ Usages for package ~~~~~~~~~~~~~~~~~~

* Click usages for package "pkg-name"
* Verify message "No usages for package 'pkg-name' found." for usages
* On package repository page: press ok

Teardown of contexts
____________________
* Capture go state "PackageRepositoryTabForm" - teardown
* Logout - from any page
