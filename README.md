[![Gauge Badge](https://cdn.rawgit.com/getgauge/getgauge.github.io/master/Gauge_Badge.svg)](https://gauge.org)

## Pre-Requisites (with versions tested on)

* Ruby 2.7.6
* Bundler 2.1.4
* [Gauge](https://gauge.org/index.html) 1.4.3
* gauge-ruby plugin (depends on the version of gauge used):
  * You might have to run `bundle update` to get the right version. Look inside `vendor/bundle` to find the correct, installed version and don't depend on the output of `gauge --version`.
* Firefox >= 45.0 (verified with Firefox 95)
* [geckodriver](https://github.com/mozilla/geckodriver/releases) 0.30.0 (or whatever the appropriate version is for your Firefox version)
  * On Mac you can `brew install geckodriver` for latest version 
* jq
* Whatever requirements are needed for building and running GoCD Server
  * Check the main repo [.tool-versions](https://github.com/gocd/gocd/blob/master/.tool-versions) for an indication

## Setup

```
# Make sure these are sibling directories.
git clone https://github.com/gocd/ruby-functional-tests ruby-functional-tests
git clone https://github.com/gocd/gocd gocd
git clone https://github.com/gocd/go-plugins go-plugins

cd ruby-functional-tests
gauge install
```

## Prepare and run specs

1. Build GoCD server and agent zip installers:

    ```
    cd gocd
    ./gradlew clean installers:agentGenericZip installers:serverGenericZip test:test-addon:assemble
    ```

2. Build GoCD plugins API library:

    ```
    cd gocd
    ./gradlew -PfastBuild --parallel --max-workers 2 plugin-infra:go-plugin-api:publishToMavenLocal plugin-infra:go-plugin-api-internal:publishToMavenLocal installers:versionFile
    ```

3. Build GoCD plugins:

    ```
    cd go-plugins
    ./gradlew clean assemble copyJarsToOnePlace -PgoVersion=$(jq '.go_full_version' -r ../gocd/installers/target/distributions/meta/version.json)
    ```

4. Install Ruby gems for functional tests:

    ```
    cd ruby-functional-tests
    bundle install
    ```

5. Clean and prepare server and agent for functional tests:

    ```
    cd ruby-functional-tests
    bundle exec rake GO_VERSION='X.x.x' clean_test server:prepare agent:prepare
    ```

    You can find the right version to use for `GO_VERSION` by checking the zip installers created in step 1 above, in: `gocd/installers/target/distributions/zip`. If the installer created is: `go-server-20.4.0-11553.zip`, then `GO_VERSION` should be set to `20.4.0`.

6. To run all specs:

    ```
    cd ruby-functional-tests
    bundle exec rake GO_VERSION='X.x.x' GAUGE_TAGS='<spec tags to run>' test
    ```

7. To run specific task(s), execute this command

    ```
    cd ruby-functional-tests
    bundle exec rake [kill/clean/prepare/test/bump-schema] GO_VERSION='X.x.x' GAUGE_TAGS='<spec tags to run>'
    ```

    * `kill` - Kills all running processes spun by the tests.
    * `clean_test` - Cleans all directories (`ruby-functional-tests/target`, `ruby-functional-tests/reports`).
    * `prepare` - Initializes the filesystem to run tests.
    * `test` - Runs the gauge tests with specified tags.
    * `bump-schema` - Bump up schema version. Example: `VERSION=99 rake bump-schema`


## Potential troubleshooting tips:

### 1. Check that the GoCD server has started

- Ensure that you have run the prepare step above, so that the server and agent are ready to be started.

- Try and access http://localhost:8253

- Check the logs in: `target/go-server-*/logs`

### 2. Check resource/with-java.sh

- It uses jabba to install Java if needed. Make sure that the version of Java being used is correct.

### 3. Ensure that you have the right version of gauge-ruby installed.

If you have the wrong version, it might show up like this:

```shell
$ bundle exec rake test GO_VERSION='20.4.0' GAUGE_TAGS='my-tags'
bundle exec gauge --tags 'duck' run specs
warning: parser/current is loading parser/ruby26, which recognizes
warning: 2.6.0-dev-compliant syntax, but you are running 2.6.5.
warning: please see https://github.com/whitequark/parser#compatibility-with-ruby-mri.
/path/to/ruby-functional-tests/vendor/bundle/ruby/2.6.0/gems/gauge-ruby-0.5.2/lib/connector.rb:34:in `initialize': Can't assign requested address - connect(2) for "127.0.0.1" port 0 (Errno::EADDRNOTAVAIL)
	from /path/to/ruby-functional-tests/vendor/bundle/ruby/2.6.0/gems/gauge-ruby-0.5.2/lib/connector.rb:34:in `open'
	from /path/to/ruby-functional-tests/vendor/bundle/ruby/2.6.0/gems/gauge-ruby-0.5.2/lib/connector.rb:34:in `make_connection'
	from /path/to/ruby-functional-tests/vendor/bundle/ruby/2.6.0/gems/gauge-ruby-0.5.2/lib/gauge_runtime.rb:84:in `<module:Runtime>'
	from /path/to/ruby-functional-tests/vendor/bundle/ruby/2.6.0/gems/gauge-ruby-0.5.2/lib/gauge_runtime.rb:33:in `<module:Gauge>'
	from /path/to/ruby-functional-tests/vendor/bundle/ruby/2.6.0/gems/gauge-ruby-0.5.2/lib/gauge_runtime.rb:31:in `<top (required)>'
	from -e:1:in `require'
	from -e:1:in `<main>'
Error occurred while waiting for runner process to finish.
Error : exit status 1
Error ----------------------------------

[ruby]
Ruby runner Failed. Reason: exit status 1

[Gauge]
Failed to start gauge API: Timed out connecting to ruby

Get Support ----------------------------
	Docs:          https://docs.gauge.org
	Bugs:          https://github.com/getgauge/gauge/issues
	Chat:          https://spectrum.chat/gauge

Your Environment Information -----------
	darwin, 1.0.8
	html-report (4.0.10), ruby (0.5.3), screenshot (0.0.1)
```

You can see in the above output that the version of gauge-ruby in `vendor/bundle` is `gauge-ruby-0.5.2` and the version Gauge seems to be expect is `0.5.3` (that you can see in the "Your Environment Information" section at the end).


## License

```plain
Copyright 2022 Thoughtworks, Inc.

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
