DockerPluginElasticAgentsProfile
============================

Setup of contexts
* Basic Configuration - setup
* Capture go state "AccessTokenCreateUseRevoke" - setup

DockerPluginElasticAgentsProfile
----------------------------

tags: elastic_agent_profile

This scenario needs to be extended to use the multi cluster support when its ready

* On Elastic agent profiles page

* Add new profile for plugin "GoCD Docker Swarm Elastic Agents"
* Set profile name as "profile_name"
* Set image as "image_name:v1.0"
* Save the elastic agent profile

* Verify profile "profile_name" listed

* Edit elastic agent profile "profile_name"
* Update image as "image-image:v2.0"
* Save the elastic agent profile

* Verify elastic profile "profile_name" has key "Image" value "image-image:v2.0" - Using elastic agent profiles API



Teardown of contexts
____________________
* Capture go state "AccessTokenCreateUseRevoke" - teardown
