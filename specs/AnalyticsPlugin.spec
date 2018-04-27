AnalyticsPlugin
==============

AnalyticsPlugin
--------------

tags: analytics

Setup of contexts

* Secure Configuration - setup
* Configure analytics plugin
* Login as "admin" - setup

pipeline "P1" should be assigned resource "R1" and "P2" should be assigned "R2"
* Using pipeline "P1, P2" - setup

* With "2" live agents - setup
* Capture go state "AnalyticsPlugin" - setup

* Select agent "1"
* Set resources "R1"

* Select agent "2"
* Set resources "R2"

* Looking at pipeline "P1" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Create a "stopjob" file and validate pipeline completed

* Looking at pipeline "P2" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Create a "stopjob" file and validate pipeline completed

* Looking at pipeline "P1" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Create a "failjob" file and validate pipeline completed

* Wait for "10" seconds

* Looking at pipeline "P1" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Create a "stopjob" file and validate pipeline completed

* On Agents page
* Select agent "2"
* "Disable" agent

* Looking at pipeline "P2" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page

* Wait for "20" seconds

* On Agents page
* Select agent "2"
* "enable" agent

* On Swift Dashboard Page
* Create a "stopjob" file and validate pipeline completed

* Looking at pipeline "P1" - On Swift Dashboard page
* Open pipeline build analytics
* Verify pipeline build time graph is displayed
* Verify the MTTR value is calculated

 Verify can navigate to stage details page from analytics

* Close pipeline build analytics

* Navigate to global analytics page
* Verify pipeline "P2" is shown on top of pipelines waiting longest for agents

Steps for Drill down and navigating to stage details page are not implemented as of now. 
Will have to see how and where to automate those steps, is functional test the right place or can it be done somewhere else?

 Drill down to job waiting and job duration graphs

 Verify agent with resource "R2" is the highest utilized agent
 Drill down to job which waited longest for the agent

* Visit pipeline tab - On Global analytics page
* Verify pipelines "P1, P2" are listed
* Selecting pipeline "P1" should show pipeline build analytics

* Logout and login as "view"
* Analytics menu should not be visible

* Looking at pipeline "P1" - On Swift Dashboard page
* Open pipeline build analytics
* Verify pipeline build time graph is displayed

* Logout and login as "group1Admin" 
* Analytics menu should not be visible
* Looking at pipeline "P1" - On Swift Dashboard page
* Open pipeline build analytics
* Verify pipeline build time graph is displayed



Teardown of contexts
____________________
* Capture go state "AnalyticsPlugin" - teardown
* With "2" live agents - teardown

