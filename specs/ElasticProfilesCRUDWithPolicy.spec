ElasticProfilesCRUDWithPolicy
============================

Setup of contexts
* Secure Configuration - setup
* Auth Plugins Configuration - setup
* Capture go state "ElasticAgentsWithPolicy" - setup

ElasticProfilesCRUDWithPolicy
----------------------------

tags: elastic_agent_profile

* Login as "admin" - setup

* Go to roles page

* Create a new gocd role "elastic-agent-viewers"
* Add user "view" to the role
* Add permission
* Update permission with "Allow", action "View", type "Cluster Profile" and resource "*"
* Save role

* Create a new gocd role "team1"
* Add user "user1" to the role
* Add permission
* Update permission with "Allow", action "Administer", type "Cluster Profile" and resource "team1_*"
* Add permission
* Update permission with "Allow", action "Administer", type "Elastic Agent Profile" and resource "team1_*:team1_*"
* Add permission
* Update permission with "Allow", action "View", type "Elastic Agent Profile" and resource "team2_*:*"
* Save role

* Create a new gocd role "team2"
* Add user "user2" to the role
* Add permission
* Update permission with "Allow", action "Administer", type "Cluster Profile" and resource "team2_*"
* Add permission
* Update permission with "Allow", action "Administer", type "Elastic Agent Profile" and resource "team2_*:team2_*"
* Add permission
* Update permission with "Allow", action "View", type "Elastic Agent Profile" and resource "team1_*:*"
* Save role

* Logout - from any page


* Login as "user1" - setup

* On Elastic profiles page
* Add new cluster profile
* Set cluster profile name as "team2_UAT_cluster"
* Set plugin id as "Docker Elastic Agent Plugin"
* Set GoServer URL as "https://my.gocd:8254/go" for cluster profile
* Set auto register timeout as "1" for cluster profile
* Set max docker containers as "1"
* Set docker URI as "unix:///var/run/docker.sock" for cluster profile

* Save cluster profile
* Verify error message for create cluster profile "User 'user1' does not have permissions to administer 'team2_UAT_cluster' cluster_profile(s)."

* Set cluster profile name as "team1_UAT_cluster"
* Save cluster profile

* Add new Elastic agent profile for cluster id "team1_UAT_cluster"

* Go back to Cluster Profiles step on the wizard
* Check cluster id is selected as "team1_UAT_cluster" with plugin "Docker Elastic Agent Plugin"
* Go forward to Elastic Profiles step on the wizard
* Set agent profile name as "team1_UAT_test_profile"
* Set docker image as "gocd/gocd-agent-wolfi:v25.4.0"

* Save the elastic agent profile

* Verify permissions API shows "cluster_profile" "view" list has only "team1_UAT_cluster"
* Verify permissions API shows "cluster_profile" "administer" list has only "team1_UAT_cluster"

* Verify permissions API shows "elastic_agent_profile" "view" list has only "team1_UAT_test_profile"
* Verify permissions API shows "elastic_agent_profile" "administer" list has only "team1_UAT_test_profile"

* Logout - from any page

* Login as "user2" - setup

* On Elastic profiles page
* Add new cluster profile
* Set cluster profile name as "team2_UAT_cluster"
* Set plugin id as "Docker Elastic Agent Plugin"
* Set GoServer URL as "https://my.gocd:8254/go" for cluster profile
* Set auto register timeout as "1" for cluster profile
* Set max docker containers as "1"
* Set docker URI as "unix:///var/run/docker.sock" for cluster profile

* Save cluster profile

* Add new Elastic agent profile for cluster id "team2_UAT_cluster"

* Go back to Cluster Profiles step on the wizard
* Check cluster id is selected as "team2_UAT_cluster" with plugin "Docker Elastic Agent Plugin"
* Go forward to Elastic Profiles step on the wizard
* Set agent profile name as "team2_UAT_test_profile"
* Set docker image as "gocd/gocd-agent-wolfi:v25.4.0"

* Save the elastic agent profile

