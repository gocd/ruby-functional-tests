EncryptAPI
=========

EncryptAPI
-------------------
tags: Encrypt, api

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Capture go state "EncryptAPI" - setup

* As user "admin"
* Encrypt value "badger" and store encrypted value as "encryptedFirst"
* Encrypt value "badger" and store encrypted value as "encryptedSecond"
* Verify encrypted values "encryptedFirst" and "encryptedSecond" are not same

* As user "group1Admin"
* Encrypt value "=qh^Gl3tcN&?gF;a^Dc," and store encrypted value as "encryptedFirst"
* Encrypt value "=qh^Gl3tcN&?gF;a^Dc," and store encrypted value as "encryptedSecond"
* Verify encrypted values "encryptedFirst" and "encryptedSecond" are not same

* As user "templateadmin"
* Encrypt value "{H#Pbr6jUoDb+7*+N^Wc" and store encrypted value as "encryptedFirst"
* Encrypt value "{H#Pbr6jUoDb+7*+N^Wc" and store encrypted value as "encryptedSecond"
* Verify encrypted values "encryptedFirst" and "encryptedSecond" are not same

* As user "view"
* Encrypt value "{H#Pbr6jUoDb+7*+N^Wc"
* Verify returned "403" response code


teardown
_______________
* As user "admin" for teardown
* Capture go state "EncryptAPI" - teardown
* Logout - from any page
