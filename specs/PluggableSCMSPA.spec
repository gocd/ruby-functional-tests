PluggableSCMSPA
========================

Setup of contexts
* Single Pipeline Configuration - setup
* Capture go state "PluggableSCMSPA" - setup

PluggableSCMSPA
------------------------

tags: pluggable-scm, spa

* Open Pluggable SCM page
* Click on add scm
* Enter scm name as "github"
* Select scm "Github Pull Requests Builder" plugin
* Enter scm url as "https://github.com/gocd"
* Save scm
* Verify message "The scm github was created successfully!" for scm spa
* Verify scm listing contains "github"
* Open scm configuration for "github"
* Verify that following scm configurations exist for "github"
        | id            | value                     |
        |------------   | --------------------------|
        | name          | github                    |
        | plugin-id     | github.pr                 |
        | url           | https://github.com/gocd   |

~~~~~~~~~~~~~~~~~~ Clone scm ~~~~~~~~~~~~~~~~~

* Clone scm "github"
* Enter scm name as "clone"
* Enter scm url as "https://github.com/clone"
* Save scm
* Verify message "The scm clone was created successfully!" for scm spa
* Verify scm listing contains "github, clone"

~~~~~~~~~~~~~~~~~~ Edit scm ~~~~~~~~~~~~~~~~~

* Edit scm "clone"
* Enter scm url as "https://github.com/edited"
* Save scm
* Verify message "The scm clone was updated successfully!" for scm spa

~~~~~~~~~~~~~~~~~~ Delete scm ~~~~~~~~~~~~~~~~~

* Delete scm "clone"
* Confirm delete scm
* Verify message "The scm clone was deleted successfully!" for scm spa
* Verify scm listing contains "github"

Teardown of contexts
____________________
* Capture go state "PluggableSCMSPA" - teardown
* Logout - from any page
