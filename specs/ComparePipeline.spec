ComparePipeline
===============

Setup of contexts
* Basic Configuration - setup
* Using pipeline "up, down" - setup
* With "1" live agents - setup
* Capture go state "ComparePipeline" - setup

ComparePipeline
---------------

tags: compare_pipeline

* On Swift Dashboard Page
* Looking at pipeline "up" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* Click pipeline compare link

* Verify that to pipeline textbox is populated with "1"
* Verify that from pipeline textbox is populated with "1"

* Looking at pipeline "up" - On Swift Dashboard page
* Checkin file "foo.txt" as user "user" with message "Comment user" - On Swift Dashboard page
* Remember current version as "FIRST_REVISION"

* Checkin file "bar.txt" as user "luser" with message "Comment loser" - On Swift Dashboard page
* Remember current version as "SECOND_REVISION"

* Looking at pipeline "up" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page

* Looking at pipeline "down" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "1" - On Swift Dashboard page

* Looking at pipeline "up" - On Swift Dashboard page
* Click pipeline compare link

* Verify that to pipeline textbox is populated with "2"
* Verify that from pipeline textbox is populated with "1"

* Looking at pipeline "up" - On Swift Dashboard page
* Checkin file "foo1.txt" as user "user" with message "second checkin comment" - On Swift Dashboard page
* Remember current version as "THIRD_REVISION"

* On Swift Dashboard Page
* Looking at pipeline "up" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "3" - On Swift Dashboard page

* Looking at pipeline "down" - On Swift Dashboard page
* Trigger pipeline - On Swift Dashboard page
* Wait till pipeline completed - On Swift Dashboard page
* Verify stage "defaultStage" is "Passed" on pipeline with label "2" - On Swift Dashboard page

* Looking at pipeline "up" - On Swift Dashboard page
* Click pipeline compare link

Exact matching labels
* Verify that from pipeline textbox is populated with "2"
* Verify that to pipeline textbox is populated with "3"

* Search for "1" on from pipeline textbox
* Click on label "1" in the dropdown

* Verify that from pipeline textbox is populated with "1"
* Verify that to pipeline textbox is populated with "3"


Match revision
* Search for revision "SECOND_REVISION" on to pipeline textbox
* Click on label "2" in the dropdown

* Verify that to pipeline textbox is populated with "2"
* Verify that from pipeline textbox is populated with "1"


Match partial user
* Search for "user" on from pipeline textbox
* Verify dropdown has labels "3,2"
* Click on label "2" in the dropdown
* Verify that to pipeline textbox is populated with "2"
* Verify that from pipeline textbox is populated with "2"

Match triggered user
* Search for "anony" on from pipeline textbox
* Verify dropdown has labels "1"
* Click on label "1" in the dropdown

Match partial comment
* Search for "comm" on to pipeline textbox
* Verify dropdown has labels "3,2"
* Click on label "3" in the dropdown
* Verify that to pipeline textbox is populated with "3"
* Verify that from pipeline textbox is populated with "1"


Downstream
* On Swift Dashboard Page
* Looking at pipeline "down" - On Swift Dashboard page
* Click pipeline compare link

* Verify that to pipeline textbox is populated with "2"
* Verify that from pipeline textbox is populated with "1"

* Search for "2" on to pipeline textbox
* Click on label "1" in the dropdown


Teardown of contexts
____________________
* Capture go state "ComparePipeline" - teardown
* With "1" live agents - teardown


