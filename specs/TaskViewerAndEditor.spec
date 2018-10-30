
TaskViewerAndEditor
===================  
Setup of contexts
* Basic Configuration - setup
* Using pipeline "pipeline-ls" - setup
* Capture go state "TaskViewerAndEditor" - setup
    

TaskViewerAndEditor
-------------------

tags: Clicky Admin

* On Job settings page of pipeline "pipeline-ls" stage "defaultStage" job "defaultJob"

* setTask
     |TaskType|Target            |BuildFile    |WorkingDirectory                                                           |RunIf-View    |
     |--------|------------------|-------------|---------------------------------------------------------------------------|--------------|
     |Ant     |compile test      |build.xml    |working/directory/very/very/very/deep/down/in/our/current/working/directory|Failed,Passed |
     |Rake    |test deploy       |RakeFile     |pwd                                                                        |Failed,Passed |
     |NAnt    |clean build deploy|default.build|windows\directory\in\the\super\windows                                     |Failed,Passed |

Verify Tasks
* verifyTask
|Order_no|Task Type         |Run If Conditions |Properties                                                         |On Cancel     |
|--------|------------------|------------------|-------------------------------------------------------------------|--------------| 
|3       |Rake              |Failed, Passed    |Build File: RakeFile Target: test deploy Working Directory: pwd    |No            |



Teardown of contexts
____________________
* Capture go state "TaskViewerAndEditor" - teardown
