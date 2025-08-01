AgentsUIScreen
=========

AgentsUIScreen
-------------------
tags: agentspage, agentsUI, agents_spa, spa

Setup of contexts
* Basic Configuration - setup
* Using pipeline "basic-pipeline-with-long-running-job" - setup
* With "4" live agents - setup
* Capture go state "AgentsUIScreen" - setup

Resource Assignment

* Sort by "Sandbox"
* Select agent "1"
* Add resources "linux, java, ruby"
* Sort and verify agent "1" assigned resources "linux, java, ruby"
* Select agent "1"
* Remove resources "ruby"
* Sort and verify agent "1" assigned resources "linux, java"
* Select agent "2, 3"
* Set resources "linux, java"
* Sort and verify agent "2" assigned resources "linux, java"
* Verify agent "3" assigned resources "linux, java"
* Select agent "1, 2, 3"
* Remove resources "linux, java"
* Sort by "Sandbox"
* Select agent "1"
* Add resources "linux"
* Sort and verify agent "1" assigned resources "linux"
* Select agent "2"
* Add resources "java"
* Sort and verify agent "2" assigned resources "java"
* Select agent "3"
* Add resources "ruby"
* Sort and verify agent "3" assigned resources "ruby"

Sort by Resources

* Sort by "Resources"
* Verify agents "Resources" has values in order as "none specified, java, linux, ruby"
* Sort by "Resources"
* Verify agents "Resources" has values in order as "ruby, linux, java, none specified"
* Reload page
* Verify agents "Resources" has values in order as "ruby, linux, java, none specified"


Environment assignment

* Sort by "Sandbox"
* Select agent "1"
* Set environments "uat, internal"
* Sort and verify agent "1" assigned environments "uat, internal"
* Select agent "1"
* Remove environments "internal"
* Sort and verify agent "1" assigned environments "uat"
* Select agent "2, 3"
* Set environments "prod, internal"
* Sort and verify agent "2" assigned environments "prod, internal"
* Verify agent "3" assigned environments "prod, internal"
* Verify agent "4" assigned environments "none specified"
* Select agent "2, 3"
* Remove environments "prod, internal"
* Sort and verify agent "2" assigned environments "none specified"
* Select agent "2"
* Set environments "internal"
* Sort and verify agent "2" assigned environments "internal"
* Select agent "3"
* Set environments "prod"
* Sort and verify agent "3" assigned environments "prod"

Sort by environments

* Sort by "Environments"
* Verify agents "Environments" has values in order as "none specified, internal, prod, uat"
* Sort by "Environments"
* Verify agents "Environments" has values in order as "uat, prod, internal, none specified"
* Reload page
* Verify agents "Environments" has values in order as "uat, prod, internal, none specified"

Disable agent

* Select agent "1"
* "Disable" agent
* Verify agent "1" status is "Disabled"

Sort by status

* Looking at pipeline "basic-pipeline-with-long-running-job" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* On Agents page
* Wait till agent "1" status is "Building"
* Sort by "Status"
* Verify agents "Status" has values in order as "Disabled, Idle, Idle, Building"
* Sort by "Status"
* Verify agents "Status" has values in order as "Building, Idle, Idle, Disabled"
* Wait till agent "1" status is "Idle"

Delete agent

* Select agent "4"
* "Enable" agent
* Verify agent "4" status is "Idle"
* Select agent "4"
* "Disable" agent
* Verify agent "4" status is "Disabled"
* Select agent "4"
* "Delete" agent
* Verify listed agents count is "3"


teardown
_______________
* With "4" live agents - teardown
* Capture go state "AgentsUIScreen" - teardown
