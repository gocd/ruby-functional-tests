MaterialsSPA
============

Setup of contexts
* Materials configuration - setup
* Login as "admin" - setup
* Capture go state "MaterialsSPA" - setup

MaterialsSPA
------------------------

tags: spa, materials

* On Materials Page
* Verify there are "7" materials shown
* Verify material attributes
  |material_name    | attributes                                                    |
  |---------------- |-------------------------------------------------------------- |
  |git-repo         |URL:git-repo,Branch:master                                     |
  |hg-repo          |URL:hg-repo,Branch:(Not specified)                             |
  |svn-repo         |URL:svn-repo                                                   |
  |p4-repo          |Host and Port:http://p4_repo:9876,View:view                    |
  |tfs-repo         |URL:tfs-server,Domain:(Not specified),Project Path:some-path   |
  |repo-1_go-agent  |Ref:go-agent                                                   |
  |github           |Ref:github                                                     |
* Reload page
* Verify usages for "git-repo" has pipelines "$pipeline-with-all-materials$,$pipeline2$"

* Logout and login as "operate"
* On Materials Page
* Verify there are "1" materials shown
* Verify usages for "git-repo" has pipelines "$pipeline2$"

* Logout and login as "view"
* On Materials Page
* Verify there are "0" materials shown

Teardown of contexts
____________________
* Capture go state "MaterialsSPA" - teardown
* Logout - from any page
