Copyright 2018 ThoughtWorks, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

PipelineDashboardAndActivitySecurityWithMultiplePermissions
===========================================================

Setup of contexts
* Permissions configuration - setup
* Login as "admin" - setup
* Using pipeline "P8, P9" - setup
* With "1" live agents - setup
* Capture go state "PipelineDashboardAndActivitySecurityWithMultiplePermissions" - setup

PipelineDashboardAndActivitySecurityWithMultiplePermissions
-----------------------------------------------------------

tags: 6786, Permissions

Verify that user 'group1view' gets union of the different permissions specified to him

* Looking at pipeline "P8" - On Swift Dashboard page
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page
* Looking at pipeline "P9" - On Swift Dashboard page 
* Trigger and wait for stage "defaultStage" is "Passed" with label "1" - On Swift Dashboard page

* Logout - from any page

* Login as "group1View"


Pipeline Visibility
* PipelineVisibility 
     |Pipeline Name|Visible?|Can Operate Using Ui?|Can Operate Using Api?|Can Pause Using Ui?|Can Pause Using Api?|
     |-------------|--------|---------------------|----------------------|-------------------|--------------------|
     |P8           |true    |true                 |true                  |true               |true                |
     |P9           |true    |true                 |true                  |true               |true                |

* verify user has operate permissions on "defaultStage" for pipeline "P8" on Pipeline Activity Page

* verify user has operate permissions on "defaultStage" for pipeline "P9" on Pipeline Activity Page

* verify user can operate stage "defaultStage" for pipeline "P8" from stage details page

* verify user can operate stage "defaultStage" for pipeline "P9" from stage details page

Teardown of contexts
____________________
* Capture go state "PipelineDashboardAndActivitySecurityWithMultiplePermissions" - teardown
* With "1" live agents - teardown


