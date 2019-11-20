ConfigRepoSPA
=========

ConfigRepoSPA
-------------------
tags: config-repo-spa, spa

Setup of contexts
* Secure Configuration with policy for config repo - setup
* Capture go state "ConfigRepoSPA" - setup

~~~~~~~~~~~~~ as admin ~~~~~~~~~~~~~~~~~
* As user "admin"
* Create config repo "cr"
* Create config repo "cr1_1"
* Create config repo "cr2_2"
* Create config repo "cr3_3"
* Create config repo "cr4_4"

* Login as "admin"
* On Config repo page
* Verify that the page contains "cr, cr1_1, cr2_2, cr3_3, cr4_4"
* Verify that the config repos "cr, cr1_1, cr2_2, cr3_3, cr4_4" have enabled action buttons

~~~~~~~~~~~~~ as view ~~~~~~~~~~~~~~~~~

* Logout and login as "view"
* On Config repo page
* Verify that the page contains "cr, cr1_1, cr2_2, cr3_3, cr4_4"
* Verify that the config repos "cr, cr1_1, cr2_2, cr3_3, cr4_4" have disabled action buttons

~~~~~~~~~~~~~ as user1 ~~~~~~~~~~~~~~~~~

* Logout and login as "user1"
* On Config repo page
* Verify that the page contains "cr1_1"
* Verify that the config repos "cr1_1" have enabled action buttons

~~~~~~~~~~~~~ as user2 ~~~~~~~~~~~~~~~~~

* Logout and login as "user2"
* On Config repo page
* Verify that the page contains "cr2_2"
* Verify that the config repos "cr2_2" have enabled action buttons

~~~~~~~~~~~~~ as user3 ~~~~~~~~~~~~~~~~~

* Logout and login as "user3"
* On Config repo page
* Verify that the page contains "cr3_3"
* Verify that the config repos "cr3_3" have enabled action buttons

~~~~~~~~~~~~~ as user4 ~~~~~~~~~~~~~~~~~

* Logout and login as "user4"
* On Config repo page
* Verify that the page contains "cr, cr1_1, cr2_2, cr4_4"
* Verify that the config repos "cr, cr1_1, cr2_2, cr4_4" have enabled action buttons

~~~~~~~~~~~~~ as multiple.role.user ~~~~~~~~~~~~~~~~~

* Logout and login as "multiple.role.user"
* On Config repo page
* Verify that the page contains ""

Teardown of contexts
____________________

* Capture go state "ConfigRepoSPA" - teardown
* Logout - from any page
