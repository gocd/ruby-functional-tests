

MaterialCheckConnectivity
=========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "edit-pipeline" - setup
* Capture go state "MaterialCheckConnectivity" - setup

MaterialCheckConnectivity
-------------------------

tags: Clicky admin

* On Swift Dashboard Page
* Looking at pipeline "edit-pipeline" - On Swift Dashboard page
* Edit pipeline "edit-pipeline"


* Open "Materials" tab - On Pipeline settings page

* Edit material "git"
* Check connectivity should be successful - Already on Git Material Creation Popup

* On Swift Dashboard Page
* Looking at pipeline "edit-pipeline" - On Swift Dashboard page
* With material "git" of type "git" for pipeline "edit-pipeline"
* Edit pipeline "edit-pipeline"
* Open "Parameters" tab - On Pipeline settings page
* Add parameter name "url" and value "$current_material_url$"
* Save Changes


* On Swift Dashboard Page
* Looking at pipeline "edit-pipeline" - On Swift Dashboard page
* Edit pipeline "edit-pipeline"

* Open "Materials" tab - On Pipeline settings page
* Edit material "git"

* Set url "foo" for material "git" - On material popup
* Check connectivity should be failed - Already on Git Material Creation Popup

* Set url "#{url}" for material "git" - On material popup
* Check connectivity should be successful - Already on Git Material Creation Popup



Teardown of contexts
____________________
* Capture go state "MaterialCheckConnectivity" - teardown
