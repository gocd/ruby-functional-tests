VSMAnalytics
==============

tags: vsm_analytics

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




VSM Analytics Verifications - Material to pipeline for initial commit

* Looking at pipeline "VSM4" - On Swift Dashboard page
* Visit pipeline VSM page and verify VSM is rendered
* Start VSM analytics selections
* Select material "git-on-git-pipeline_VSM1" for VSM analytics
* View VSM analytics
* Verify VSM trend has "1" workflows

* Looking at pipeline "VSM4" - On Swift Dashboard page
* Visit pipeline VSM page and verify VSM is rendered
* Start VSM analytics selections
* Select material "git-on-git-pipeline_VSM3" for VSM analytics
* View VSM analytics
* Verify VSM trend has "2" workflows

VSM Analytics Verifications - pipeline to pipeline for multiple commits

* Looking at pipeline "VSM1" - On Swift Dashboard page
* With material "git" of type "git" for pipeline "VSM1"
* Checkin file "file_1" as user "go" with message "Added git-file_1" - On Swift Dashboard page
* Remember current version as "git1"
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

* Looking at pipeline "VSM1" - On Swift Dashboard page
* With material "git" of type "git" for pipeline "VSM1"
* Checkin file "file_2" as user "go" with message "Added git-file_2" - On Swift Dashboard page
* Remember current version as "git2"
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

* Looking at pipeline "VSM1" - On Swift Dashboard page
* Visit pipeline VSM page and verify VSM is rendered
* Start VSM analytics selections
* Select pipeline "VSM4" for VSM analytics
* View VSM analytics
* Verify VSM trend has "3" workflows

Verification- force Trigger of VSM1

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


* Looking at pipeline "VSM1" - On Swift Dashboard page
* Visit pipeline VSM page and verify VSM is rendered
* Start VSM analytics selections
* Select pipeline "VSM4" for VSM analytics
* View VSM analytics
* Verify VSM trend has "4" workflows

* Looking at pipeline "VSM3" - On Swift Dashboard page
* Visit pipeline VSM page and verify VSM is rendered
* Start VSM analytics selections
* Select pipeline "VSM4" for VSM analytics
* View VSM analytics
* Verify VSM trend has "5" workflows

Teardown of contexts
____________________
* As user "admin" for teardown
* Capture go state "AnalyticsPlugin" - teardown
* With "2" live agents - teardown
