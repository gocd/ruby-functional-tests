AgentsFilter
=========

AgentsFilter
-------------------
tags: agentsfilter, agentsUI, agents_spa, spa
This spec is removed from regression on "Regression-SPA" pipeline as these validations are taken care of by the jasmine specs

Setup of contexts
* Multiple agents Configuration - setup
* With "1" live agents - setup
* Capture go state "AgentsFilter" - setup

Hostnames as search string
 * Enter filter value "random"
 * Verify agents "random, random1, random2, random3, random4" show up in results
 * Enter filter value "random1"
 * Verify agents "random1" show up in results
 * Enter filter value "random "
 * Verify agent summary shows "Total" agent count as "0"

 IP as search string
 * Enter filter value "10.232.3"
 * Verify agents "random1, random2, random3" show up in results
 * Enter filter value "10.232.3.1"
 * Verify agents "random1" show up in results


 Environment as search string
 * Enter filter value "Prod"
 * Verify agents "random, random1, random3, random4" show up in results
 * Enter filter value "Production"
 * Verify agents "random4" show up in results
 * Enter filter value "Prod-n"
 * Verify agent summary shows "Total" agent count as "1"
 * Enter filter value "Prod-new"
 * Verify agents "random" show up in results


 Status as search string
 * Enter filter value "miss"
 * Verify agents "random, random1, random2, random3, random4" show up in results
 * Enter filter value "missing"
 * Verify agents "random, random1, random2, random3, random4" show up in results
 * Enter filter value "idle"
 * Verify agent summary shows "Total" agent count as "1"
 * Enter filter value "idle "
 * Verify agent summary shows "Total" agent count as "0"

 Resource as search string
 * Enter filter value "win"
 * Verify agents "random1, random2" show up in results
 * Enter filter value "windows"
 * Verify agents "random1, random2" show up in results
 * Enter filter value "lin"
 * Verify agent summary shows "Total" agent count as "4"
 * Enter filter value "linux"
 * Verify agents "random, random3, random4" show up in results


 OS as search string
 * Enter filter value "CentOS"
 * Verify agent summary shows "Total" agent count as "2"

teardown
_______________
* Capture go state "AgentsFilter" - teardown
* With "1" live agents - teardown
