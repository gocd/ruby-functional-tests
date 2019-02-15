

TaskReordering
==============

Setup of contexts
* Basic Configuration - setup
* Using pipeline "edit-pipeline-with-tasks" - setup
* Capture go state "TaskReordering" - setup

TaskReordering
--------------

tags: Clicky Admin

* On Job settings page of pipeline "edit-pipeline-with-tasks" stage "defaultStage" job "defaultJob"

* verifyTask
|Order_no|Task Type         |Run If Conditions |Properties                                                         |On Cancel     |
|--------|------------------|------------------|-------------------------------------------------------------------|--------------| 
|1       |Ant               |Passed            |Target: longsleep Working Directory: hg/dev                        |No            |
|2       |Rake              |Passed            |Target: all Working Directory: hg/dev                              |No            |
|3       |NAnt              |Passed            |Target: all Working Directory: hg/dev                              |No            |

* Move down task number "1"

* verifyTask
|Order_no|Task Type         |Run If Conditions |Properties                                                         |On Cancel     |
|--------|------------------|------------------|-------------------------------------------------------------------|--------------| 
|1       |Rake              |Passed            |Target: all Working Directory: hg/dev                              |No            |
|2       |Ant               |Passed            |Target: longsleep Working Directory: hg/dev                        |No            |

* Move up task number "3"
* verifyTask
|Order_no|Task Type         |Run If Conditions |Properties                                                         |On Cancel     |
|--------|------------------|------------------|-------------------------------------------------------------------|--------------| 
|2       |NAnt              |Passed            |Target: all Working Directory: hg/dev                              |No            |
|3       |Ant               |Passed            |Target: longsleep Working Directory: hg/dev                        |No            |






Teardown of contexts
____________________
* Capture go state "TaskReordering" - teardown



