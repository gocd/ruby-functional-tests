

AdministrationApiSecurity
=========================

Setup of contexts
* Group admin security configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline1, pipeline2, pipeline3" - setup
* Capture go state "AdministrationApiSecurity" - setup

AdministrationApiSecurity
-------------------------

tags: administration, api, group admin


* Logout and login as "group1Admin"

* On Admin page
* Edit pipeline group "group-name-to-be-changed"


 Making "notInAnyRoleA" an admin user
* Click on add user permission - add "admin" permission for "notInAnyRoleA"
* Click on save pipeline group

* Logout - from any page

* Login as "notInAnyRoleA"

* On Swift Dashboard Page

* Looking at pipeline "pipeline1" - On Swift Dashboard page
* Schedule should return code "202"

* Logout - from any page

* Login as "admin"

* On Admin page
* Edit pipeline group "group2"
 Remove role "group2AdminRole" from being an admin

* Logout - from any page

* Login as "group2Admin"

* Looking at pipeline "pipeline1" - On Swift Dashboard page
* Schedule should return code "403"

* Logout - from any page

Teardown of contexts
____________________
* Capture go state "AdministrationApiSecurity" - teardown
* Logout - from any page
