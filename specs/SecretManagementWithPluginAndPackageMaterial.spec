SecretManagementWithPluginAndPackageMaterial
=======

Setup of contexts
* Prepare secret config json "secrets.json" with secrets "password: secret"
* Package Repository configuration - setup
* Using pipeline "pipeline_with_many_material" - setup
* With "1" live agents - setup
* Capture go state "SecretManagementWithPluginMaterial" - setup

SecretManagementWithPluginAndPackageMaterial
-------

tags: secret_management, pluggable-scm, plugin-material

* Create secret config "test" for secret file "secrets.json" rules "allow:pluggable_scm:test_*, allow:package_repository:maven_repo" - Using Secret Config API
* Create dummy git repo
* Open Pluggable SCM page
* Edit scm "test_github"
* Set scm username as "user" and password as "{{SECRET:[test][password]}}"
* Save scm

* Open Package repositories page
* Edit package repository "maven_repo"
* Enter username as "user"
* Enter password as "{{SECRET:[test][password]}}"
* Click save - Already on Package Repositories tab

* On Swift Dashboard Page
* Edit pipeline "pipeline_with_many_material"
* Open "Materials" tab - On Pipeline settings page
* Select add new material of type "Plugin Materials"
* Select scm plugin "JGit plugin" and scm "test_github"
* Enter destination directory "scm"
* Save material
* Select add new material of type "Package Materials"
* Select repository "maven_repo" and package "gocd-plugin"
* Save material

* On Swift Dashboard Page
* Looking at pipeline "pipeline_with_many_material" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait for "180" seconds till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "passed" - On Swift Dashboard page


Teardown of contexts
____________________
* Logout - from any page
* With "1" live agents - teardown
* Capture go state "SecretManagementWithPluginMaterial" - teardown
