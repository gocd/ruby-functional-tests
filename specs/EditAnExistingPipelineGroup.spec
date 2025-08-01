
EditAnExistingPipelineGroup
===========================

Setup of contexts
* Group admin security configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline1,pipeline5" - setup
* Capture go state "EditPipelineGroups" - setup

EditAnExistingPipelineGroup
---------------------------

tags: 4369, Clicky Admin, pipeline group

* On Admin pipeline page

* Verify groups "group-name-to-be-changed,group4" are visible - on Admin Pipelines tab
* Edit pipeline group "group4" on pipeline page
* Set group name as "group5" - on edit group page
* Save pipeline group
* On Admin pipeline page

* Verify groups "group-name-to-be-changed,group5" are visible - on Admin Pipelines tab
* Edit pipeline group "group5" on pipeline page
* Adding "pavan" as a "admin" user
* Save pipeline group
* Verify flash message for pipeline group "Pipeline group group5 updated successfully."
* Edit pipeline group "group5" on pipeline page
* Adding "role-that-does-not-exist" as a "view" role
* Save pipeline group
* Verify roles level error message "Role \"role-that-does-not-exist\" does not exist." is present

* Logout and login as "pavan"

* On Admin pipeline page

* Verify groups "group5" are visible - on Admin Pipelines tab
* Edit pipeline group "group5" on pipeline page
* Adding "admin" as a "operate" user
* Adding "Rajeshvaran" as a "view" user
* Update "Rajeshvaran" as a "operate" user
* Adding "shilpa" as a "admin" user
* Adding "viewer" as a "view" role
* Adding "operator" as a "operate" role
* Adding "admins" as a "admin" role
* Save pipeline group

* Edit pipeline group "group5" on pipeline page
* Verify pipeline group "group5" has user "shilpa" with "admin" permissions
* Verify pipeline group "group5" has role "admins" with "admin" permissions
* Verify pipeline group "group5" has user "admin" with "operate" permissions
* Verify pipeline group "group5" has user "Rajeshvaran" with "view,operate" permissions
* Verify pipeline group "group5" has role "operator" with "operate" permissions
* Verify pipeline group "group5" has role "viewer" with "view" permissions
* Save pipeline group

* On Admin pipeline page

* Edit pipeline group "group5" on pipeline page

* Delete user permission "shilpa"
* Delete role permission "viewer"
* Save pipeline group
* Verify flash message for pipeline group "Pipeline group group5 updated successfully."

* Edit pipeline group "group5" on pipeline page
* Verify pipeline group "group5" does not have user "shilpa"
* Verify pipeline group "group5" does not have role "viewer"


Teardown of contexts
____________________
* Logout - from any page
* Capture go state "EditPipelineGroups" - teardown
