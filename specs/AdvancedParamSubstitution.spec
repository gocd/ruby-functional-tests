AdvancedParamSubstitution
=========================

Setup of contexts
* Basic Configuration - setup
* Using pipeline "parent_pipeline" - setup
* With "2" live agents - setup
* Capture go state "AdvancedParamSubstitution" - setup

AdvancedParamSubstitution
-------------------------

tags: Parameters_subsitution, wip

* Start add new pipeline in pipeline group "basic"

* Enter new pipeline name as "child_pipeline"
* Select material type as "Pipeline"
* Set pipeline and stage "parent_pipeline" "second_stage"
* Set stage name as "stage_for_rake_target"
* Mark stage manual - On new pipeline wizard
* Set job name as "job_for_rake_target"
* Save pipeline "child_pipeline" successfully

* Verify pipeline created successfully
* Open "Parameters" tab - On Pipeline settings page

* Add parameter name "mingle_uri" and value "https://mingle09.thoughtworks.com"
* Add parameter name "mingle_project_identifier" and value "go"
* Add parameter name "mql_grouping_condition" and value "Status > 'In Dev'"
* Add parameter name "custom_command" and value "echo"
* Add parameter name "arguments" and value "this is a custom command output"
* Add parameter name "working_directory" and value "."
* Add parameter name "rake_build_file" and value "Rakefile"
* Add parameter name "rake_target" and value "wait_for_stopjob_file"
* Add parameter name "rake_directory" and value "git/rake"
* Add parameter name "ant_build_file" and value "build.xml"
* Add parameter name "ant_target" and value "longsleep"
* Add parameter name "ant_directory" and value "hg/dev"
* Add parameter name "label_template" and value "go-version-${COUNT}"
* Add parameter name "cron_time_specification" and value "0 0 12 * * ?"
 Enter material url of identifier "material_for_parent_pipeline" for parameter name "subversion_material_url"
* Add parameter name "subversion_user_name" and value "first_user"
* Add parameter name "subversion_password" and value "password"
* Add parameter name "subversion_destination_directory" and value "svn"
* Add parameter name "value_to_be_used_by_env_variable" and value "substituted value"
* Save Pipeline settings
 Verify saved successfully

 Add environment variable "PIPELINE_VARIABLE_USING_VALUE_FROM_PARAM" with value "#{value_to_be_used_by_env_variable}" to pipeline "child_pipeline"
 Add environment variable "STAGE_VARIABLE_USING_VALUE_FROM_PARAM" with value "#{value_to_be_used_by_env_variable}" to stage "stage_for_ant_target"

