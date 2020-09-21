SecretManagementWithPluginMaterial
=======

Setup of contexts
* Prepare secret config json "secrets.json" with secrets "password: secret"
* Package Repository configuration - setup
* Using pipeline "pipeline_with_yum_repo_package_as_material" - setup
* With "1" live agents - setup
* Capture go state "SecretManagementWithPluginMaterial" - setup

SecretManagement
-------

tags: secret_management, pluggable-scm, plugin-material

* Create secret config "test" for secret file "secrets.json" rules "allow:pluggable_scm:test_*" - Using Secret Config API
* Create dummy git repo
* Open Pluggable SCM page
* Click on add scm
* Enter scm name as "test_github"
* Select scm "JGit plugin" plugin
* Enter scm url as "/tmp/sample.git"
* Set scm username as "user" and password as "{{SECRET:[test][password]}}"
* Verify connection is successful
* Save scm

* On Swift Dashboard Page
* Edit pipeline "pipeline_with_yum_repo_package_as_material"
* Open "Materials" tab - On Pipeline settings page
* Select add new material of type "Plugin Materials"
* Select scm plugin "JGit plugin" and scm "test_github"
* Enter destination directory "scm"
* Save material

* On Swift Dashboard Page
* Looking at pipeline "pipeline_with_yum_repo_package_as_material" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait for "180" seconds till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "passed" - On Swift Dashboard page


Teardown of contexts
____________________
* Capture go state "SecretManagementWithPluginMaterial" - teardown
* Logout - from any page
* With "1" live agents - teardown
