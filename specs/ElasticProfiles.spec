ElasticProfiles
===============

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline with specific material "pipeline-with-elastic-agent-profile-1, pipeline-with-elastic-agent-profile-2" - setup
* Capture go state "ElasticProfiles" - setup

ElasticProfiles
---------------

tags: elastic_agent_profile

* On Elastic profiles page
* Add new cluster profile
* Set cluster profile name as "Cluster-1"
* Set plugin id as "Docker Elastic Agent Plugin"
* Set GoServer URL as "http://$server_ip$:8253/go" for cluster profile
* Set auto register timeout as "1" for cluster profile
* Set max docker containers as "1"
* Set environment variable as "CLUSTER_NAME=Cluster-1"

* Set docker URI as "unix:///var/run/docker.sock" for cluster profile

* Save cluster profile

* Add new Elastic agent profile for cluster id "Cluster-1"

* Go back to Cluster Profiles step on the wizard
* Check cluster id is selected as "Cluster-1" with plugin "Docker Elastic Agent Plugin"
* Go forward to Elastic Profiles step on the wizard
* Set agent profile name as "Profile-Using-Cluster-1"
* Set docker image as "rajiesh/gocd-agent-centos-7-test:v19.2.0"
* Save the elastic agent profile

* Expand cluster profile "Cluster-1"
* Verify elastic agent profiles "Profile-Using-Cluster-1" listed

* Update pipeline "pipeline-with-elastic-agent-profile-1" stage "defaultStage" job "defaultJob" with elastic profile id "Profile-Using-Cluster-1" - Using pipeline config API

* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-elastic-agent-profile-1" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page

* On Agents page
* Wait till "120" seconds to verify listed elastic agents count is "1"

* On Swift Dashboard Page
* Wait for "150" seconds till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" - On Swift Dashboard page

* On Job details page of pipeline "pipeline-with-elastic-agent-profile-1" counter "1" stage "defaultStage" counter "1" job "defaultJob"
* Verify console log contains message "CLUSTER_NAME=Cluster-1"

* On Elastic profiles page
* Edit cluster profile "Cluster-1"
* Set max docker containers as "2"
* Save cluster profile

* Verify "max_docker_containers" for "Cluster-1" as "2" - Using cluster profile API

* Delete cluster profile "Cluster-1" should fail with error "Validations failed for clusterProfile 'Cluster-1'. Error(s): [Cannot delete cluster profile 'Cluster-1' as it is referenced from elastic agent profile(s) [Profile-Using-Cluster-1]]. Please correct and resubmit."

* Clone cluster profile "Cluster-1" by name "Cloned-Cluster"

* Clusters "Cluster-1, Cloned-Cluster" should be listed on the SPA

* On Elastic profiles page
* Add new cluster profile
* Set cluster profile name as "Cluster-2"
* Set GoServer URL as "http://$server_ip$:8253/go" for cluster profile
* Set auto register timeout as "10" for cluster profile
* Set max docker containers as "1"
* Set environment variable as "CLUSTER_NAME=Cluster-2"

* Set docker URI as "unix:///var/run/docker.sock" for cluster profile

* Save cluster profile

* Add new Elastic agent profile for cluster id "Cluster-2"

* Go back to Cluster Profiles step on the wizard
* Check cluster id is selected as "Cluster-2" with plugin "Docker Elastic Agent Plugin"
* Go forward to Elastic Profiles step on the wizard
* Set agent profile name as "Profile-Using-Cluster-2"
* Set docker image as "rajiesh/gocd-agent-centos-7-test:v19.2.0"
* Save the elastic agent profile

* Expand cluster profile "Cluster-2"
* Verify elastic agent profiles "Profile-Using-Cluster-2" listed

* Update pipeline "pipeline-with-elastic-agent-profile-2" stage "defaultStage" job "defaultJob" with elastic profile id "Profile-Using-Cluster-2" - Using pipeline config API

* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-elastic-agent-profile-2" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page

* Wait for "180" seconds till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" - On Swift Dashboard page

* On Job details page of pipeline "pipeline-with-elastic-agent-profile-2" counter "1" stage "defaultStage" counter "1" job "defaultJob"
* Verify console log contains message "CLUSTER_NAME=Cluster-2"


Teardown of contexts
____________________
* As user "admin" for teardown
* Logout - from any page
* Capture go state "ElasticProfiles" - teardown
