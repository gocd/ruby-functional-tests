SecretManagementWithPluginAndPackageMaterial
=======

Setup of contexts
* Prepare secret config json "secrets.json" with secrets "password: secret, agent: go-agent"
* Setup file based yum repo - setup
* Package Repository configuration - setup
* Using pipeline "pipeline_with_many_material" - setup
* With "1" live agents - setup
* Capture go state "SecretManagementWithPluginMaterial" - setup

SecretManagementWithPluginAndPackageMaterial
-------

tags: secret_management, pluggable-scm, plugin-material, package-repository

* Create secret config "test" for secret file "secrets.json" rules "allow:pluggable_scm:test_*, allow:package_repository:yum-repo" - Using Secret Config API
* Create dummy git repo
* Open Pluggable SCM page
* Edit scm "test_github"
* Set scm username as "user" and password as "{{SECRET:[test][password]}}"
* Save scm

* Open Package repositories page
* Click on add package repository
* Enter repository name as "yum-repo"
* Select "Yum Plugin" plugin
* Enter repo url as "file:///tmp/packagerepo/file_repo"
* Click save - Already on Package Repositories tab
* Verify repository listing contains "yum-repo"

* Reload page
* Click on add package for "yum-repo"
* Set package name as "go-agent"
* Set spec as "{{SECRET:[test][agent]}}"
* Click save - Already on Package Repositories tab
* Verify message "The package go-agent was created successfully!" for package repo spa
* Verify package "go-agent" exists for repo "yum-repo"

* On Swift Dashboard Page
* Edit pipeline "pipeline_with_many_material"
* Open "Materials" tab - On Pipeline settings page
* Select add new material of type "Plugin Materials"
* Select scm plugin "JGit plugin" and scm "test_github"
* Enter destination directory "scm"
* Save material
* Select add new material of type "Package Materials"
* Select repository "yum-repo" and package "go-agent"
* Save material

* On Swift Dashboard Page
* Looking at pipeline "pipeline_with_many_material" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait for "180" seconds till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "passed" - On Swift Dashboard page


Teardown of contexts
____________________
* Capture go state "SecretManagementWithPluginMaterial" - teardown
* Logout - from any page
* With "1" live agents - teardown
