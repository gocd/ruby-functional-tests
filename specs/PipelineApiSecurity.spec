
PipelineApiSecurity
===================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline "basic-pipeline-fast, viewable-pipeline, admin-pipeline" - setup
* With "1" live agents - setup
* Capture go state "PipelineApiSecurity" - setup

PipelineApiSecurity
-------------------

tags: API Security

* Enable auto update for pipeline "basic-pipeline-fast"
* Enable auto update for pipeline "viewable-pipeline"
* Enable auto update for pipeline "admin-pipeline"

* As user "admin"
* On Swift Dashboard Page
* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Schedule should return code "202"
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* Schedule should return code "202"
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* Schedule should return code "202"
* Wait till stage "defaultStage" completed - On Swift Dashboard page


* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* With material "basic-pipeline-hg" of type "git" for pipeline "basic-pipeline-fast"
* Checkin file "file1" as user "user" with message "commiting file1" - On Swift Dashboard page
* Checkin file "file2" as user "user2" with message "commiting file2" - On Swift Dashboard page

* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* With material "viewable-pipeline-hg" of type "git" for pipeline "viewable-pipeline"
* Checkin file "file1" as user "user" with message "commiting file1" - On Swift Dashboard page
* Checkin file "file2" as user "user2" with message "commiting file2" - On Swift Dashboard page

* Looking at pipeline "admin-pipeline" - On Swift Dashboard page
* With material "admin-pipeline-hg" of type "git" for pipeline "admin-pipeline"
* Checkin file "file1" as user "user" with message "commiting file1" - On Swift Dashboard page
* Checkin file "file2" as user "user2" with message "commiting file2" - On Swift Dashboard page




* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Using "2nd" last revision of "basic-pipeline-hg"
* Schedule should return code "202"
* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* Using "2nd" last revision of "viewable-pipeline-hg"
* Schedule should return code "202"
* Looking at pipeline "admin-pipeline" - On Swift Dashboard page
* Using "2nd" last revision of "admin-pipeline-hg"
* Schedule should return code "202"

* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* On Job details page of pipeline "basic-pipeline-fast" counter "2" stage "defaultStage" counter "1" job "defaultJob"



* Verify console shows "2nd" commit for material "basic-pipeline-hg" for "basic-pipeline-fast"

* On Swift Dashboard Page
* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* On Job details page of pipeline "viewable-pipeline" counter "2" stage "secondStage" counter "1" job "defaultJob"


* Verify console shows "2nd" commit for material "viewable-pipeline-hg" for "viewable-pipeline"

* On Swift Dashboard Page
* Looking at pipeline "admin-pipeline" - On Swift Dashboard page
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* On Job details page of pipeline "admin-pipeline" counter "2" stage "secondStage" counter "1" job "defaultJob"

* Verify console shows "2nd" commit for material "admin-pipeline-hg" for "admin-pipeline"

* As user "view"

* On Swift Dashboard Page
* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Schedule should return code "202"
* Wait till stage "defaultStage" completed - On Swift Dashboard page

* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* Schedule should return code "403"

* Looking at pipeline "admin-pipeline" - On Swift Dashboard page
* Schedule should return code "403"






* On Swift Dashboard Page
* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Schedule should return code "202"
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* Schedule should return code "403"
* Looking at pipeline "admin-pipeline" - On Swift Dashboard page
* Schedule should return code "403"


* On Job details page of pipeline "basic-pipeline-fast" counter "4" stage "defaultStage" counter "1" job "defaultJob"

* Verify console shows "2nd" commit for material "basic-pipeline-hg" for "basic-pipeline-fast"

* As user "operate"


* On Swift Dashboard Page
* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Schedule should return code "202"
* Wait till stage "defaultStage" completed - On Swift Dashboard page

* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* Schedule should return code "2012"
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Looking at pipeline "admin-pipeline" - On Swift Dashboard page
* Schedule should return code "403"




* Looking at pipeline "basic-pipeline-fast" - On Swift Dashboard page
* Using "2nd" last revision of "basic-pipeline-hg"
* Schedule should return code "202"
* Wait till stage "defaultStage" completed - On Swift Dashboard page
* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* Using "2nd" last revision of "viewable-pipeline-hg"
* Schedule should return code "202"
* Looking at pipeline "admin-pipeline" - On Swift Dashboard page
* Using "2nd" last revision of "admin-pipeline-hg"
* Schedule should return code "403"

* On Swift Dashboard Page
* Looking at pipeline "viewable-pipeline" - On Swift Dashboard page
* On Job details page of pipeline "basic-pipeline-fast" counter "5" stage "defaultStage" counter "1" job "defaultJob"

* Verify console shows "2nd" commit for material "basic-pipeline-hg" for "basic-pipeline-fast"

* On Job details page of pipeline "basic-pipeline-fast" counter "5" stage "defaultStage" counter "1" job "defaultJob"
* Verify console shows "2nd" commit for material "viewable-pipeline-hg" for "viewable-pipeline"





Teardown of contexts
____________________
* Capture go state "PipelineApiSecurity" - teardown
* With "1" live agents - teardown
* Logout - from any page
