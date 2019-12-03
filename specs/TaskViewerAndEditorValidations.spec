

TaskViewerAndEditorValidations
==============================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "edit-pipeline" - setup
* Capture go state "TaskViewerAndEditorValidations" - setup

TaskViewerAndEditorValidations
------------------------------

tags: task_validations

* On Job settings page of pipeline "edit-pipeline" stage "defaultStage" job "defaultJob"

* Add task "Ant"
* Set Working directory as "../../should/fail"
* Save Changes
* Verify error message "Task of job 'defaultJob' in stage 'defaultStage' of pipeline '$edit-pipeline$' has path '../../should/fail' which is outside the working directory." is shown - Already On Job Edit Page

* On Job settings page of pipeline "edit-pipeline" stage "defaultStage" job "defaultJob"

* Add task "Ant"
* Set Working directory as "#{a}"
* Save Changes
* Verify error message "Parameter 'a' is not defined. All pipelines using this parameter directly or via a template must define it." is shown - Already On Job Edit Page

* On Job settings page of pipeline "edit-pipeline" stage "defaultStage" job "defaultJob"

* Add task "Rake"
* Set Working directory as "../../should/fail"
* Save Changes
* Verify error message "Task of job 'defaultJob' in stage 'defaultStage' of pipeline '$edit-pipeline$' has path '../../should/fail' which is outside the working directory." is shown - Already On Job Edit Page

* On Job settings page of pipeline "edit-pipeline" stage "defaultStage" job "defaultJob"

* Add task "Rake"
* Set Working directory as "#{a}"
* Save Changes
* Verify error message "Parameter 'a' is not defined. All pipelines using this parameter directly or via a template must define it." is shown - Already On Job Edit Page

* On Job settings page of pipeline "edit-pipeline" stage "defaultStage" job "defaultJob"

* Add task "NAnt"
* Set Working directory as "../../should/fail"
* Save Changes
* Verify error message "Task of job 'defaultJob' in stage 'defaultStage' of pipeline '$edit-pipeline$' has path '../../should/fail' which is outside the working directory." is shown - Already On Job Edit Page

* On Job settings page of pipeline "edit-pipeline" stage "defaultStage" job "defaultJob"

* Add task "NAnt"
* Set Working directory as "#{a}"
* Save Changes
* Verify error message "Parameter 'a' is not defined. All pipelines using this parameter directly or via a template must define it." is shown - Already On Job Edit Page


Teardown of contexts
____________________
* Capture go state "TaskViewerAndEditorValidations" - teardown
