
TaskViewerAndEditorEditFlow
===================  
Setup of contexts
* Basic Configuration - setup
* Using pipeline "edit-pipeline-with-tasks" - setup
* Capture go state "TaskViewerAndEditorEditFlow" - setup
    
TaskViewerAndEditorEditFlow
-------------------

tags: Clicky Admin

* On Job settings page of pipeline "edit-pipeline-with-tasks" stage "defaultStage" job "defaultJob"
* VerifyFieldsOnTaskList
     |TaskIndex|task_build_file|task_target      |task_working_directory|
     |---------|---------------|-----------------|----------------------|
     |1        |               |longsleep        |hg/dev                |
     |2        |               |all              |hg/dev                |
     |3        |               |all              |hg/dev                |


* EditTaskWithOnCancel
     |TaskIndex|task_build_file|task_target|task_working_directory|On_Cancel_TaskType|On_Cancel_Build_File|On_Cancel_Target|On_Cancel_Working_Dir|
     |1        |new file name  |new target |blah/pwd              |Ant               |build.xml           |on cancel       |blah/on/cancel       |
     |2        |rakeFile       |metric-fu  |boooo                 |Rake              |rakeFile            |target          |clean/up/dir         |
     |3        |default.build  |build      |blahaaa               |NAnt              |someotherfile.build |clean           |blahaaa              |


Verify Tasks
* verifyTask
|Order_no|Task Type         |Run If Conditions |Properties                                                                |On Cancel     |
|--------|------------------|------------------|--------------------------------------------------------------------------|--------------| 
|1       |Ant               |Passed            |Build File: new file name Target: new target Working Directory: blah/pwd|Ant           |
|2       |Rake              |Passed            |Build File: rakeFile Target: metric-fu Working Directory: boooo         |Rake          |
|3       |NAnt              |Passed            |Build File: default.build Target: build Working Directory: blahaaa      |NAnt          |


Teardown of contexts
____________________
* Capture go state "TTaskViewerAndEditorEditFlow" - teardown
