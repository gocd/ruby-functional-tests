
PipelineApiSecurity
===================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "basic-pipeline-fast-api, viewable-pipeline, admin-pipeline-api" - setup
* With "1" live agents - setup
* Capture go state "PipelineApiSecurity" - setup

PipelineApiSecurity
-------------------

tags: API Security

* Enable auto update for pipeline "basic-pipeline-fast-api"
* Enable auto update for pipeline "viewable-pipeline"
* Enable auto update for pipeline "admin-pipeline-api"

* As user "admin"
* On Swift Dashboard Page
* Looking at pipeline "basic-pipeline-fast-api" - On Swift Dashboard page
* Schedule should return code "202"
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* Schedule should return code "202"
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Looking at pipeline "admin-pipeline-api" - On Swift Dashboard page
* Schedule should return code "202"
* Wait till stage "defaultStage" completed - On Swift Dashboard page


* Looking at pipeline "basic-pipeline-fast-api" - On Swift Dashboard page
* With material "git" of type "git" for pipeline "basic-pipeline-fast-api"
* Checkin file "file1" as user "user" with message "commiting file1" - On Swift Dashboard page
* Checkin file "file2" as user "user2" with message "commiting file2" - On Swift Dashboard page

* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* With material "git" of type "git" for pipeline "viewable-pipeline"
* Checkin file "file1" as user "user" with message "commiting file1" - On Swift Dashboard page
* Checkin file "file2" as user "user2" with message "commiting file2" - On Swift Dashboard page

* Looking at pipeline "admin-pipeline-api" - On Swift Dashboard page
* With material "git" of type "git" for pipeline "admin-pipeline-api"
* Checkin file "file1" as user "user" with message "commiting file1" - On Swift Dashboard page
* Checkin file "file2" as user "user2" with message "commiting file2" - On Swift Dashboard page




* Looking at pipeline "basic-pipeline-fast-api" - On Swift Dashboard page
* Using "2nd" revision of "git" of type "git" for pipeline "basic-pipeline-fast-api"
* Schedule should return code "202"
* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* Using "2nd" revision of "git" of type "git" for pipeline "viewable-pipeline"
* Schedule should return code "202"
* Looking at pipeline "admin-pipeline-api" - On Swift Dashboard page
* Using "2nd" revision of "git" of type "git" for pipeline "admin-pipeline-api"

* Schedule should return code "202"

* Looking at pipeline "basic-pipeline-fast-api" - On Swift Dashboard page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* On Job details page of pipeline "basic-pipeline-fast-api" counter "2" stage "defaultStage" counter "1" job "defaultJob"



* Verify console shows "2nd" commit for material "git" for "basic-pipeline-fast-api"

* On Swift Dashboard Page
* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* On Job details page of pipeline "viewable-pipeline" counter "2" stage "defaultStage" counter "1" job "defaultJob"


* Verify console shows "2nd" commit for material "git" for "viewable-pipeline"

* On Swift Dashboard Page
* Looking at pipeline "admin-pipeline-api" - On Swift Dashboard page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* On Job details page of pipeline "admin-pipeline-api" counter "2" stage "defaultStage" counter "1" job "defaultJob"

* Verify console shows "2nd" commit for material "git" for "admin-pipeline-api"

* As user "view"

* On Swift Dashboard Page
* Looking at pipeline "basic-pipeline-fast-api" - On Swift Dashboard page
* Schedule should return code "202"
* Wait till stage "defaultStage" completed - On Swift Dashboard page

* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* Schedule should return code "403"

* Looking at pipeline "admin-pipeline-api" - On Swift Dashboard page
* Schedule should return code "403"

* On Swift Dashboard Page
* Looking at pipeline "basic-pipeline-fast-api" - On Swift Dashboard page
* Schedule should return code "202"
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* Schedule should return code "403"
* Looking at pipeline "admin-pipeline-api" - On Swift Dashboard page
* Schedule should return code "403"

* On Swift Dashboard Page
* Looking at pipeline "basic-pipeline-fast-api" - On Swift Dashboard page

* On Job details page of pipeline "basic-pipeline-fast-api" counter "4" stage "defaultStage" counter "1" job "defaultJob"

* Verify console shows "0th" commit for material "git" for "basic-pipeline-fast-api"

* As user "operate"


* On Swift Dashboard Page
* Looking at pipeline "basic-pipeline-fast-api" - On Swift Dashboard page
* Schedule should return code "202"
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* Schedule should return code "202"
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Looking at pipeline "admin-pipeline-api" - On Swift Dashboard page
* Schedule should return code "403"




* Looking at pipeline "basic-pipeline-fast-api" - On Swift Dashboard page
* Using "2nd" revision of "git" of type "git" for pipeline "basic-pipeline-fast-api"
* Schedule should return code "202"
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* Using "2nd" revision of "git" of type "git" for pipeline "viewable-pipeline"
* Schedule should return code "202"
* Looking at pipeline "admin-pipeline-api" - On Swift Dashboard page
* Using "2nd" revision of "git" of type "git" for pipeline "admin-pipeline-api"
* Schedule should return code "403"
* On Job details page of pipeline "basic-pipeline-fast-api" counter "6" stage "defaultStage" counter "1" job "defaultJob"

* Verify console shows "2nd" commit for material "git" for "basic-pipeline-fast-api"

* On Job details page of pipeline "viewable-pipeline" counter "4" stage "defaultStage" counter "1" job "defaultJob"
* Verify console shows "2nd" commit for material "git" for "viewable-pipeline"





Teardown of contexts
____________________
* Capture go state "PipelineApiSecurity" - teardown
* With "1" live agents - teardown
* Logout - from any page
