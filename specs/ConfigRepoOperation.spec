ConfigRepoSPA
=========

ConfigRepoSPA
-------------------
tags: config-repo-spa-operations, config-repo-spa, spa, wip

Setup of contexts
* Secure Configuration with policy for config repo - setup
* Capture go state "ConfigRepoSPA" - setup
* Login as "admin" - setup

~~~~~~~~~~~~~ as admin ~~~~~~~~~~~~~~~~~

* Create config repo "cr"
* Create config repo "cr1_1"
* Create config repo "cr2_2"

* On Config repo page
* Verify that the page contains "cr, cr1_1, cr2_2"
* Verify that the config repos "cr, cr1_1, cr2_2" have enabled action buttons



~~~~~~~~~~~~~ as admin create config repo ~~~~~~~~~~~~~~~~~

* Click on create config repo
* Enter config repo name "new-config-repo"
* Enter config repo url "/tmp/materials/gitmaterial-#{Time.now.to_i}-#{SecureRandom.hex(4)}"
* Click on save config repo
* Verify that the page contains "new-config-repo"

~~~~~~~~~~~~~ as admin edit config repo ~~~~~~~~~~~~~~~~~

* Click on edit config repo "cr"
* Click on save config repo
* Verify that the page contains "cr, cr1_1, cr2_2"


~~~~~~~~~~~~~ as admin delete config repo ~~~~~~~~~~~~~~~~~
* Click on delete config repo "cr"
* Click on confirm delete config repo
* Verify that the page does not contains "cr"

Teardown of contexts
____________________

* Capture go state "ConfigRepoSPA" - teardown
* Logout - from any page
