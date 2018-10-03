VSMAnalytics
==============

tags: VSM_analytics

Setup of contexts

* Secure Configuration - setup
* Configure analytics plugin
* Login as "admin" - setup
 Configure analytics plugin
* Using pipeline "VSM1,VSM2,VSM3,VSM4" - setup
* With "2" live agents - setup
* Capture go state "AnalyticsPlugin" - setup

VSMAnalytics
------------------------------------

* Looking at pipeline "VSM1" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" - On Swift Dashboard page

* Looking at pipeline "VSM2" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" - On Swift Dashboard page

* Looking at pipeline "VSM3" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" - On Swift Dashboard page

* Looking at pipeline "VSM4" - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" - On Swift Dashboard page


VSM Analytics Verifications -pipeline to pipeline for initial commit

* Looking at pipeline "VSM1" - On Swift Dashboard page
* Visit pipeline VSM page and verify VSM is rendered
* Start VSM analytics selections
* Select pipeline "VSM4" for VSM analytics
* View VSM analytics
* Verify VSM trend has "1" workflows

* Logout and login as "view"
* On Swift Dashboard Page
* Looking at pipeline "VSM1" - On Swift Dashboard page
* Visit pipeline VSM page and verify VSM is rendered
* Start VSM analytics selections
* Select pipeline "VSM4" for VSM analytics
* View VSM analytics
* Verify VSM trend has "1" workflows

* Logout and login as "operatorUser"
* On Swift Dashboard Page
* Looking at pipeline "VSM1" - On Swift Dashboard page
* Visit pipeline VSM page and verify VSM is rendered
* Start VSM analytics selections
* Select pipeline "VSM4" for VSM analytics
* View VSM analytics
* Verify VSM trend has "1" workflows

* Logout and login as "group1admin"
* On Swift Dashboard Page
* Looking at pipeline "VSM1" - On Swift Dashboard page
* Visit pipeline VSM page and verify VSM is rendered
* Start VSM analytics selections
* Select pipeline "VSM4" for VSM analytics
* View VSM analytics
* Verify VSM trend has "1" workflows

* Logout and login as "templateadmin"
* On Swift Dashboard Page
* Looking at pipeline "VSM1" - On Swift Dashboard page
* Visit pipeline VSM page and verify VSM is rendered
* Start VSM analytics selections
* Select pipeline "VSM4" for VSM analytics
* View VSM analytics
* Verify VSM trend has "1" workflows




Teardown of contexts
____________________
* As user "admin" for teardown
* Capture go state "AnalyticsPlugin" - teardown
* With "2" live agents - teardown