* On Admin page
 Open "Pipelines" tab

 Edit pipeline "child_pipeline"

 Enter "#{cron_time_specification}" for cron time specifier
 Enter "#{label_template}" for label template
 Click save - Already On General Options Page
 Verify saved successfully - Already On General Options Page
 Go to project management page

 Select mingle option for tracking tool
 Enter "#{mingle_uri}" for mingle uRL
 Enter "#{mingle_project_identifier}" for mingle project identifier
 Enter "#{mql_grouping_condition}" for mQA grouping conditions
 Click save - Already On Project Management Page
 Go to materials page

 Open stage listing page - Already on material listing page

 Open new add stage details page

 Enter for stage name "deploy"
 Select "manual" for stage trigger
 Enter for job name "deploy_job"
 Select "More..." as task type
 Enter as command "#{custom_command}"
 Enter as arguments "#{arguments}"
 Add stage

 Verify that stage saved successfully
 Open stage "deploy"

 Open jobs

 Open job "deploy_job"

 Open tasks

 Open new task form "Rake"

 Set "task[buildFile](text_field):#{rake_build_file}" - Already on Task edit popup
 Set "task[target](text_field):#{rake_target}" - Already on Task edit popup
 Set "task[workingDirectory](text_field):#{rake_directory}" - Already on Task edit popup
 Save and verify saved successfully

 Open new task form "Ant"

 Set "task[buildFile](text_field):#{ant_build_file}" - Already on Task edit popup
 Set "task[target](text_field):#{ant_target}" - Already on Task edit popup
 Set "task[workingDirectory](text_field):#{ant_directory}" - Already on Task edit popup
 Save and verify saved successfully

 Open home for pipeline "child_pipeline"

 Open material listing page

 Open new subversion material creation popup

 Enter material name "svn_material_name"
 Enter url "#{subversion_material_url}"
 Enter username "#{subversion_user_name}"
 Enter password "#{subversion_password}"
 Enter destination directory "#{subversion_destination_directory}"
 Set poll for changes as "false"
 Click save - Already on Subversion Material Add Popup

 Open new git material creation popup

 Enter material name "git_material_name" - Already on git material creation popup
 Enter url "#{git_material_url}" - Already on git material creation popup
 Enter destination directory "#{git_destination_directory}" - Already on git material creation popup
 Set poll for changes as "false" - Already on git material creation popup
 Click save - Already on git material creation popup

 Verify that material saved successfully
 Open new mercurial material creation popup

 Enter material name "hg_material_name" - Already on Mercurial Material Creation Popup
 Enter url "#{hg_material_url}" - Already on Mercurial Material Creation Popup
 Enter destination directory "#{hg_destination_directory}" - Already on Mercurial Material Creation Popup
 Set poll for changes as "false" - Already on Mercurial Material Creation Popup
 Click save - Already on Mercurial Material Creation Popup

 Verify that material saved successfully

 On Pipeline Dashboard Page
 Looking at pipeline "parent_pipeline"
 Trigger pipeline
 Verify stage "1" is "Passed" on pipeline with label "1"
 Navigate to stage "first_stage" of run "1"

 Trigger stage "second_stage"

 On Pipeline Dashboard Page
 Looking at pipeline "parent_pipeline"
 Verify stage "2" is "Passed" on pipeline with label "1"
 Looking at pipeline "child_pipeline"
 Unpause pipeline
 Trigger pipeline

 Verify stage "1" is "Passed" on pipeline with label "go-version-1"
 Navigate to stage "stage_for_ant_target" of run "1"

 Trigger stage "deploy"

 On Pipeline Dashboard Page
 Looking at pipeline "child_pipeline"
 Verify stage "2" is "Passed" on pipeline with label "go-version-1"
 Navigate to stage "stage_for_ant_target" of run "1"

 Navigate to job "job_for_ant_target"

 Open console tab
 Verify console contains "setting environment variable 'PIPELINE_VARIABLE_USING_VALUE_FROM_PARAM' to value 'substituted value'"
 Verify console contains "setting environment variable 'STAGE_VARIABLE_USING_VALUE_FROM_PARAM' to value 'substituted value'"

 On Pipeline Dashboard Page
 Looking at pipeline "child_pipeline"
 Open trigger with options

 Switch to "Environment Variables" tab
 Override variable named "PIPELINE_VARIABLE_USING_VALUE_FROM_PARAM" with value "value_overridden_by_trigger_with_options"
 Trigger

 On Pipeline Dashboard Page
 Looking at pipeline "child_pipeline"
 Verify stage "1" is "Passed" on pipeline with label "go-version-2"
 Navigate to stage "stage_for_ant_target" of run "2"

 Trigger stage "deploy"

 On Pipeline Dashboard Page
 Looking at pipeline "child_pipeline"
 Verify stage "2" is "Passed" on pipeline with label "go-version-2"
 Navigate to stage "stage_for_ant_target" of run "2"

 Navigate to job "job_for_ant_target"

Open console tab
Verify console contains "setting environment variable 'STAGE_VARIABLE_USING_VALUE_FROM_PARAM' to value 'substituted value'"
Verify console contains " overriding environment variable 'PIPELINE_VARIABLE_USING_VALUE_FROM_PARAM' with value 'value_overridden_by_trigger_with_options'"


Teardown of contexts
____________________
Capture go state "AdvancedParamSubstitution" - teardown
With "2" live agents in directory "ParamSubstitution" - teardown
Using pipeline "parent_pipeline" - teardown
Basic configuration - teardown
