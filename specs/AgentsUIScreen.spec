AgentsUIScreen
=========

AgentsUIScreen
-------------------
tags: agentspage, agentsUI

Setup of contexts
* Basic Configuration - setup
* Using pipeline "basic-pipeline-with-long-running-job" - setup
* With "4" live agents - setup
 Capture go state "AgentsUIScreen" - setup

Resource Assignment

* Select agent "1"
* Add resources "linux, java, ruby"
* Verify agent "1" assigned resources "linux, java, ruby"
* Select agent "1"
* Remove resources "ruby"
* Verify agent "1" assigned resources "linux, java"
* Select agent "2, 3"
* Set resources "linux, java"
* Verify message "Resources modified on 2 agents"
* Verify agent "2" assigned resources "linux, java"
* Verify agent "3" assigned resources "linux, java"
* Verify agent "4" assigned resources "none specified"
* Select agent "1, 2, 3"
* Remove resources "linux, java"
* Verify agent "1" assigned resources "none specified"
* Select agent "1"
* Add resources "linux"
* Verify agent "1" assigned resources "linux"
* Select agent "2"
* Add resources "java"
* Verify agent "2" assigned resources "java"
* Select agent "3"
* Add resources "ruby"
* Verify agent "3" assigned resources "ruby"

Sort by Resources

* Sort by "Resources"
* Verify agents "Resources" has values in order as "none specified, java, linux, ruby"
* Sort by "Resources"
* Verify agents "Resources" has values in order as "ruby, linux, java, none specified"
* Reload page
* Verify agents "Resources" has values in order as "ruby, linux, java, none specified"


Environment assignment

* Select agent "1"
* Set environments "uat, internal"
* Verify agent "1" assigned environments "uat, internal"
* Select agent "1"
* Remove environments "internal"
* Verify agent "1" assigned environments "uat"
* Select agent "2, 3"
* Set environments "prod, internal"
* Verify message "Environments modified on 2 agents"
* Verify agent "2" assigned environments "prod, internal"
* Verify agent "3" assigned environments "prod, internal"
* Verify agent "4" assigned environments "none specified"
* Select agent "2, 3"
* Remove environments "prod, internal"
* Verify agent "2" assigned environments "none specified"
* Select agent "2"
* Set environments "internal"
* Verify agent "2" assigned environments "internal"
* Select agent "3"
* Set environments "prod"
* Verify agent "3" assigned environments "prod"

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

* Looking at pipeline "basic-pipeline-with-long-running-job"
* Trigger "basic-pipeline-with-long-running-job"
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
Capture go state "AgentsUIScreen" - teardown
* With "4" live agents - teardown
