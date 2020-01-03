
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
* Adding "role-that-does-not-exist" as a "view" role for group "group5"
* Save Changes
* Verify message "Role \"role-that-does-not-exist\" does not exist." shows up - On Permission tab

* Logout and login as "pavan"

* On Admin pipeline page

* Verify groups "group5" are visible - on Admin Pipelines tab
* Edit pipeline group "group5"

* Adding "admin" as a "operate" user for group "group5"
* Adding "Rajeshvaran" as a "view" user for group "group5"
* Adding "Rajeshvaran" as a "operate" user for group "group5"
* Adding "shilpa" as a "admin" user for group "group5"
* Adding "viewer" as a "view" role for group "basic"
* Adding "operator" as a "operate" role for group "basic"
* Adding "admins" as a "admin" role for group "basic"

* Verify pipeline group "group5" has user "shilpa" with "admin" permissions
* Verify pipeline group "group5" has role "admins" with "admin" permissions
* Verify pipeline group "group5" has user "admin" with "operate" permissions
* Verify pipeline group "group5" has user "Rajeshvaran" with "view,operate" permissions
* Verify pipeline group "group5" has role "operator" with "operate" permissions
* Verify pipeline group "group5" has role "viewer" with "view" permissions

* On Admin pipeline page

* Edit pipeline group "group5"

* Delete user "shilpa" -on edit group page
* Delete role "viewer" -on edit group page
* Save Changes
* Verify the message "Saved successfully." is present



* Verify pipeline group "group5" does not have user "shilpa"
* Verify pipeline group "group5" does not have role "viewer"


Teardown of contexts
____________________
* Capture go state "EditPipelineGroups" - teardown
* Logout - from any page
