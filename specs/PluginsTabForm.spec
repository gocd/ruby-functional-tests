PluginsTabForm
==============

Setup of contexts
* Smoke Configuration - setup
* Login as "admin" - setup
* Capture go state "PluginsTabForm" - setup

PluginsTabForm
--------------

tags: plugins-tests, plugins_spa, spa

* On Plugins page

* Verify plugin with identifier "Password File Authentication Plugin for GoCD" is valid
* Verify plugin with identifier "Password File Authentication Plugin for GoCD" name "Password File Authentication Plugin for GoCD" description "GoCD Authorization plugin for file based password authentication" author "Thoughtworks, Inc." with enabled link to "https://github.com/gocd/gocd-filebased-authentication-plugin"
* Verify plugin with identifier "Password File Authentication Plugin for GoCD" has path "/plugins/bundled/gocd-filebased-authentication-plugin.jar" supported OS "No restrictions" target go version "20.9.0" and bundled status as "Yes"

* Verify plugin with identifier "Yum Plugin" is valid
* Verify plugin with identifier "Yum Plugin" name "Yum Plugin" description "Plugin that polls a yum repository" author "Thoughtworks, Inc." with enabled link to "https://github.com/gocd/gocd-yum-repository-poller-plugin"
* Verify plugin with identifier "Yum Plugin" has path "/plugins/bundled/gocd-yum-repository-poller-plugin.jar" supported OS "Linux" target go version "15.2.0" and bundled status as "Yes"

* Verify plugin with identifier "Example Elastic Agent Plugin" is valid
* Verify plugin with identifier "Example Elastic Agent Plugin" name "Example Elastic Agent Plugin" description "Some longer description of your plugin goes here" author "Acme Corp" with enabled link to "https://github.com/user/repository"
* Verify plugin with identifier "Example Elastic Agent Plugin" has path "/plugins/external/elastic-agent-skeleton-plugin.jar" supported OS "No restrictions" target go version "19.3.0" and bundled status as "No"

* Verify plugin with identifier "test-plugin-xml" is marked as invalid with message "Plugin with ID ([test-plugin-xml]) is not valid: Incompatible with current operating system 'Linux'. Valid operating systems are: [Windows]."
* Verify invalid plugin with identifier "test-plugin-xml" name "(Not specified)" description "Plugin that has only some fields in its plugin.xml" author "(Not specified)"
* Verify invalid plugin with identifier "test-plugin-xml" has path "test-with-some-plugin-xml-values.jar" supported OS "Windows" and bundled status as "No"

* Verify plugin with identifier "Do nothing plugin" is valid
* Verify plugin with identifier "Valid innerclass plugin" is valid
* Verify plugin with identifier "Valid subclass plugin" is valid
* Verify plugin with identifier "Valid staticclass plugin" is valid

* Verify plugin with identifier "JSON Configuration Plugin" has settings enabled
* Verify plugin with identifier "Example Elastic Agent Plugin" do not show settings option
* Verify plugin with identifier "Valid innerclass plugin" do not show settings option

* Verify plugin with identifier "Example Elastic Agent Plugin" has status report
* Check plugin with identifier "Example Elastic Agent Plugin" status report renders correctly

* On Swift Dashboard Page
* Logout and login as "group1Admin"

* On Plugins page

* Verify plugin with identifier "Password File Authentication Plugin for GoCD" is valid
* Verify plugin with identifier "Password File Authentication Plugin for GoCD" name "Password File Authentication Plugin for GoCD" description "GoCD Authorization plugin for file based password authentication" author "Thoughtworks, Inc." with enabled link to "https://github.com/gocd/gocd-filebased-authentication-plugin"
* Verify plugin with identifier "Password File Authentication Plugin for GoCD" has path "/plugins/bundled/gocd-filebased-authentication-plugin.jar" supported OS "No restrictions" target go version "20.9.0" and bundled status as "Yes"

* Verify plugin with identifier "Yum Plugin" is valid
* Verify plugin with identifier "Yum Plugin" name "Yum Plugin" description "Plugin that polls a yum repository" author "Thoughtworks, Inc." with enabled link to "https://github.com/gocd/gocd-yum-repository-poller-plugin"
* Verify plugin with identifier "Yum Plugin" has path "/plugins/bundled/gocd-yum-repository-poller-plugin.jar" supported OS "Linux" target go version "15.2.0" and bundled status as "Yes"

* Verify plugin with identifier "Example Elastic Agent Plugin" is valid
* Verify plugin with identifier "Example Elastic Agent Plugin" name "Example Elastic Agent Plugin" description "Some longer description of your plugin goes here" author "Acme Corp" with enabled link to "https://github.com/user/repository"
* Verify plugin with identifier "Example Elastic Agent Plugin" has path "/plugins/external/elastic-agent-skeleton-plugin.jar" supported OS "No restrictions" target go version "19.3.0" and bundled status as "No"

* Verify plugin with identifier "test-plugin-xml" is marked as invalid with message "Plugin with ID ([test-plugin-xml]) is not valid: Incompatible with current operating system 'Linux'. Valid operating systems are: [Windows]."
* Verify invalid plugin with identifier "test-plugin-xml" name "(Not specified)" description "Plugin that has only some fields in its plugin.xml" author "(Not specified)"
* Verify invalid plugin with identifier "test-plugin-xml" has path "test-with-some-plugin-xml-values.jar" supported OS "Windows" and bundled status as "No"

* Verify plugin "Plugin 1" is loaded from the bundle "/plugins/external/test-plugin-bundle.jar"
* Verify plugin "Plugin 2" is loaded from the bundle "/plugins/external/test-plugin-bundle.jar"

* Verify plugin with identifier "JSON Configuration Plugin" has settings disabled
* Verify plugin with identifier "Example Elastic Agent Plugin" do not show settings option
* Verify plugin with identifier "Valid staticclass plugin" do not show settings option

Teardown of contexts
____________________
* As user "admin" for teardown
* Capture go state "PluginsTabForm" - teardown
