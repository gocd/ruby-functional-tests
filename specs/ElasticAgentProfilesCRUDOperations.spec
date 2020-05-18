ElasticAgentsProfileCRUDOperations
============================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Capture go state "ElasticAgentsProfileCRUDOperations" - setup

ElasticAgentsProfileCRUDOperations
----------------------------

tags: elastic_agent_profile

Note: This spec will use 2 elastic agent(Docker and K8s plguins) plugins and setup multiple elastic agents for them

* Create cluster profile "Docker-Cluster" for docker elastic agent plugin - Using Cluster profile API
* Create cluster profile "K8s-Cluster" for kubernetes elastic agent plugin - Using Cluster profile API

* On Elastic profiles page
* Add new Elastic agent profile for cluster id "Docker-Cluster"

* Go back to Cluster Profiles step on the wizard
* Check cluster id is selected as "Docker-Cluster" with plugin "Docker Elastic Agent Plugin"
* Go forward to Elastic Profiles step on the wizard
* Set agent profile name as "Profile-Using-Docker-Cluster"
* Set docker image as "gocd/gocd-agent-centos-7:v20.1.0"
* Save elastic agent profile

* Clone Elastic agent profile "Profile-Using-Docker-Cluster" of cluster "Docker-Cluster" by name "Cloned-Docker"

* Expand cluster profile "Docker-Cluster"
* Verify elastic agent profiles "Profile-Using-Docker-Cluster, Cloned-Docker" listed

* On Elastic profiles page
* Add new Elastic agent profile for cluster id "K8s-Cluster"

* Set agent profile name as "Profile-Using-K8s-Cluster"
* Select Configuration properties for kubernetes cluster
* Go back to Cluster Profiles step on the wizard
* Check cluster id is selected as "K8s-Cluster" with plugin "Kubernetes Elastic Agent Plugin"
* Go forward to Elastic Profiles step on the wizard
* Set docker image as "gocd/gocd-agent-centos-7:v20.1.0"
* Set maximum memory limit as "50M"
* Save elastic agent profile

* Expand cluster profile "K8s-Cluster"
* Verify elastic agent profiles "Profile-Using-K8s-Cluster" listed

* Edit elastic agent profile "Profile-Using-K8s-Cluster" of cluster profile "K8s-Cluster"
* Set maximum memory limit as "100"
* Elastic agent profile save should fail with message "Invalid size: 100"
* Set maximum memory limit as "100M"
* Save elastic agent profile

* Verify "MaxMemory" is "100M" for elastic agent profile "Profile-Using-K8s-Cluster" - Using elastic agent profile API

* Delete elastic agent profile "Profile-Using-Docker-Cluster" of cluster "Docker-Cluster"
* Expand cluster profile "Docker-Cluster"
* Verify elastic agent profiles "Cloned-Docker" listed

* Verify "2" elastic agent profiles "Cloned-Docker, Profile-Using-K8s-Cluster" are only returned  - Using get all elastic agent profile API


Teardown of contexts
____________________
* As user "admin" for teardown
* Logout - from any page
* Capture go state "ElasticAgentsProfileCRUDOperations" - teardown