* On Elastic profiles page
* Expand cluster profile "team1_UAT_cluster"

* Verify cluster profile operation "edit" is "disabled" for cluster profile "team1_UAT_cluster"
* Verify cluster profile operation "clone" is "enabled" for cluster profile "team1_UAT_cluster"
* Verify cluster profile operation "delete" is "disabled" for cluster profile "team1_UAT_cluster"

* Verify elastic agent profiles "team1_UAT_test_profile" listed

* Verify elastic agent profile operation "edit" is "disabled" for "team1_UAT_test_profile" under cluster profile "team1_UAT_cluster"
* Verify elastic agent profile operation "delete" is "disabled" for "team1_UAT_test_profile" under cluster profile "team1_UAT_cluster"


* Verify elastic agent profile operation "clone" is "enabled" for "team1_UAT_test_profile" under cluster profile "team1_UAT_cluster"
* Verify elastic agent profile operation "show-usage" is "enabled" for "team1_UAT_test_profile" under cluster profile "team1_UAT_cluster"


* Logout - from any page

* Login as "view" - setup

* On Elastic profiles page
* Expand cluster profile "team1_UAT_cluster"

* Verify cluster profile operation "edit" is "disabled" for cluster profile "team1_UAT_cluster"
* Verify cluster profile operation "clone" is "enabled" for cluster profile "team1_UAT_cluster"
* Verify cluster profile operation "delete" is "disabled" for cluster profile "team1_UAT_cluster"


* As user "view"
* Verify permissions API shows "cluster_profile" "view" list has only "team1_UAT_cluster, team2_UAT_cluster"
* Verify permissions API shows "cluster_profile" "administer" list has only ""

* Verify elastic agent profiles "team1_UAT_test_profile" listed

* Verify elastic agent profile operation "edit" is "disabled" for "team1_UAT_test_profile" under cluster profile "team1_UAT_cluster"
* Verify elastic agent profile operation "delete" is "disabled" for "team1_UAT_test_profile" under cluster profile "team1_UAT_cluster"


* Verify elastic agent profile operation "clone" is "enabled" for "team1_UAT_test_profile" under cluster profile "team1_UAT_cluster"
* Verify elastic agent profile operation "show-usage" is "enabled" for "team1_UAT_test_profile" under cluster profile "team1_UAT_cluster"

* Expand cluster profile "team2_UAT_cluster"

* Verify cluster profile operation "edit" is "disabled" for cluster profile "team2_UAT_cluster"
* Verify cluster profile operation "clone" is "enabled" for cluster profile "team2_UAT_cluster"
* Verify cluster profile operation "delete" is "disabled" for cluster profile "team2_UAT_cluster"

* Verify elastic agent profiles "team2_UAT_test_profile" listed

* Verify elastic agent profile operation "edit" is "disabled" for "team2_UAT_test_profile" under cluster profile "team2_UAT_cluster"
* Verify elastic agent profile operation "delete" is "disabled" for "team2_UAT_test_profile" under cluster profile "team2_UAT_cluster"


* Verify elastic agent profile operation "clone" is "enabled" for "team2_UAT_test_profile" under cluster profile "team2_UAT_cluster"
* Verify elastic agent profile operation "show-usage" is "enabled" for "team2_UAT_test_profile" under cluster profile "team2_UAT_cluster"

* As user "admin"

* Verify permissions API shows "cluster_profile" "view" list has only "team1_UAT_cluster, team2_UAT_cluster"
* Verify permissions API shows "cluster_profile" "administer" list has only "team1_UAT_cluster, team2_UAT_cluster"

* Verify permissions API shows "elastic_agent_profile" "view" list has only "team1_UAT_test_profile, team2_UAT_test_profile"
* Verify permissions API shows "elastic_agent_profile" "administer" list has only "team1_UAT_test_profile, team2_UAT_test_profile"




Teardown of contexts
____________________
* Logout - from any page
* Capture go state "ElasticAgentsWithPolicy" - teardown
