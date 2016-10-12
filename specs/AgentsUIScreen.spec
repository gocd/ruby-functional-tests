AgentsUIScreen
=========

AgentsUIScreen
-------------------
tags: agentspage

Setup of contexts
* Basic Configuration - setup
* Using pipeline "basic-pipeline-with-git-material" - setup
* With "4" live agents - setup
* Capture go state "AgentsUIScreen" - setup

Resource Assignment

* Select agent "1"
* Add resource "linux, java, ruby"
* Verify agent "1" assigned resources "linux, java, ruby"
* Select agent "1"
* Remove resource "ruby"
* Verify agent "1" assigned resources "linux, java"
* Select agent "2, 3"
* Set resource "linux, java"
* Verify agent "2" assigned resources "linux, java"
* Verify agent "3" assigned resources "linux, java"
* Verify agent "4" assigned resources "none specified"

teardown
_______________
* Capture go state "AgentsUIScreen" - teardown
* With "4" live agents - teardown
