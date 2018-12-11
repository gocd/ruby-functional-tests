PipelineGroupAdminsExtractTemplatePermission
============================================

Setup of contexts
* Group admin security configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline-with-group-and-stage-security" - setup
* Capture go state "PipelineGroupAdminExtractTemplatePermission" - setup

PipelineGroupAdminsExtractTemplatePermission
--------------------------------------------

tags: group_admin

Group admins should also have permission to extract templates
* On Admin page
* Verify that extract template is enabled for "pipeline-with-group-and-stage-security"

* Logout - from any page

* Login as "pavan"

* On Admin page
* Verify that extract template is enabled for "pipeline-with-group-and-stage-security"


Teardown of contexts
____________________
* Capture go state "PipelineGroupAdminExtractTemplatePermission" - teardown
* Logout - from any page


