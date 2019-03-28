PipelineUsingElasticAgent
============================

Setup of contexts
* Secure Configuration - setup
* Login as "admin" - setup
* Using pipeline with specific material "pipeline-with-elastic-agent-profile" - setup
* Capture go state "PipelineUsingElasticAgent" - setup

PipelineUsingElasticAgent
----------------------------

tags: elastic_agent

* On Plugins page
* Open "Docker Elastic Agent Plugin" plugins settings page
* Set GoServer URL as "https://$server_ip$:8254/go"
* Set auto register timeout as "5"
* Set max containers as "2"

* Set docker URI as "unix:///var/run/docker.sock"

* Save plugin settings

* On Elastic agent profiles page

* Add new profile for plugin "Docker Elastic Agent Plugin"
* Set profile name as "docker_ea"
* Set image as "rajiesh/gocd-agent-centos-7-test:v19.2.0"
* Save the elastic agent profile

* Verify profile "docker_ea" listed

* Update pipeline "pipeline-with-elastic-agent-profile" stage "defaultStage" job "defaultJob" with elastic profile id "docker_ea" - Using pipeline config API

* On Swift Dashboard Page
* Looking at pipeline "pipeline-with-elastic-agent-profile" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page

* Wait for "180" seconds till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" - On Swift Dashboard page


Teardown of contexts
____________________
* As user "admin" for teardown
* Logout - from any page
* Capture go state "PipelineUsingElasticAgent" - teardown
