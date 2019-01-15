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

* Verify plugin with identifier "Password File Authentication Plugin for GoCD" is valid
* Verify plugin with identifier "Password File Authentication Plugin for GoCD" has version "1.0.3-57" name "Password File Authentication Plugin for GoCD" description "GoCD Authorization plugin for file based password authentication" author "GoCD Contributors" with enabled link to "https://github.com/gocd/filebased-authentication-plugin"
* Verify plugin with identifier "Password File Authentication Plugin for GoCD" has path "/plugins/bundled/gocd-filebased-authentication-plugin.jar" supported OS "No restrictions" target go version "18.1.0" and bundled status as "Yes"

* Verify plugin with identifier "Yum Plugin" is valid
* Verify plugin with identifier "Yum Plugin" has version "2.0.3" name "Yum Plugin" description "Plugin that polls a yum repository" author "ThoughtWorks Go Team" with enabled link to "https://www.thoughtworks.com/"
* Verify plugin with identifier "Yum Plugin" has path "/plugins/bundled/gocd-yum-repository-poller-plugin.jar" supported OS "Linux" target go version "15.2.0" and bundled status as "Yes"

* Verify plugin with identifier "Example Elastic Agent Plugin" is valid
* Verify plugin with identifier "Example Elastic Agent Plugin" has version "0.2-SNAPSHOT" name "Example Elastic Agent Plugin" description "Some longer description of your plugin goes here" author "Acme Corp" with enabled link to "https://github.com/user/repository"
* Verify plugin with identifier "Example Elastic Agent Plugin" has path "/plugins/external/elastic-agent-skeleton-plugin.jar" supported OS "No restrictions" target go version "18.2.0" and bundled status as "No"

* Verify plugin with identifier "test-plugin-xml" is marked as invalid with message "Plugin with ID (test-plugin-xml) is not valid: Incompatible with current operating system 'Linux'. Valid operating systems are: [Windows]."

Below steps fail becuase new plugins page do not show values as "Unknown" if they dont exists, need to check where fix is needed

 Verify invalid plugin with identifier "test-plugin-xml" has version "1.0.0" name "test-plugin-xml" description "Plugin that has only some fields in its plugin.xml" author "Unknown" with enabled link to "http://www.mdaliejaz.com/"
 Verify invalid plugin with identifier "test-plugin-xml" has path "test-with-some-plugin-xml-values.jar" supported OS "Windows" target go version "Unknown" and bundled status as "No"

* Verify plugin with identifier "Do nothing plugin" is valid
* Verify plugin with identifier "Valid innerclass plugin" is valid
* Verify plugin with identifier "Valid subcalss plugin" is valid
* Verify plugin with identifier "Valid staticclass plugin" is valid

* Verify plugin with identifier "JSON Configuration Plugin" has settings enabled
* Verify plugin with identifier "Example Elastic Agent Plugin" has settings enabled
* Verify plugin with identifier "test-valid-innerclass-plugin.jar" do not show settings option

* On Swift Dashboard Page
* Logout and login as "group1Admin"

* On Plugins page

* Verify plugin with identifier "Yum Plugin" is valid
* Verify plugin with identifier "Yum Plugin" has version "2.0.3" name "Yum Plugin" description "Plugin that polls a yum repository" author "ThoughtWorks Go Team" with enabled link to "https://www.thoughtworks.com/"
* Verify plugin with identifier "Yum Plugin" has path "/plugins/bundled/gocd-yum-repository-poller-plugin.jar" supported OS "Linux" target go version "15.2.0" and bundled status as "Yes"

* Verify plugin with identifier "Password File Authentication Plugin for GoCD" is valid
* Verify plugin with identifier "Password File Authentication Plugin for GoCD" has version "1.0.3-57" name "Password File Authentication Plugin for GoCD" description "GoCD Authorization plugin for file based password authentication" author "GoCD Contributors" with enabled link to "https://github.com/gocd/filebased-authentication-plugin"
* Verify plugin with identifier "Password File Authentication Plugin for GoCD" has path "/plugins/bundled/gocd-filebased-authentication-plugin.jar" supported OS "No restrictions" target go version "18.1.0" and bundled status as "Yes"

* Verify plugin with identifier "test-plugin-xml" is marked as invalid with message "Plugin with ID (test-plugin-xml) is not valid: Incompatible with current operating system 'Linux'. Valid operating systems are: [Windows]."

* Verify plugin with identifier "Example Elastic Agent Plugin" is valid
* Verify plugin with identifier "Example Elastic Agent Plugin" has version "0.2-SNAPSHOT" name "Example Elastic Agent Plugin" description "Some longer description of your plugin goes here" author "Acme Corp" with enabled link to "https://github.com/user/repository"
* Verify plugin with identifier "Example Elastic Agent Plugin" has path "/plugins/external/elastic-agent-skeleton-plugin.jar" supported OS "No restrictions" target go version "18.2.0" and bundled status as "No"

Below steps fail becuase new plugins page do not show values as "Unknown" if they dont exists

 Verify invalid plugin with id "test-plugin-xml" has version "1.0.0" name "test-plugin-xml" description "Plugin that has only some fields in its plugin.xml" author "Unknown" with enabled link to "http://www.mdaliejaz.com/"
 Verify invalid plugin with id "test-plugin-xml" has path "test-with-some-plugin-xml-values.jar" supported OS "Windows" target go version "Unknown" and bundled status as "No"

* Verify plugin with identifier "JSON Configuration Plugin" has settings disabled
* Verify plugin with identifier "Example Elastic Agent Plugin" has settings disabled
* Verify plugin with identifier "Valid staticclass plugin" do not show settings option

Teardown of contexts
____________________
* As user "admin" for teardown
* Capture go state "PluginsTabForm" - teardown
