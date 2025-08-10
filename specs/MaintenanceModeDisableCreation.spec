MaintenanceModeDisableCreation
=========

MaintenanceModeDisableCreation
-------------------
tags: maintenance_mode

Setup of contexts
* Basic Configuration - setup
* Capture go state "MaintenanceModeDisableCreation" - setup

* On Maintenance mode SPA
* Enable maintenance mode

//~~~~~~~~~~~~~~~~~ create pipeline group ~~~~~~~~~~~~~~~~~
* On Admin page
* Verify maintenance mode banner is shown
* Click on add pipeline group
* Enter pipeline group name "newly-added-group" - create pipeline group
* Click on create new pipeline group - save
* Verify error message on admin pipeline page "Server is in maintenance mode, please try later."

//~~~~~~~~~~~~~~~~~ create artifact store ~~~~~~~~~~~~~~~~~
* Go to artifact stores page
* Start creating artifact store for plugin "Dummy artifact plugin" with id "TestArtifact"
* Save store details as "server_url: http://localhost:8253/go, username: admin, password: badger"
* Verify error message on artifact store spa "Server is in maintenance mode, please try later."

//~~~~~~~~~~~~~~~~~ add auth config ~~~~~~~~~~~~~~~~~
* Start to add a new authorization config with id as "new_auth_config" for plugin "Password File Authentication Plugin for GoCD"
* Set password file path as "password.properties"
* Save authorization config
* Verify error message on auth config spa "Server is in maintenance mode, please try later."

//~~~~~~~~~~~~~~~~~ add package repo ~~~~~~~~~~~~~~~~~
* Open Package repositories page
* Click on add package repository
* Enter repository name as "repo-name"
* Select "Yum Plugin" plugin
* Enter repo url as "file:///tmp/packagerepo/file_repo/"
* Click save - Already on Package Repositories tab
* Verify error message on package repo page "Server is in maintenance mode, please try later."

//~~~~~~~~~~~~~~~~~ add pluggable scm ~~~~~~~~~~~~~~~~~
* Open Pluggable SCM page
* Click on add scm
* Enter scm name as "github"
* Select scm "JGit plugin" plugin
* Enter scm url as "https://github.com/gocd"
* Save scm
* Verify error message on pluggable scm page "Server is in maintenance mode, please try later."

//~~~~~~~~~~~~~~~~~ add secret config ~~~~~~~~~~~~~~~~~
* Go to Secret Management page
* Create new secret config "demo" with "secrets.json" and rule as "Allow", "All", "first"
* Save secret config
* Verify error message on secret config page "Server is in maintenance mode, please try later."

teardown
_______________
* Maintenance mode - teardown
* Capture go state "MaintenanceModeDisableCreation" - teardown
