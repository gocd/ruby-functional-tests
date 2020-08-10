MaterialsSPAWithModifications
============

Setup of contexts
* Materials configuration - setup
* Login as "admin" - setup
* Using pipeline "pipeline2" - setup
* Capture go state "MaterialsSPAWithModifications" - setup

MaterialsSPAWithModifications
------------------------

tags: spa, materials, modifications

* Looking at pipeline "pipeline2" - On Swift Dashboard page
* With material "git-repo" of type "git" for pipeline "pipeline2"

* On Materials Page
* Verify there are "1" materials shown
* Verify "git-repo" has no modifications

* Checkin file "foo.txt" as user "user" with message "Comment user" - On Swift Dashboard page
* Trigger material update for "git-repo"
* Wait for "10" seconds
* Verify "git-repo" has latest modification as "Comment user"
* Verify material modifications for "git-repo"
  |index|comment        |
  |-----|---------------|
  |1    |Comment user   |

* Reload page
* Checkin file "bar.txt" as user "loser" with message "Comment loser" - On Swift Dashboard page
* Trigger material update for "git-repo"
* Wait for "10" seconds
* Verify "git-repo" has latest modification as "Comment loser"
* Verify material modifications for "git-repo"
  |index|comment        |
  |-----|---------------|
  |1    |Comment loser  |
  |2    |Comment user   |

Teardown of contexts
____________________
* Capture go state "MaterialsSPAWithModifications" - teardown
* Logout - from any page
