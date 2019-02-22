AccessTokenAPIUsingFilebasedAuth
============================

Setup of contexts
* Access Token Configuration - setup
* Login as "admin" - setup
* Using pipeline "basic-pipeline-fast" - setup
* Capture go state "AccessTokenAPI" - setup

AccessTokenAPIUsingFilebasedAuth
----------------------------

tags: access_tokens

* CreateAccessTokens
     |user         |description|
     |-------------|-----------|
     |admin        |true       |
     |groupadmin        |true  |
     |view        |true  |
     |Operate        |true  |


* Get all access token as "admin" should show "4" tokens

* Get all access token as "groupadmin" should return response code "401"
* Get all access token as "view" should return response code "401"
* Get all access token as "operate" should return response code "401"

* GetAccessTokens
     |user         |description|
     |-------------|-----------|
     |admin        |true       |
     |groupadmin        |true  |
     |view        |true  |
     |Operate        |true  |



Teardown of contexts
____________________
* As user "admin" for teardown
* Logout - from any page
* Capture go state "AccessTokenAPI" - teardown
