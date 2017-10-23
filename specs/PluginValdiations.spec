PluginValidations
=================

Setup of contexts
* Basic Configuration - setup
* Capture go state "PluginValidations" - setup

PluginValidations
-----------------

tags: Plugin Validations, plugins-tests

* On Plugins page

* Verify plugin with id "invalid-xml-plugin.jar" is marked as invalid with message "Plugin with ID (invalid-xml-plugin.jar) is not valid: XML Schema validation of Plugin Descriptor(plugin.xml) failed."
* Verify plugin with id "plugin-with-invalid-id.jar" is marked as invalid with message "Plugin with ID (plugin-with-invalid-id.jar) is not valid: XML Schema validation of Plugin Descriptor(plugin.xml) failed."
* Verify plugin with id "plugin-with-multiple-load-methods.jar" is marked as invalid with message "Class [PluginWithMultipleLoadMethods] is annotated with @Extension will not be registered. Reason: java.lang.RuntimeException: More than one method with @Load annotation not allowed."
* Verify multiple method loads for plugin id "plugin-with-multiple-load-methods.jar"  are "com.tw.qa.plugin.sample.PluginWithMultipleLoadMethods.onLoad(com.thoughtworks.go.plugin.api.info.PluginContext), com.tw.qa.plugin.sample.PluginWithMultipleLoadMethods.duplicateLoad(com.thoughtworks.go.plugin.api.info.PluginContext)"


Teardown of contexts
____________________
* Capture go state "PluginValidations" - teardown
