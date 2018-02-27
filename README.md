[![Gauge
Badge](https://cdn.rawgit.com/getgauge/getgauge.github.io/master/Gauge_Badge.svg)](http://getgauge.io)

## Pre-Requisites(with versions tested on)
* Java 8
* Ruby >= 2.3.3
* Rake 12.0.0
* Bundler 1.14.6
* [Node](https://nodejs.org/en/) v6.10.1
* [Gauge](http://getgauge.io) 0.9.6
* Gauge-ruby plugin 0.4.2
* Firefox >= 45.0
* geckodriver 0.19.1

## Setup
* ``` git clone``` as a sibling directory to
  [go.cd](https://github.com/gocd/gocd) and [go-plugins](https://github.com/gocd/go-plugins)
* ```$ cd ruby-functional-tests```
* ```$ gauge --install-all```

## Prepare and run specs

* cd to ```ruby-functional-tests``` and run : ```$ bundle install --path=vendor/bundle```
* To clean, build, prepare and run specs, execute this command ```bundle exec rake GO_VERSION='X.x.x' GAUGE_TAGS='<spec tags to run>'```
* To run specific task(s), execute this command ```bundle exec rake [kill/clean/build_all/prepare/test/bump-schema] GO_VERSION='X.x.x' GAUGE_TAGS='<spec tags to run>'```
    * `kill` - Kills all running processes spun by the tests.
    * `clean` - Cleans all directories (`ruby-functional-tests/target`, `ruby-functional-tests/reports`, `gocd`, `go-plugins`).
    * `build_all` - Builds server, agent, plugins and test-addons if running in development mode.
    * `prepare` - Initializes the filesystem to run tests.
    * `test` - Runs the gauge tests with specified tags. 
    * `bump-schema` - Bump up schema version. Example: `VERSION=99 rake bump-schema`

## License

```plain
Copyright 2018 ThoughtWorks, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
