RolesSPA
=========

RolesSPA
-------------------
tags: roles-spa, spa

Setup of contexts
* Ldap server - start
* AuthPluginsConfiguration - setup
* Login as "admin" - setup
* Capture go state "BundledAuthPlugins" - setup

* Go to roles page
* Create a new gocd role "gocd"
* Add user "view_user" to the role
* Save role
* Verify flash message for role "The role gocd was created successfully!"
* Go to roles page
* Verify if role "gocd" is added

* Go to roles page
* Edit role "gocd"
* Add user "user 2" to the role
* Save role
* Verify flash message for role "The role gocd was updated successfully!"
* Go to roles page

* Go to roles page
* Clone role "gocd"
* Set role name as "cloned_gocd"
* Add user "user1" to the role
* Save role
* Verify flash message for role "The role cloned_gocd was created successfully!"
* Go to roles page
* Verify if role "cloned_gocd" is added

* Go to roles page
* Delete role "cloned_gocd"
* Confirm delete role
* Verify flash message for role "The role cloned_gocd was deleted successfully!"
* Go to roles page
* Verify if role "cloned_gocd" is not present


