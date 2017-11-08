PluginsTabForm
==============

Setup of contexts
* SmokeConfiguration - setup
* Login as "admin" - setup
* Capture go state "PluginsTabForm" - setup

PluginsTabForm
--------------

tags: plugins-tests, plugins_spa, SPA

* On Plugins page

* Verify plugin with id "cd.go.authentication.passwordfile" is valid
* Verify plugin with id "cd.go.authentication.passwordfile" has version "1.0.1-48" name "Password File Authentication Plugin for GoCD" description "GoCD Authorization plugin for file based password authentication" author "GoCD Contributors" with enabled link to "https://github.com/gocd/filebased-authentication-plugin"
* Verify plugin with id "cd.go.authentication.passwordfile" has path "/plugins/bundled/gocd-filebased-authentication-plugin.jar" supported OS "No restrictions" target go version "17.5.0" and bundled status as "Yes"

* Verify plugin with id "yum" is valid
* Verify plugin with id "yum" has version "2.0.3" name "Yum Plugin" description "Plugin that polls a yum repository" author "ThoughtWorks Go Team" with enabled link to "https://www.thoughtworks.com/"
* Verify plugin with id "yum" has path "/plugins/bundled/gocd-yum-repository-poller-plugin.jar" supported OS "Linux" target go version "15.2.0" and bundled status as "Yes"

* Verify plugin with id "test-plugin-xml" is marked as invalid with message "Plugin with ID (test-plugin-xml) is not valid: Incompatible with current operating system 'Mac OS X'. Valid operating systems are: [Windows]."

Below steps fail becuase new plugins page do not show values as "Unknown" if they dont exists, need to check where fix is needed

 Verify invalid plugin with id "test-plugin-xml" has version "1.0.0" name "test-plugin-xml" description "Plugin that has only some fields in its plugin.xml" author "Unknown" with enabled link to "http://www.mdaliejaz.com/"
 Verify invalid plugin with id "test-plugin-xml" has path "test-with-some-plugin-xml-values.jar" supported OS "Windows" target go version "Unknown" and bundled status as "No"

* Verify plugin with id "test-donothing-plugin.jar" is valid
* Verify plugin with id "test-valid-innerclass-plugin.jar" is valid
* Verify plugin with id "test-valid-subclass-plugin.jar" is valid
* Verify plugin with id "test-valid-staticclass-plugin.jar" is valid

* Verify plugin with id "json.config.plugin" has settings enabled
* Verify plugin with id "test-valid-innerclass-plugin.jar" do not show settings option

* Logout and login as "group1Admin"

* On Plugins page

* Verify plugin with id "yum" is valid
* Verify plugin with id "yum" has version "2.0.3" name "Yum Plugin" description "Plugin that polls a yum repository" author "ThoughtWorks Go Team" with enabled link to "https://www.thoughtworks.com/"
* Verify plugin with id "yum" has path "/plugins/bundled/gocd-yum-repository-poller-plugin.jar" supported OS "Linux" target go version "15.2.0" and bundled status as "Yes"

* Verify plugin with id "cd.go.authentication.passwordfile" is valid
* Verify plugin with id "cd.go.authentication.passwordfile" has version "1.0.1-48" name "Password File Authentication Plugin for GoCD" description "GoCD Authorization plugin for file based password authentication" author "GoCD Contributors" with enabled link to "https://github.com/gocd/filebased-authentication-plugin"
* Verify plugin with id "cd.go.authentication.passwordfile" has path "/plugins/bundled/gocd-filebased-authentication-plugin.jar" supported OS "No restrictions" target go version "17.5.0" and bundled status as "Yes"

* Verify plugin with id "test-plugin-xml" is marked as invalid with message "Plugin with ID (test-plugin-xml) is not valid: Incompatible with current operating system 'Linux'. Valid operating systems are: [Windows]."

Below steps fail becuase new plugins page do not show values as "Unknown" if they dont exists

 Verify invalid plugin with id "test-plugin-xml" has version "1.0.0" name "test-plugin-xml" description "Plugin that has only some fields in its plugin.xml" author "Unknown" with enabled link to "http://www.mdaliejaz.com/"
 Verify invalid plugin with id "test-plugin-xml" has path "test-with-some-plugin-xml-values.jar" supported OS "Windows" target go version "Unknown" and bundled status as "No"

* Verify plugin with id "json.config.plugin" has settings disabled
* Verify plugin with id "test-valid-staticclass-plugin.jar" do not show settings option

Teardown of contexts
____________________
* As user "admin" for teardown
* Capture go state "PluginsTabForm" - teardown
